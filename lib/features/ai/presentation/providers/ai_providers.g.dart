// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weatherAIEdgeService)
final weatherAIEdgeServiceProvider = WeatherAIEdgeServiceProvider._();

final class WeatherAIEdgeServiceProvider
    extends
        $FunctionalProvider<
          WeatherAIEdgeService,
          WeatherAIEdgeService,
          WeatherAIEdgeService
        >
    with $Provider<WeatherAIEdgeService> {
  WeatherAIEdgeServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherAIEdgeServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherAIEdgeServiceHash();

  @$internal
  @override
  $ProviderElement<WeatherAIEdgeService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherAIEdgeService create(Ref ref) {
    return weatherAIEdgeService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherAIEdgeService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherAIEdgeService>(value),
    );
  }
}

String _$weatherAIEdgeServiceHash() =>
    r'dd7efd48ed66824d990c0e57bf4dc4918dd595f5';

@ProviderFor(weatherAuditor)
final weatherAuditorProvider = WeatherAuditorProvider._();

final class WeatherAuditorProvider
    extends $FunctionalProvider<WeatherAuditor, WeatherAuditor, WeatherAuditor>
    with $Provider<WeatherAuditor> {
  WeatherAuditorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherAuditorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherAuditorHash();

  @$internal
  @override
  $ProviderElement<WeatherAuditor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WeatherAuditor create(Ref ref) {
    return weatherAuditor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherAuditor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherAuditor>(value),
    );
  }
}

String _$weatherAuditorHash() => r'faa77b38eaa1555ae19840b926d4da1b82eba3aa';

@ProviderFor(hybridInsightEngine)
final hybridInsightEngineProvider = HybridInsightEngineProvider._();

final class HybridInsightEngineProvider
    extends
        $FunctionalProvider<
          HybridInsightEngine,
          HybridInsightEngine,
          HybridInsightEngine
        >
    with $Provider<HybridInsightEngine> {
  HybridInsightEngineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hybridInsightEngineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hybridInsightEngineHash();

  @$internal
  @override
  $ProviderElement<HybridInsightEngine> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HybridInsightEngine create(Ref ref) {
    return hybridInsightEngine(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HybridInsightEngine value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HybridInsightEngine>(value),
    );
  }
}

String _$hybridInsightEngineHash() =>
    r'07485ab42a0449016c4b56c75ed71e487612234c';

@ProviderFor(skipperSettings)
final skipperSettingsProvider = SkipperSettingsProvider._();

final class SkipperSettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<SkipperSettings>,
          SkipperSettings,
          Stream<SkipperSettings>
        >
    with $FutureModifier<SkipperSettings>, $StreamProvider<SkipperSettings> {
  SkipperSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'skipperSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$skipperSettingsHash();

  @$internal
  @override
  $StreamProviderElement<SkipperSettings> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<SkipperSettings> create(Ref ref) {
    return skipperSettings(ref);
  }
}

String _$skipperSettingsHash() => r'f988a9aa368bf6fb70d8469c8843151713d24ee0';

@ProviderFor(skipperInsight)
final skipperInsightProvider = SkipperInsightProvider._();

final class SkipperInsightProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeatherInsight>,
          WeatherInsight,
          FutureOr<WeatherInsight>
        >
    with $FutureModifier<WeatherInsight>, $FutureProvider<WeatherInsight> {
  SkipperInsightProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'skipperInsightProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$skipperInsightHash();

  @$internal
  @override
  $FutureProviderElement<WeatherInsight> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WeatherInsight> create(Ref ref) {
    return skipperInsight(ref);
  }
}

String _$skipperInsightHash() => r'4ca952fa9ccac86ba4fe1d8f6573d361ccf662f1';

@ProviderFor(SkipperSettingsController)
final skipperSettingsControllerProvider = SkipperSettingsControllerProvider._();

final class SkipperSettingsControllerProvider
    extends $AsyncNotifierProvider<SkipperSettingsController, SkipperSettings> {
  SkipperSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'skipperSettingsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$skipperSettingsControllerHash();

  @$internal
  @override
  SkipperSettingsController create() => SkipperSettingsController();
}

String _$skipperSettingsControllerHash() =>
    r'4f51dab3249e85961a8c5fd658e53ec44561eead';

abstract class _$SkipperSettingsController
    extends $AsyncNotifier<SkipperSettings> {
  FutureOr<SkipperSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SkipperSettings>, SkipperSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SkipperSettings>, SkipperSettings>,
              AsyncValue<SkipperSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Tracks which insight the user has last acknowledged/dismissed.
/// In-memory only for now; when app restarts, user will see alerts again.

@ProviderFor(SkipperInsightAcknowledgment)
final skipperInsightAcknowledgmentProvider =
    SkipperInsightAcknowledgmentProvider._();

/// Tracks which insight the user has last acknowledged/dismissed.
/// In-memory only for now; when app restarts, user will see alerts again.
final class SkipperInsightAcknowledgmentProvider
    extends $NotifierProvider<SkipperInsightAcknowledgment, String?> {
  /// Tracks which insight the user has last acknowledged/dismissed.
  /// In-memory only for now; when app restarts, user will see alerts again.
  SkipperInsightAcknowledgmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'skipperInsightAcknowledgmentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$skipperInsightAcknowledgmentHash();

  @$internal
  @override
  SkipperInsightAcknowledgment create() => SkipperInsightAcknowledgment();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$skipperInsightAcknowledgmentHash() =>
    r'16ea4ef788a21f31c89cece76e6904bcca514bbd';

/// Tracks which insight the user has last acknowledged/dismissed.
/// In-memory only for now; when app restarts, user will see alerts again.

abstract class _$SkipperInsightAcknowledgment extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Keeps a rolling history of the last 20 insights for review.
/// In-memory only; history is lost on app restart.

@ProviderFor(InsightHistory)
final insightHistoryProvider = InsightHistoryProvider._();

/// Keeps a rolling history of the last 20 insights for review.
/// In-memory only; history is lost on app restart.
final class InsightHistoryProvider
    extends $NotifierProvider<InsightHistory, List<WeatherInsight>> {
  /// Keeps a rolling history of the last 20 insights for review.
  /// In-memory only; history is lost on app restart.
  InsightHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'insightHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$insightHistoryHash();

  @$internal
  @override
  InsightHistory create() => InsightHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<WeatherInsight> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<WeatherInsight>>(value),
    );
  }
}

String _$insightHistoryHash() => r'd9a8e60089d5632c9b2837217e476e7b571cb768';

/// Keeps a rolling history of the last 20 insights for review.
/// In-memory only; history is lost on app restart.

abstract class _$InsightHistory extends $Notifier<List<WeatherInsight>> {
  List<WeatherInsight> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<WeatherInsight>, List<WeatherInsight>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<WeatherInsight>, List<WeatherInsight>>,
              List<WeatherInsight>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
