import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_monitor_provider.g.dart';

@riverpod
Stream<List<ConnectivityResult>> connectivity(Ref ref) {
  return Connectivity().onConnectivityChanged;
}

@riverpod
bool isOnline(Ref ref) {
  final asyncStatus = ref.watch(connectivityProvider);

  if (kIsWeb) {
    // Optimistic on Web: Browsers are usually online, and connectivity_plus
    // can be slow to yield the first result.
    return (asyncStatus.hasValue ? asyncStatus.value : null)?.any(
          (r) => r != ConnectivityResult.none,
        ) ??
        true;
  }

  final status = asyncStatus.hasValue ? asyncStatus.value : null;
  if (status == null) {
    return false;
  }

  return status.any((result) => result != ConnectivityResult.none);
}
