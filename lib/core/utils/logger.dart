import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sakkoja/core/utils/logger_io_stub.dart'
    if (dart.library.io) 'package:sakkoja/core/utils/logger_io_real.dart';

/// Centralized logging utility with Persistence.
/// Use Log.d(), Log.i(), Log.e() etc. instead of print or debugPrint.
class Log {
  static final List<String> _recentLogs = [];
  static final ValueNotifier<List<String>> recentLogsNotifier =
      ValueNotifier<List<String>>([]);

  /// Reset logs and notifier (Call in tests)
  @visibleForTesting
  static void reset() {
    _recentLogs.clear();
    recentLogsNotifier.value = [];
  }

  // Use a dispatcher to allow dynamic addition of FileOutput after initialization
  static final _DispatchOutput _dispatcher = _DispatchOutput([
    ConsoleOutput(),
    _MemoryOutput(), // Keep memory logs for UI debug console
  ]);

  static final Logger _logger = Logger(
    output: _dispatcher,
    filter:
        ProductionFilter(), // Log everything in release too (file filter handles it?)
    level: kDebugMode ? Level.all : Level.warning,
    printer: PrettyPrinter(methodCount: 0),
  );

  /// Initialize file logging (Call in main.dart)
  static Future<void> init() async {
    if (kIsWeb) return; // No file system on Web

    final fileOutput = await LogIo.getFileOutput();
    if (fileOutput != null) {
      _dispatcher.add(fileOutput);
      i('Log: Persistent file logging initialized.');
    }
  }

  /// Updates the global log level for the entire application.
  static void setLevel(Level level) {
    Logger.level = level;
    if (level == Level.debug) {
      d('Debug-tila aktivoitu. Lokien kerääminen aloitettu.');
    }
  }

  static void _addLogToMemory(String message) {
    _recentLogs.add(message);
    if (_recentLogs.length > 50) {
      _recentLogs.removeAt(0);
    }
    // Always update the notifier; ChangeNotifier.notifyListeners handles the case where no listeners exist.
    Future.microtask(() {
      recentLogsNotifier.value = List.from(_recentLogs);
    });
  }

  static void t(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.t(message, error: error, stackTrace: stackTrace);

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error: error, stackTrace: stackTrace);

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error: error, stackTrace: stackTrace);

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);

  static void f(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.f(message, error: error, stackTrace: stackTrace);
}

/// Custom Output that strips ANSI codes for file/memory
class _MemoryOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final cleanLines = _stripAnsi(event.lines);
    for (final line in cleanLines) {
      if (line.isNotEmpty) {
        final timestamp = DateTime.now().toString().substring(11, 19);
        Log._addLogToMemory('[$timestamp] $line');
      }
    }
  }
}

/// Dispatches logs to multiple outputs with buffering and security scrubbing
class _DispatchOutput extends LogOutput {
  _DispatchOutput(this.outputs);
  final List<LogOutput> outputs;
  final List<OutputEvent> _startupBuffer = [];
  bool _fileInitialized = false;

  void add(LogOutput output) {
    outputs.add(output);
    if (output is FileOutput) {
      _fileInitialized = true;
      // Flush startup buffer to the new file output
      Log.d(
        'Log: Flushing ${_startupBuffer.length} buffered startup logs to file.',
      );
      for (final event in _startupBuffer) {
        _sendToFile(output, event);
      }
      _startupBuffer.clear();
    }
  }

  @override
  void output(OutputEvent event) {
    // SECURITY: Scrub sensitive data from ALL logs before any output
    final scrubbedLines = _scrubSensitiveData(event.lines);
    final scrubbedEvent = OutputEvent(event.origin, scrubbedLines);

    for (final o in outputs) {
      if (o is FileOutput) {
        _sendToFile(o, scrubbedEvent);
      } else {
        // Console/Memory (MemoryOutput strips ANSI itself)
        o.output(scrubbedEvent);
      }
    }

    // Buffer for file if not yet initialized
    if (!_fileInitialized) {
      if (_startupBuffer.length < 500) {
        _startupBuffer.add(scrubbedEvent);
      }
    }
  }

  void _sendToFile(FileOutput output, OutputEvent event) {
    // Strip ANSI codes for file readability
    final cleanLines = _stripAnsi(event.lines);
    output.output(OutputEvent(event.origin, cleanLines));
  }
}

List<String> _stripAnsi(List<String> lines) {
  return lines
      .map((line) {
        final clean = line.replaceAll(RegExp(r'\x1B\[[0-9;]*[mK]'), '');
        return clean.replaceAll(RegExp('[┌┐└┘├┤│─]'), '').trim();
      })
      .where((s) => s.isNotEmpty)
      .toList();
}

/// Scrubs sensitive data from log lines before writing to persistent storage.
/// Removes:
/// - Latitude/Longitude coordinates (e.g., "60.1234, 24.5678" -> "[REDACTED_COORDS]")
/// - Bearer tokens (e.g., "Bearer abc123..." -> "Bearer [REDACTED]")
/// - API keys (common patterns)
List<String> _scrubSensitiveData(List<String> lines) {
  return lines.map((line) {
    var scrubbed = line;

    // Scrub coordinate pairs (lat, lon format with decimals)
    // Pattern: two floats separated by comma/space that look like coordinates
    // e.g., "60.1699, 24.9384" or "lat: 60.1699 lon: 24.9384"
    scrubbed = scrubbed.replaceAll(
      RegExp(r'\b[+-]?\d{1,3}\.\d{3,8}\s*[,\s]\s*[+-]?\d{1,3}\.\d{3,8}\b'),
      '[REDACTED_COORDS]',
    );

    // Scrub individual lat/lon with label
    scrubbed = scrubbed.replaceAllMapped(
      RegExp(
        r'(lat(?:itude)?|lon(?:gitude)?)\s*[:=]\s*[+-]?\d{1,3}\.\d{3,8}',
        caseSensitive: false,
      ),
      (m) => '${m.group(1)}: [REDACTED]',
    );

    // Scrub Bearer tokens
    scrubbed = scrubbed.replaceAll(
      RegExp(r'Bearer\s+[A-Za-z0-9_.\-]+'),
      'Bearer [REDACTED]',
    );

    // Scrub common API key patterns (key=value where value looks like a key)
    scrubbed = scrubbed.replaceAllMapped(
      RegExp(
        r'''(api[_-]?key|apikey|token|secret)\s*[:=]\s*["']?[A-Za-z0-9_.\-]{16,}["']?''',
        caseSensitive: false,
      ),
      (m) => '${m.group(1)}=[REDACTED]',
    );

    // Scrub Emails
    scrubbed = scrubbed.replaceAll(
      RegExp(
        r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*",
      ),
      '[REDACTED_EMAIL]',
    );

    // Scrub User-Agent
    scrubbed = scrubbed.replaceAllMapped(
      RegExp(r'(user-agent)\s*[:=]\s*[^\n,]+', caseSensitive: false),
      (m) => '${m.group(1)}: [REDACTED]',
    );

    return scrubbed;
  }).toList();
}
