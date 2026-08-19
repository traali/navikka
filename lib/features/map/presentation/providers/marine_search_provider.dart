import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/harbors/domain/entities/harbor.dart';
import 'package:sakkoja/features/harbors/presentation/providers/harbors_provider.dart';
import 'package:sakkoja/features/navigation_aids/presentation/providers/navigation_aids_providers.dart';

part 'marine_search_provider.g.dart';

/// Representation of a marine search result item.
class MarineSearchResult {
  const MarineSearchResult({
    required this.title,
    required this.subtitle,
    required this.position,
    required this.type,
  });

  final String title;
  final String subtitle;
  final LatLng position;
  final String type; // 'harbor', 'coordinate', 'seamark'
}

@riverpod
class MarineQueryController extends _$MarineQueryController {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

@riverpod
List<MarineSearchResult> marineSearchResults(Ref ref) {
  final query = ref.watch(marineQueryControllerProvider).trim();
  if (query.isEmpty) return const <MarineSearchResult>[];

  final results = <MarineSearchResult>[];
  final queryLower = query.toLowerCase();

  // 1. Try parsing lat/lng coordinates (e.g., "60.15, 24.89" or "60.15 24.89")
  final coordRegex = RegExp(
    r'^([+-]?\d+(?:\.\d+)?)[,\s]+([+-]?\d+(?:\.\d+)?)$',
  );
  final match = coordRegex.firstMatch(query);
  if (match != null) {
    final lat = double.tryParse(match.group(1) ?? '');
    final lng = double.tryParse(match.group(2) ?? '');
    if (lat != null &&
        lng != null &&
        lat >= -90 &&
        lat <= 90 &&
        lng >= -180 &&
        lng <= 180) {
      results.add(
        MarineSearchResult(
          title:
              'Koordinaatit: ${lat.toStringAsFixed(4)}°, ${lng.toStringAsFixed(4)}°',
          subtitle: 'Navigoi sijaintiin',
          position: LatLng(lat, lng),
          type: 'coordinate',
        ),
      );
    }
  }

  // 2. Search loaded harbors
  final harborsAsync = ref.watch(harborsProvider);
  final harbors = harborsAsync.value ?? const <Harbor>[];

  for (final harbor in harbors) {
    final nameMatch = harbor.name.toLowerCase().contains(queryLower);
    final muniMatch =
        harbor.municipality?.toLowerCase().contains(queryLower) ?? false;
    if (nameMatch || muniMatch) {
      results.add(
        MarineSearchResult(
          title: harbor.name,
          subtitle:
              '${harbor.typeLabel}${harbor.municipality != null ? ' • ${harbor.municipality}' : ''}',
          position: harbor.position,
          type: 'harbor',
        ),
      );
      if (results.length >= 15) break;
    }
  }

  // 3. Search navigation aids / seamarks
  final navAidsAsync = ref.watch(hybridNavigationAidsProvider);
  final navAids = navAidsAsync.value ?? const [];

  for (final aid in navAids) {
    final aidName = aid.name;
    if (aidName != null &&
        aidName.isNotEmpty &&
        aidName.toLowerCase().contains(queryLower)) {
      results.add(
        MarineSearchResult(
          title: aidName,
          subtitle: 'Merimerkki • ${aid.type.name}',
          position: aid.position,
          type: 'seamark',
        ),
      );
      if (results.length >= 25) break;
    }
  }

  return results;
}
