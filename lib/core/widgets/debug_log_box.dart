import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/utils/logger.dart';

class DebugLogBox extends StatefulWidget {
  const DebugLogBox({super.key});

  @override
  State<DebugLogBox> createState() => _DebugLogBoxState();
}

class _DebugLogBoxState extends State<DebugLogBox> {
  // Filter state: true = visible
  bool _showInfo = true;
  bool _showWarn = true;
  bool _showError = true;
  bool _showDebug = true;
  bool _autoScroll = true;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      valueListenable: Log.recentLogsNotifier,
      builder: (context, allLogs, _) {
        // Apply filters
        final filteredLogs = allLogs.where((log) {
          if (log.contains('ERROR') || log.contains('error')) return _showError;
          if (log.contains('WARN')) return _showWarn;
          if (log.contains('INFO')) return _showInfo;
          if (log.contains('DEBUG')) return _showDebug;
          return true;
        }).toList();

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(12),
          height: 240, // Slightly taller for controls
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppPalette.canvas.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppPalette.textSecondary.withValues(alpha: 0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: AppPalette.canvas.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.bug_report,
                        size: 14,
                        color: AppPalette.success,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'DEBUG LOGS',
                        style: TextStyle(
                          fontFamily: 'JetBrains Mono',
                          color: AppPalette.success,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      _FilterChip(
                        label: 'E',
                        color: AppPalette.danger,
                        isActive: _showError,
                        onTap: () => setState(() => _showError = !_showError),
                      ),
                      _FilterChip(
                        label: 'W',
                        color: AppPalette.warning,
                        isActive: _showWarn,
                        onTap: () => setState(() => _showWarn = !_showWarn),
                      ),
                      _FilterChip(
                        label: 'I',
                        color: AppPalette.primaryAction,
                        isActive: _showInfo,
                        onTap: () => setState(() => _showInfo = !_showInfo),
                      ),
                      _FilterChip(
                        label: 'D',
                        color: AppPalette.success,
                        isActive: _showDebug,
                        onTap: () => setState(() => _showDebug = !_showDebug),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Copy Button
                      IconButton(
                        icon: const Icon(
                          Icons.copy,
                          size: 14,
                          color: AppPalette.textSecondary,
                        ),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4),
                        tooltip: 'Copy all logs',
                        onPressed: () {
                          final text = allLogs.join('\n');
                          Clipboard.setData(ClipboardData(text: text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Logs copied to clipboard'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      // Auto-scroll toggle
                      IconButton(
                        icon: Icon(
                          _autoScroll
                              ? Icons.vertical_align_bottom
                              : Icons.pause_circle_outline,
                          size: 14,
                          color: _autoScroll
                              ? AppPalette.success
                              : AppPalette.textSecondary,
                        ),
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(4),
                        tooltip: 'Auto-scroll',
                        onPressed: () =>
                            setState(() => _autoScroll = !_autoScroll),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${filteredLogs.length} / ${allLogs.length}',
                        style: TextStyle(
                          fontFamily: 'JetBrains Mono',
                          color: AppPalette.textSecondary.withValues(
                            alpha: 0.6,
                          ),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: AppPalette.textSecondary.withValues(alpha: 0.2),
                height: 12,
              ),
              // Log List
              Expanded(
                child: filteredLogs.isEmpty
                    ? Center(
                        child: Text(
                          'Waiting for logs...',
                          style: TextStyle(
                            fontFamily: 'JetBrains Mono',
                            color: AppPalette.textSecondary.withValues(
                              alpha: 0.4,
                            ),
                            fontSize: 12,
                          ),
                        ),
                      )
                    : ListView.builder(
                        // If auto-scroll is on, we want to stick to the bottom.
                        // However, standard ListView.builder with reverse:true is easiest for "tail" behavior.
                        // But if user turns off auto-scroll, they might want normal scrolling.
                        // For simplicity, we keep reverse: true as "latest first" visual stack is common in debug tools.
                        // Wait, previous implementation had reverse: true.
                        reverse: true,
                        itemCount: filteredLogs.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          // filteredLogs[0] is the oldest if we just took .toList() from existing order?
                          // Log.recentLogs adds to end. So index 0 is oldest.
                          // visual index 0 (bottom) should be latest.
                          // So we access from end.
                          final log =
                              filteredLogs[filteredLogs.length - 1 - index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 1),
                            child: SelectableText(
                              log,
                              style: TextStyle(
                                fontFamily: 'JetBrains Mono',
                                color: _getLogColor(log),
                                fontSize: 10,
                                height: 1.2,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getLogColor(String log) {
    if (log.contains('ERROR') || log.contains('error')) {
      return AppPalette.danger;
    }
    if (log.contains('WARN')) return AppPalette.warning;
    if (log.contains('INFO')) return AppPalette.primaryAction;
    if (log.contains('DEBUG')) return AppPalette.success;
    return AppPalette.textSecondary;
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.color,
    required this.isActive,
    required this.onTap,
  });
  final String label;
  final Color color;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: isActive ? color.withValues(alpha: 0.2) : Colors.transparent,
          border: Border.all(
            color: isActive
                ? color
                : AppPalette.textSecondary.withValues(alpha: 0.25),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'JetBrains Mono',
            color: isActive
                ? color
                : AppPalette.textSecondary.withValues(alpha: 0.6),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
