import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

/// IO-specific initialization for the Logger.
class LogIo {
  static Future<LogOutput?> getFileOutput() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final logFile = File('${dir.path}/app.log');
      final backupFile = File('${dir.path}/app.log.old');

      // Startup Rotation
      if (await logFile.exists()) {
        final length = await logFile.length();
        if (length > 1024 * 1024) {
          if (await backupFile.exists()) {
            await backupFile.delete();
          }
          await logFile.rename(backupFile.path);
        }
      }

      return FileOutput(file: logFile);
    } catch (e) {
      return null;
    }
  }
}
