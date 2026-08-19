// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_router_service_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Dio provider specifically for OpenRouter (separate base URL, no rate limit conflicts).

@ProviderFor(openRouterDio)
final openRouterDioProvider = OpenRouterDioProvider._();

/// Dio provider specifically for OpenRouter (separate base URL, no rate limit conflicts).

final class OpenRouterDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Dio provider specifically for OpenRouter (separate base URL, no rate limit conflicts).
  OpenRouterDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openRouterDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openRouterDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return openRouterDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$openRouterDioHash() => r'09f22e51c436f4867a516c8b92e3f2e2bb925ae9';

@ProviderFor(openRouterService)
final openRouterServiceProvider = OpenRouterServiceProvider._();

final class OpenRouterServiceProvider
    extends
        $FunctionalProvider<
          OpenRouterService,
          OpenRouterService,
          OpenRouterService
        >
    with $Provider<OpenRouterService> {
  OpenRouterServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openRouterServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openRouterServiceHash();

  @$internal
  @override
  $ProviderElement<OpenRouterService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpenRouterService create(Ref ref) {
    return openRouterService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenRouterService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenRouterService>(value),
    );
  }
}

String _$openRouterServiceHash() => r'd74343cabcffa52c8d87023feccfc1d980dacb23';
