// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skipper_settings_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(skipperSettingsRepository)
final skipperSettingsRepositoryProvider = SkipperSettingsRepositoryProvider._();

final class SkipperSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SkipperSettingsRepository,
          SkipperSettingsRepository,
          SkipperSettingsRepository
        >
    with $Provider<SkipperSettingsRepository> {
  SkipperSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'skipperSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$skipperSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SkipperSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SkipperSettingsRepository create(Ref ref) {
    return skipperSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SkipperSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SkipperSettingsRepository>(value),
    );
  }
}

String _$skipperSettingsRepositoryHash() =>
    r'cd3f73e31f64f108588e4c18c9464f7bfa92fbb1';
