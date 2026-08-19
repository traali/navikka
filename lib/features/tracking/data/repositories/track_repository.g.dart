// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trackRepository)
final trackRepositoryProvider = TrackRepositoryProvider._();

final class TrackRepositoryProvider
    extends
        $FunctionalProvider<TrackRepository, TrackRepository, TrackRepository>
    with $Provider<TrackRepository> {
  TrackRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrackRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TrackRepository create(Ref ref) {
    return trackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackRepository>(value),
    );
  }
}

String _$trackRepositoryHash() => r'2bf828a1e853285e576ba2977b7d4b77460625dd';
