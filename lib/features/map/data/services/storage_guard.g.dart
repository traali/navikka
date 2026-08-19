// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_guard.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StorageGuard)
final storageGuardProvider = StorageGuardProvider._();

final class StorageGuardProvider extends $NotifierProvider<StorageGuard, void> {
  StorageGuardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageGuardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageGuardHash();

  @$internal
  @override
  StorageGuard create() => StorageGuard();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$storageGuardHash() => r'5eac47f00c32b09b5efbca06a0e49fc90ac5e000';

abstract class _$StorageGuard extends $Notifier<void> {
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
