import 'package:flutter/material.dart';
import 'package:sakkoja/core/theme/app_palette.dart';

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    super.key,
    this.message,
    this.isOffline = false,
    this.onRetry,
  });
  final String? message;
  final bool isOffline;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    if (!isOffline && message == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppPalette.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppPalette.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            isOffline ? Icons.wifi_off : Icons.warning_amber_rounded,
            size: 16,
            color: AppPalette.warning,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message ?? (isOffline ? 'Offline Mode' : 'Sync Error'),
              style: const TextStyle(
                color: AppPalette.warning,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (onRetry != null)
            IconButton(
              onPressed: onRetry,
              icon: const Icon(
                Icons.refresh,
                size: 16,
                color: AppPalette.warning,
              ),
              tooltip: 'Yritä uudelleen',
              constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
            ),
        ],
      ),
    );
  }
}
