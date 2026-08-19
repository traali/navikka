// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_download_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OfflineDownloadController)
final offlineDownloadControllerProvider = OfflineDownloadControllerProvider._();

final class OfflineDownloadControllerProvider
    extends $NotifierProvider<OfflineDownloadController, void> {
  OfflineDownloadControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'offlineDownloadControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$offlineDownloadControllerHash();

  @$internal
  @override
  OfflineDownloadController create() => OfflineDownloadController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$offlineDownloadControllerHash() =>
    r'662b06dd4d33af21979d29897476a1310e260c1a';

abstract class _$OfflineDownloadController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
