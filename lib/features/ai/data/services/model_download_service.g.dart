// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_download_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ModelDownloadService)
final modelDownloadServiceProvider = ModelDownloadServiceProvider._();

final class ModelDownloadServiceProvider
    extends $NotifierProvider<ModelDownloadService, ModelDownloadState> {
  ModelDownloadServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'modelDownloadServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$modelDownloadServiceHash();

  @$internal
  @override
  ModelDownloadService create() => ModelDownloadService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ModelDownloadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ModelDownloadState>(value),
    );
  }
}

String _$modelDownloadServiceHash() =>
    r'105fd5d1bddf96d392700f1f14b939c493a4c83b';

abstract class _$ModelDownloadService extends $Notifier<ModelDownloadState> {
  ModelDownloadState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ModelDownloadState, ModelDownloadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ModelDownloadState, ModelDownloadState>,
              ModelDownloadState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
