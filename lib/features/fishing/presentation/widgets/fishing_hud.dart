import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_data_providers.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';
import 'package:sakkoja/features/fishing/presentation/widgets/catch_entry_sheet.dart';
import 'package:sakkoja/features/map/presentation/providers/map_provider.dart';
import 'package:sakkoja/features/map/presentation/widgets/fishing_restriction_detail_sheet.dart';

// Sentinel value for popup menu "all categories" selection.
const String kFishingCategoryAllValue = '__all__';

class FishingHUD extends ConsumerWidget {
  const FishingHUD({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final fishingMode = ref.watch(fishingModeControllerProvider).value;
    if (fishingMode == null || !fishingMode.isEnabled) {
      return const SizedBox.shrink();
    }

    final currentRestrictions = ref.watch(currentLocationRestrictionsProvider);

    final topOffset = MediaQuery.paddingOf(context).top + 68;

    return Positioned(
      top: topOffset,
      left: 16,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width > 800
              ? 380
              : MediaQuery.sizeOf(context).width - 32,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: colors.glassBackground.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: currentRestrictions.isNotEmpty
                      ? colors.danger.withValues(alpha: 0.5)
                      : colors.glassBorder,
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color:
                          (currentRestrictions.isNotEmpty
                                  ? colors.danger
                                  : colors.success)
                              .withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      currentRestrictions.isNotEmpty
                          ? Icons.warning_rounded
                          : Icons.check_circle_rounded,
                      color: currentRestrictions.isNotEmpty
                          ? colors.danger
                          : colors.success,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentRestrictions.isNotEmpty
                              ? 'RAJOITUSALUE'
                              : 'VAPAA KALASTUSALUE',
                          style: TextStyle(
                            color: colors.textPrimary.withValues(alpha: 0.6),
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                        Text(
                          currentRestrictions.isNotEmpty
                              ? currentRestrictions.first.title
                              : 'Ei tunnettuja rajoituksia',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (currentRestrictions.isNotEmpty) ...[
                    Consumer(
                      builder: (context, ref, _) {
                        final categoriesAsync = ref.watch(
                          availableRestrictionTypesProvider,
                        );
                        final selectedCategory = ref
                            .watch(fishingModeControllerProvider)
                            .value
                            ?.selectedCategory;

                        return IconButton.filledTonal(
                          onPressed: () async {
                            final categories = categoriesAsync.value ?? [];
                            if (categories.isEmpty) return;

                            final button =
                                context.findRenderObject()! as RenderBox;
                            final overlay =
                                Navigator.of(
                                      context,
                                    ).overlay!.context.findRenderObject()!
                                    as RenderBox;
                            final position = RelativeRect.fromRect(
                              Rect.fromPoints(
                                button.localToGlobal(
                                  Offset.zero,
                                  ancestor: overlay,
                                ),
                                button.localToGlobal(
                                  button.size.bottomRight(Offset.zero),
                                  ancestor: overlay,
                                ),
                              ),
                              Offset.zero & overlay.size,
                            );

                            final result = await showMenu<String>(
                              context: context,
                              position: position,
                              items: [
                                const PopupMenuItem<String>(
                                  value: kFishingCategoryAllValue,
                                  child: Text('Kaikki rajoitukset'),
                                ),
                                for (final cat in categories)
                                  PopupMenuItem<String>(
                                    value: cat,
                                    child: Text(cat),
                                  ),
                              ],
                            );
                            if (result == null) return;

                            ref
                                .read(fishingModeControllerProvider.notifier)
                                .setCategory(
                                  result == kFishingCategoryAllValue
                                      ? null
                                      : result,
                                );
                          },
                          icon: Icon(
                            selectedCategory != null
                                ? Icons.filter_alt_rounded
                                : Icons.filter_alt_outlined,
                          ),
                          style: IconButton.styleFrom(
                            backgroundColor: colors.textPrimary.withValues(
                              alpha: 0.1,
                            ),
                            foregroundColor: colors.textPrimary,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    IconButton.filledTonal(
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (context) => FishingRestrictionDetailSheet(
                            restrictions: currentRestrictions,
                          ),
                        );
                      },
                      icon: const Icon(Icons.info_outline_rounded),
                      style: IconButton.styleFrom(
                        backgroundColor: colors.danger.withValues(
                          alpha: 0.2,
                        ),
                        foregroundColor: colors.danger,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  // Add Fish button - Always visible in Fishing Mode
                  IconButton.filledTonal(
                    onPressed: () {
                      final location = ref.read(mapProvider).userLocation;
                      showModalBottomSheet<void>(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) =>
                            CatchEntrySheet(location: location),
                      );
                    },
                    icon: const Icon(Icons.add_circle_rounded),
                    tooltip: 'Lisää saalis',
                    style: IconButton.styleFrom(
                      backgroundColor: colors.primaryAction.withValues(
                        alpha: 0.2,
                      ),
                      foregroundColor: colors.primaryAction,
                    ),
                  ),
                ],
              ), // Row
            ), // Container
          ), // BackdropFilter
        ), // ClipRRect
      ), // AnimatedContainer
    ); // Positioned
  }
}
