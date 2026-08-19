// Architecture Enforcement Script
// Runs in CI to verify code follows AGENTS.md rules
//
// Usage: dart run scripts/architecture_check.dart
//
// ignore_for_file: avoid_print

import 'dart:io';

/// Exit codes
const int success = 0;
const int failure = 1;

/// Forbidden imports that should never appear
const forbiddenImports = [
  'package:hive/',
  'package:hive_flutter/',
  'package:provider/',
  'package:get/',
  'package:getx/',
];

/// Forbidden patterns in lib/ code
const forbiddenPatterns = [
  RegexPattern(r'\bprint\s*\(', 'Use Log.d/i/w/e instead of print()'),
  RegexPattern(r'\bdebugPrint\s*\(', 'Use Log.d/i/w/e instead of debugPrint()'),
];

/// Domain layer should not import Flutter
const domainForbiddenImports = ['package:flutter/', 'dart:ui'];

class RegexPattern {
  const RegexPattern(this.pattern, this.message);
  final String pattern;
  final String message;
}

class Violation {
  const Violation(this.file, this.line, this.message);
  final String file;
  final int line;
  final String message;

  @override
  String toString() => '  $file:$line - $message';
}

void main() async {
  print('🔍 Running Architecture Checks...\n');

  final violations = <Violation>[];

  // Get all Dart files in lib/
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    print('❌ lib/ directory not found');
    exit(failure);
  }

  final dartFiles = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .where((f) => !f.path.endsWith('.g.dart'))
      .where((f) => !f.path.endsWith('.freezed.dart'))
      .toList();

  print('📁 Scanning ${dartFiles.length} Dart files...\n');

  for (final file in dartFiles) {
    final relativePath = file.path.replaceAll(r'\', '/');
    final lines = file.readAsLinesSync();
    final isDomainLayer = relativePath.contains('/domain/');

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final lineNum = i + 1;

      // Check forbidden imports
      for (final forbidden in forbiddenImports) {
        if (line.contains("import '$forbidden") ||
            line.contains('import "$forbidden')) {
          violations.add(
            Violation(
              relativePath,
              lineNum,
              'Forbidden import: $forbidden (see AGENTS.md §2)',
            ),
          );
        }
      }

      // Check domain layer Flutter imports
      if (isDomainLayer) {
        for (final forbidden in domainForbiddenImports) {
          if (line.contains("import '$forbidden") ||
              line.contains('import "$forbidden')) {
            violations.add(
              Violation(
                relativePath,
                lineNum,
                'Domain layer must not import Flutter: $forbidden (see AGENTS.md §1)',
              ),
            );
          }
        }
      }

      // Check forbidden patterns (only in non-generated files)
      for (final pattern in forbiddenPatterns) {
        if (RegExp(pattern.pattern).hasMatch(line)) {
          // Skip if it's in a comment or string
          final trimmed = line.trim();
          if (!trimmed.startsWith('//') && !trimmed.startsWith('*')) {
            violations.add(
              Violation(
                relativePath,
                lineNum,
                '${pattern.message} (see AGENTS.md §12)',
              ),
            );
          }
        }
      }
    }
  }

  // Report results
  if (violations.isEmpty) {
    print('✅ All architecture checks passed!\n');
    print('Verified:');
    print('  • No forbidden imports (hive, provider, getx)');
    print('  • No print/debugPrint usage');
    print('  • Domain layer has no Flutter dependencies');
    exit(success);
  } else {
    print('❌ Found ${violations.length} architecture violation(s):\n');
    for (final v in violations) {
      print(v);
    }
    print('\n📚 Reference: See AGENTS.md for architecture rules');
    exit(failure);
  }
}
