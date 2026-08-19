// ignore_for_file: avoid_print
import 'dart:io';

void main() {
  final file = File('assets/data/speed_limits.geojson');
  if (!file.existsSync()) {
    print('File not found: ${file.path}');
    return;
  }

  print('Reading ${file.path} (${file.lengthSync()} bytes)...');
  final bytes = file.readAsBytesSync();

  print('Compressing...');
  final compressed = GZipCodec().encode(bytes);

  final outFile = File('assets/data/speed_limits.geojson.gz');
  outFile.writeAsBytesSync(compressed);

  print('Saved to ${outFile.path} (${outFile.lengthSync()} bytes)');
  print(
    'Compression ratio: ${(outFile.lengthSync() / file.lengthSync() * 100).toStringAsFixed(1)}%',
  );

  // Clean up raw file to save space in bundle
  file.deleteSync();
  print('Deleted raw file: ${file.path}');
}
