// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Navikka';

  @override
  String get initializing => 'Initializing Sea Chart';

  @override
  String get searchHint => 'Search for locations...';

  @override
  String get speedLimit => 'Speed Limit';

  @override
  String get fairway => 'Fairway';

  @override
  String get navigationAid => 'Navigation Aid';

  @override
  String get fishingRestriction => 'Fishing Restriction';

  @override
  String get weatherTitle => 'Marine Weather';

  @override
  String get errorInitialization =>
      'Initialization taking longer than expected';

  @override
  String get reload => 'Reload Application';

  @override
  String buildInfo(String status) {
    return 'Build Info: $status';
  }

  @override
  String get selectedArea => 'Selected Area';

  @override
  String get tiles => 'Tiles';

  @override
  String get estSize => 'Est. Size';

  @override
  String get cancel => 'Cancel';

  @override
  String get download => 'Download';

  @override
  String get areaSaved => 'Area saved successfully';

  @override
  String get areaSaveFailed => 'Failed to save area';

  @override
  String get recenter => 'Recenter';

  @override
  String get fishingMode => 'Fishing Mode';

  @override
  String get radar => 'Radar';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get routePlanner => 'Route Planner';

  @override
  String get layers => 'Layers';

  @override
  String get active => 'active';

  @override
  String get weather => 'Weather';

  @override
  String get navigation => 'Navigation';

  @override
  String get safety => 'Safety';

  @override
  String get navAids => 'Nav Aids';

  @override
  String get boatingLines => 'Boating Lines';

  @override
  String get speedLimits => 'Speed Limits';

  @override
  String get maritimeRestrictions => 'Maritime Restrictions';

  @override
  String get algae => 'Algae';

  @override
  String get radarSubtitle => 'Rain radar overlay';

  @override
  String get algaeSubtitle => 'Algae situation (SYKE)';

  @override
  String get navAidsSubtitle => 'Beacons, buoys, signs';

  @override
  String get boatingLinesSubtitle => 'Fairways and centerlines';

  @override
  String get speedLimitsSubtitle => 'Speed limits';

  @override
  String get showRestrictionAreas => 'Show restriction areas';

  @override
  String get restrictionSubtitle => 'Restriction areas and type filter';

  @override
  String get on => 'ON';

  @override
  String get off => 'OFF';

  @override
  String get close => 'Close';

  @override
  String get ais => 'AIS Vessels';

  @override
  String get aisSubtitle => 'Real-time vessel tracking (Digitraffic)';

  @override
  String get harbors => 'Harbors';

  @override
  String get harborsSubtitle => 'Boating and guest harbors';
}
