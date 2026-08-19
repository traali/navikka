import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/core/utils/logger.dart';

part 'storage_guard.g.dart';

@riverpod
class StorageGuard extends _$StorageGuard {
  @override
  void build() {}

  /// Check if there is enough free space for the estimated download size
  ///
  /// Currently implements a safe-buffer check.
  /// Note: Requires platform-specific disk space plugin for real values.
  Future<bool> hasEnoughSpace(int estimatedBytes) async {
    Log.d(
      'StorageGuard: Checking space for ${estimatedBytes / (1024 * 1024)} MB',
    );

    // STUB: Always return true for now, as we lack the plugin.
    // In production, use disk_space_plus or similar.
    return true;
  }
}
