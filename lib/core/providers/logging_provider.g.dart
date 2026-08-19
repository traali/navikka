// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logging_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LogLevel)
final logLevelProvider = LogLevelProvider._();

final class LogLevelProvider extends $NotifierProvider<LogLevel, Level> {
  LogLevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logLevelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logLevelHash();

  @$internal
  @override
  LogLevel create() => LogLevel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Level value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Level>(value),
    );
  }
}

String _$logLevelHash() => r'a8efe83f90d231e939b588360fc0630b618961e2';

abstract class _$LogLevel extends $Notifier<Level> {
  Level build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Level, Level>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Level, Level>,
              Level,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
