// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Navikka';

  @override
  String get initializing => 'Valmistellaan merikarttaa';

  @override
  String get searchHint => 'Hae paikkaa...';

  @override
  String get speedLimit => 'Nopeusrajoitus';

  @override
  String get fairway => 'Väylä';

  @override
  String get navigationAid => 'Turvalaite';

  @override
  String get fishingRestriction => 'Kalastusrajoitus';

  @override
  String get weatherTitle => 'Merisää';

  @override
  String get errorInitialization => 'Alustaminen kestää odotettua kauemmin';

  @override
  String get reload => 'Lataa sovellus uudelleen';

  @override
  String buildInfo(String status) {
    return 'Versiotiedot: $status';
  }

  @override
  String get selectedArea => 'Valittu alue';

  @override
  String get tiles => 'Tiiliä';

  @override
  String get estSize => 'Arvioitu koko';

  @override
  String get cancel => 'Peruuta';

  @override
  String get download => 'Lataa';

  @override
  String get areaSaved => 'Alue tallennettu onnistuneesti';

  @override
  String get areaSaveFailed => 'Alueen tallennus epäonnistui';

  @override
  String get recenter => 'Keskitä';

  @override
  String get fishingMode => 'Kalastustila';

  @override
  String get radar => 'Säätutka';

  @override
  String get play => 'Toista';

  @override
  String get pause => 'Pysäytä';

  @override
  String get routePlanner => 'Reittisuunnittelu';

  @override
  String get layers => 'Kerrokset';

  @override
  String get active => 'käytössä';

  @override
  String get weather => 'Sää';

  @override
  String get navigation => 'Navigointi';

  @override
  String get safety => 'Turvallisuus';

  @override
  String get navAids => 'Navigointimerkit';

  @override
  String get boatingLines => 'Vesiväylät';

  @override
  String get speedLimits => 'Nopeusrajoitukset';

  @override
  String get maritimeRestrictions => 'Meriliikenne';

  @override
  String get algae => 'Levä';

  @override
  String get radarSubtitle => 'Sadetutkan peittokuva';

  @override
  String get algaeSubtitle => 'Levätilanne (SYKE)';

  @override
  String get navAidsSubtitle => 'Poijut, merkit ja majakat';

  @override
  String get boatingLinesSubtitle => 'Vesiväylät ja keskiviivat';

  @override
  String get speedLimitsSubtitle => 'Nopeusrajoitukset';

  @override
  String get showRestrictionAreas => 'Näytä rajoitusalueet';

  @override
  String get restrictionSubtitle => 'Rajoitusalueet ja tyyppisuodatin';

  @override
  String get on => 'PÄÄLLÄ';

  @override
  String get off => 'POIS';

  @override
  String get close => 'Sulje';

  @override
  String get ais => 'AIS-alukset';

  @override
  String get aisSubtitle => 'Alusten reaaliaikainen seuranta (Digitraffic)';

  @override
  String get harbors => 'Satamat';

  @override
  String get harborsSubtitle => 'Veneily- ja vierassatamat';
}
