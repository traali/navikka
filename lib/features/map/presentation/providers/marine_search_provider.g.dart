// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marine_search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MarineQueryController)
final marineQueryControllerProvider = MarineQueryControllerProvider._();

final class MarineQueryControllerProvider
    extends $NotifierProvider<MarineQueryController, String> {
  MarineQueryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marineQueryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marineQueryControllerHash();

  @$internal
  @override
  MarineQueryController create() => MarineQueryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$marineQueryControllerHash() =>
    r'7b73fd5416026d79d04e18f97d10afdff3209363';

abstract class _$MarineQueryController extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(marineSearchResults)
final marineSearchResultsProvider = MarineSearchResultsProvider._();

final class MarineSearchResultsProvider
    extends
        $FunctionalProvider<
          List<MarineSearchResult>,
          List<MarineSearchResult>,
          List<MarineSearchResult>
        >
    with $Provider<List<MarineSearchResult>> {
  MarineSearchResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'marineSearchResultsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$marineSearchResultsHash();

  @$internal
  @override
  $ProviderElement<List<MarineSearchResult>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<MarineSearchResult> create(Ref ref) {
    return marineSearchResults(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MarineSearchResult> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MarineSearchResult>>(value),
    );
  }
}

String _$marineSearchResultsHash() =>
    r'91a958c1da3040ac6d8b04144254cd3083bdea7a';
