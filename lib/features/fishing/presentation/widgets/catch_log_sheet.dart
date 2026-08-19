import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_catch.dart';
import 'package:sakkoja/features/fishing/presentation/providers/catch_controller_provider.dart';
import 'package:sakkoja/features/fishing/presentation/utils/fishing_presentation_utils.dart';
import 'package:sakkoja/features/fishing/presentation/widgets/catch_detail_sheet.dart';
import 'package:sakkoja/features/map/presentation/widgets/glass_icon_button.dart';

class CatchLogSheet extends ConsumerStatefulWidget {
  const CatchLogSheet({super.key});

  @override
  ConsumerState<CatchLogSheet> createState() => _CatchLogSheetState();
}

class _CatchLogSheetState extends ConsumerState<CatchLogSheet> {
  @override
  void initState() {
    super.initState();
    // Ensure catches are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(catchControllerProvider.notifier).refresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final catchesAsync = ref.watch(catchControllerProvider);
    final colors = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.sizeOf(context);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: screenSize.height * 0.6,
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(
              top: BorderSide(
                color: colors.onSurface.withValues(alpha: 0.15),
              ),
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Catch Log',
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    GlassIconButton(
                      icon: Icons.close,
                      onPressed: () => Navigator.pop(context),
                      size: 32,
                      activeColor: colors.onSurface.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: colors.outlineVariant.withValues(alpha: 0.2),
              ),

              // List
              Expanded(
                child: catchesAsync.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: colors.tertiary,
                    ),
                  ),
                  error: (err, stack) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Error loading catches: $err',
                        style: TextStyle(
                          color: colors.error,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  data: (catches) {
                    if (catches.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.waves,
                              size: 48,
                              color: colors.onSurfaceVariant.withValues(
                                alpha: 0.2,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No catches yet.\nGo fish!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colors.onSurfaceVariant,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 40),
                      itemCount: catches.length,
                      itemBuilder: (context, index) {
                        final catchItem = catches[index];
                        return _CatchListItem(catchItem: catchItem);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CatchListItem extends StatelessWidget {
  const _CatchListItem({required this.catchItem});
  final FishCatch catchItem;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, HH:mm');
    final colors = Theme.of(context).colorScheme;
    final speciesColor = FishingPresentationUtils.getSpeciesColor(
      catchItem.species,
    );
    final speciesGradient = FishingPresentationUtils.getSpeciesGradient(
      catchItem.species,
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: ListTile(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => CatchDetailSheet(catchItem: catchItem),
          );
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: speciesGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: speciesColor.withValues(alpha: 0.35),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            catchItem.species.emoji,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        title: Text(
          catchItem.species.displayName,
          style: TextStyle(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 12,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  dateFormat.format(catchItem.timestamp),
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                if (catchItem.lengthCm != null) ...[
                  const SizedBox(width: 12),
                  Icon(
                    Icons.straighten,
                    size: 12,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${catchItem.lengthCm} cm',
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
                if (catchItem.weightGrams != null) ...[
                  const SizedBox(width: 12),
                  Icon(
                    Icons.scale,
                    size: 12,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${(catchItem.weightGrams! / 1000).toStringAsFixed(1)} kg',
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
            if (catchItem.weatherTemp != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    FishingPresentationUtils.getWeatherEmoji(
                      catchItem.weatherIcon,
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${catchItem.weatherTemp!.toStringAsFixed(1)}°C',
                    style: TextStyle(
                      color: colors.onSurfaceVariant.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                  if (catchItem.weatherWindSpeed != null) ...[
                    const SizedBox(width: 10),
                    const Text('💨', style: TextStyle(fontSize: 11)),
                    const SizedBox(width: 4),
                    Text(
                      '${catchItem.weatherWindSpeed!.toStringAsFixed(1)} m/s',
                      style: TextStyle(
                        color: colors.onSurfaceVariant.withValues(alpha: 0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ],
            if (catchItem.notes != null && catchItem.notes!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  catchItem.notes!,
                  style: TextStyle(
                    color: colors.onSurfaceVariant.withValues(alpha: 0.8),
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colors.onSurfaceVariant.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
