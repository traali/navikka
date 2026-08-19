import 'package:web/web.dart' as web;

/// Web implementation of local check.
bool isWebLocal() {
  final hostname = web.window.location.hostname;
  return hostname == 'localhost' || hostname == '127.0.0.1';
}
