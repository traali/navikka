import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Navikka'**
  String get appTitle;

  /// No description provided for @initializing.
  ///
  /// In en, this message translates to:
  /// **'Initializing Sea Chart'**
  String get initializing;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for locations...'**
  String get searchHint;

  /// No description provided for @speedLimit.
  ///
  /// In en, this message translates to:
  /// **'Speed Limit'**
  String get speedLimit;

  /// No description provided for @fairway.
  ///
  /// In en, this message translates to:
  /// **'Fairway'**
  String get fairway;

  /// No description provided for @navigationAid.
  ///
  /// In en, this message translates to:
  /// **'Navigation Aid'**
  String get navigationAid;

  /// No description provided for @fishingRestriction.
  ///
  /// In en, this message translates to:
  /// **'Fishing Restriction'**
  String get fishingRestriction;

  /// No description provided for @weatherTitle.
  ///
  /// In en, this message translates to:
  /// **'Marine Weather'**
  String get weatherTitle;

  /// No description provided for @errorInitialization.
  ///
  /// In en, this message translates to:
  /// **'Initialization taking longer than expected'**
  String get errorInitialization;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload Application'**
  String get reload;

  /// No description provided for @buildInfo.
  ///
  /// In en, this message translates to:
  /// **'Build Info: {status}'**
  String buildInfo(String status);

  /// No description provided for @selectedArea.
  ///
  /// In en, this message translates to:
  /// **'Selected Area'**
  String get selectedArea;

  /// No description provided for @tiles.
  ///
  /// In en, this message translates to:
  /// **'Tiles'**
  String get tiles;

  /// No description provided for @estSize.
  ///
  /// In en, this message translates to:
  /// **'Est. Size'**
  String get estSize;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @areaSaved.
  ///
  /// In en, this message translates to:
  /// **'Area saved successfully'**
  String get areaSaved;

  /// No description provided for @areaSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save area'**
  String get areaSaveFailed;

  /// No description provided for @recenter.
  ///
  /// In en, this message translates to:
  /// **'Recenter'**
  String get recenter;

  /// No description provided for @fishingMode.
  ///
  /// In en, this message translates to:
  /// **'Fishing Mode'**
  String get fishingMode;

  /// No description provided for @radar.
  ///
  /// In en, this message translates to:
  /// **'Radar'**
  String get radar;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @routePlanner.
  ///
  /// In en, this message translates to:
  /// **'Route Planner'**
  String get routePlanner;

  /// No description provided for @layers.
  ///
  /// In en, this message translates to:
  /// **'Layers'**
  String get layers;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'active'**
  String get active;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @navigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get navigation;

  /// No description provided for @safety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get safety;

  /// No description provided for @navAids.
  ///
  /// In en, this message translates to:
  /// **'Nav Aids'**
  String get navAids;

  /// No description provided for @boatingLines.
  ///
  /// In en, this message translates to:
  /// **'Boating Lines'**
  String get boatingLines;

  /// No description provided for @speedLimits.
  ///
  /// In en, this message translates to:
  /// **'Speed Limits'**
  String get speedLimits;

  /// No description provided for @maritimeRestrictions.
  ///
  /// In en, this message translates to:
  /// **'Maritime Restrictions'**
  String get maritimeRestrictions;

  /// No description provided for @algae.
  ///
  /// In en, this message translates to:
  /// **'Algae'**
  String get algae;

  /// No description provided for @radarSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rain radar overlay'**
  String get radarSubtitle;

  /// No description provided for @algaeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Algae situation (SYKE)'**
  String get algaeSubtitle;

  /// No description provided for @navAidsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Beacons, buoys, signs'**
  String get navAidsSubtitle;

  /// No description provided for @boatingLinesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fairways and centerlines'**
  String get boatingLinesSubtitle;

  /// No description provided for @speedLimitsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Speed limits'**
  String get speedLimitsSubtitle;

  /// No description provided for @showRestrictionAreas.
  ///
  /// In en, this message translates to:
  /// **'Show restriction areas'**
  String get showRestrictionAreas;

  /// No description provided for @restrictionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restriction areas and type filter'**
  String get restrictionSubtitle;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'ON'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @ais.
  ///
  /// In en, this message translates to:
  /// **'AIS Vessels'**
  String get ais;

  /// No description provided for @aisSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real-time vessel tracking (Digitraffic)'**
  String get aisSubtitle;

  /// No description provided for @harbors.
  ///
  /// In en, this message translates to:
  /// **'Harbors'**
  String get harbors;

  /// No description provided for @harborsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Boating and guest harbors'**
  String get harborsSubtitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fi':
      return AppLocalizationsFi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
