// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vessel_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(vesselDao)
final vesselDaoProvider = VesselDaoProvider._();

final class VesselDaoProvider
    extends $FunctionalProvider<VesselDao, VesselDao, VesselDao>
    with $Provider<VesselDao> {
  VesselDaoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vesselDaoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vesselDaoHash();

  @$internal
  @override
  $ProviderElement<VesselDao> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VesselDao create(Ref ref) {
    return vesselDao(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VesselDao value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VesselDao>(value),
    );
  }
}

String _$vesselDaoHash() => r'efad6c78df9016c3ea59f45dc6043fc6c8ecaabf';

@ProviderFor(vesselService)
final vesselServiceProvider = VesselServiceProvider._();

final class VesselServiceProvider
    extends $FunctionalProvider<VesselService, VesselService, VesselService>
    with $Provider<VesselService> {
  VesselServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vesselServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vesselServiceHash();

  @$internal
  @override
  $ProviderElement<VesselService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VesselService create(Ref ref) {
    return vesselService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VesselService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VesselService>(value),
    );
  }
}

String _$vesselServiceHash() => r'fb498e85362f7a5a76672a047b14f423fbd7c6ba';

@ProviderFor(VesselSettingsController)
final vesselSettingsControllerProvider = VesselSettingsControllerProvider._();

final class VesselSettingsControllerProvider
    extends $AsyncNotifierProvider<VesselSettingsController, VesselEntity?> {
  VesselSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vesselSettingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vesselSettingsControllerHash();

  @$internal
  @override
  VesselSettingsController create() => VesselSettingsController();
}

String _$vesselSettingsControllerHash() =>
    r'9be363c86639f25c5a218e2c5800f80a8872092a';

abstract class _$VesselSettingsController
    extends $AsyncNotifier<VesselEntity?> {
  FutureOr<VesselEntity?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<VesselEntity?>, VesselEntity?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VesselEntity?>, VesselEntity?>,
              AsyncValue<VesselEntity?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
