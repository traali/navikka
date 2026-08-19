import 'package:dio/dio.dart';

/// Dio transformer that runs JSON decoding in a background isolate.
/// This prevents the main thread from freezing during large data fetches.
class FlutterTransformer extends BackgroundTransformer {
  FlutterTransformer();
}
