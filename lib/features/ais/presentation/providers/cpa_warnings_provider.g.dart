// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cpa_warnings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cpaWarnings)
final cpaWarningsProvider = CpaWarningsFamily._();

final class CpaWarningsProvider
    extends
        $FunctionalProvider<List<CpaResult>, List<CpaResult>, List<CpaResult>>
    with $Provider<List<CpaResult>> {
  CpaWarningsProvider._({
    required CpaWarningsFamily super.from,
    required ({LatLng ownPosition, double ownSogKnots, double ownCogDegrees})
    super.argument,
  }) : super(
         retry: null,
         name: r'cpaWarningsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cpaWarningsHash();

  @override
  String toString() {
    return r'cpaWarningsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<List<CpaResult>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<CpaResult> create(Ref ref) {
    final argument =
        this.argument
            as ({LatLng ownPosition, double ownSogKnots, double ownCogDegrees});
    return cpaWarnings(
      ref,
      ownPosition: argument.ownPosition,
      ownSogKnots: argument.ownSogKnots,
      ownCogDegrees: argument.ownCogDegrees,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CpaResult> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CpaResult>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CpaWarningsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cpaWarningsHash() => r'cf99485158ae6bf4a771b38f5e9f32caf260cba0';

final class CpaWarningsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          List<CpaResult>,
          ({LatLng ownPosition, double ownSogKnots, double ownCogDegrees})
        > {
  CpaWarningsFamily._()
    : super(
        retry: null,
        name: r'cpaWarningsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CpaWarningsProvider call({
    required LatLng ownPosition,
    required double ownSogKnots,
    required double ownCogDegrees,
  }) => CpaWarningsProvider._(
    argument: (
      ownPosition: ownPosition,
      ownSogKnots: ownSogKnots,
      ownCogDegrees: ownCogDegrees,
    ),
    from: this,
  );

  @override
  String toString() => r'cpaWarningsProvider';
}
