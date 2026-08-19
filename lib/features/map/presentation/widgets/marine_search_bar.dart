import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/presentation/widgets/glass_container.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/features/map/presentation/providers/marine_search_provider.dart';
import 'package:sakkoja/l10n/app_localizations.dart';

/// Floating marine search bar widget anchored at the top of the map.
class MarineSearchBar extends ConsumerStatefulWidget {
  const MarineSearchBar({
    required this.onSelectLocation,
    super.key,
  });

  final void Function(LatLng target) onSelectLocation;

  @override
  ConsumerState<MarineSearchBar> createState() => _MarineSearchBarState();
}

class _MarineSearchBarState extends ConsumerState<MarineSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    ref.read(marineQueryControllerProvider.notifier).clear();
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final results = ref.watch(marineSearchResultsProvider);
    final query = ref.watch(marineQueryControllerProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Glass Search Input Bar
        GlassContainer(
          borderRadius: BorderRadius.circular(24),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                color: AppPalette.primaryAction,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  style: AppTextStyles.nvSm.copyWith(
                    color: AppPalette.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.searchHint,
                    hintStyle: AppTextStyles.nvSm.copyWith(
                      color: AppPalette.textSecondary,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  onChanged: (val) {
                    ref
                        .read(marineQueryControllerProvider.notifier)
                        .setQuery(val);
                    setState(() {
                      _isExpanded = val.trim().isNotEmpty;
                    });
                  },
                  onTap: () {
                    if (_controller.text.trim().isNotEmpty) {
                      setState(() {
                        _isExpanded = true;
                      });
                    }
                  },
                ),
              ),
              if (query.isNotEmpty)
                IconButton(
                  icon: const Icon(
                    Icons.clear,
                    size: 18,
                    color: AppPalette.textSecondary,
                  ),
                  onPressed: _clear,
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  padding: EdgeInsets.zero,
                ),
            ],
          ),
        ),

        // Autocomplete Results Dropdown Card
        if (_isExpanded && results.isNotEmpty) ...[
          const SizedBox(height: 6),
          GlassContainer(
            borderRadius: BorderRadius.circular(16),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: results.length,
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  color: AppPalette.surfaceHighlight,
                ),
                itemBuilder: (context, index) {
                  final item = results[index];
                  final iconData = item.type == 'coordinate'
                      ? Icons.my_location_rounded
                      : (item.type == 'harbor'
                            ? Icons.anchor_rounded
                            : Icons.place_rounded);

                  return ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    leading: Icon(
                      iconData,
                      size: 18,
                      color: AppPalette.primaryAction,
                    ),
                    title: Text(
                      item.title,
                      style: AppTextStyles.nvSm.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      item.subtitle,
                      style: AppTextStyles.nvXs.copyWith(
                        color: AppPalette.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      _focusNode.unfocus();
                      setState(() {
                        _isExpanded = false;
                      });
                      widget.onSelectLocation(item.position);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}
