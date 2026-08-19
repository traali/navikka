// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_active_alerts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getActiveAlerts)
final getActiveAlertsProvider = GetActiveAlertsProvider._();

final class GetActiveAlertsProvider
    extends
        $FunctionalProvider<GetActiveAlerts, GetActiveAlerts, GetActiveAlerts>
    with $Provider<GetActiveAlerts> {
  GetActiveAlertsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getActiveAlertsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getActiveAlertsHash();

  @$internal
  @override
  $ProviderElement<GetActiveAlerts> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetActiveAlerts create(Ref ref) {
    return getActiveAlerts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetActiveAlerts value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetActiveAlerts>(value),
    );
  }
}

String _$getActiveAlertsHash() => r'5cae8715a11d619fcb20695b225b5394205db4ba';
