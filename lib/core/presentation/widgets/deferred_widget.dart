import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';

/// A utility widget that loads a deferred library and builds the widget.
/// Used for code-splitting (deferred loading) to reduce initial bundle size on Web.
class DeferredWidget extends StatefulWidget {
  const DeferredWidget({
    required this.loader,
    required this.builder,
    super.key,
  });

  /// The loader function, e.g., `lib.loadLibrary`.
  final Future<void> Function() loader;

  /// The builder function that returns the widget from the deferred library.
  final Widget Function() builder;

  @override
  State<DeferredWidget> createState() => _DeferredWidgetState();
}

class _DeferredWidgetState extends State<DeferredWidget> {
  Future<void>? _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    setState(() {
      _future = kIsWeb ? Future.value() : widget.loader();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            // Attempt direct builder execution if chunk already in memory
            try {
              return widget.builder();
            } catch (_) {
              return Scaffold(
                backgroundColor: AppPalette.canvas,
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.cloud_off_rounded,
                          size: 48,
                          color: AppPalette.warning,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Sivun lataus epäonnistui',
                          style: AppTextStyles.nvLg,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tarkista verkkoyhteys ja yritä uudelleen.',
                          style: AppTextStyles.nvSm.copyWith(
                            color: AppPalette.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: _load,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Yritä uudelleen'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.primaryAction,
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          return widget.builder();
        }
        // Show a lightweight placeholder while loading the chunk
        return const Scaffold(
          backgroundColor: AppPalette.canvas,
          body: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppPalette.primaryAction,
            ),
          ),
        );
      },
    );
  }
}
