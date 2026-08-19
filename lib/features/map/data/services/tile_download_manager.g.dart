// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile_download_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TileDownloadManager)
final tileDownloadManagerProvider = TileDownloadManagerProvider._();

final class TileDownloadManagerProvider
    extends $NotifierProvider<TileDownloadManager, DownloadState> {
  TileDownloadManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tileDownloadManagerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tileDownloadManagerHash();

  @$internal
  @override
  TileDownloadManager create() => TileDownloadManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadState>(value),
    );
  }
}

String _$tileDownloadManagerHash() =>
    r'336885217c3e3b8c8e24a92a33c6dcf07e1eb967';

abstract class _$TileDownloadManager extends $Notifier<DownloadState> {
  DownloadState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DownloadState, DownloadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DownloadState, DownloadState>,
              DownloadState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
