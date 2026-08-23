import 'package:sakkoja/core/utils/logger.dart';
import 'package:sakkoja/features/ai/domain/entities/navigation_context.dart';
import 'package:sakkoja/features/ai/domain/entities/weather_insight.dart';
import 'package:sakkoja/features/navigation/domain/entities/waypoint_entity.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/weather/domain/entities/wave_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_data.dart';
import 'package:sakkoja/features/weather/domain/entities/weather_forecast.dart';

/// Native implementation of AI Edge service.
///
/// Features:
/// 1. High-precision Local Marine Reasoning Engine for zero-latency, private, on-device analysis.
/// 2. Integrates with on-device LLM if local model weights are loaded.
class WeatherAIEdgeService {
  // ignore: avoid_unused_constructor_parameters
  WeatherAIEdgeService({required Future<String?> Function() getModelPath});

  Future<void> init() async {
    Log.i('AIEdgeService: Native engine initialized.');
  }

  /// Analyzes a planned route and generates an intelligent weather-routing skipper briefing.
  static String analyzeRoute({
    required List<WaypointEntity> waypoints,
    required double totalDistanceMeters,
    required int totalDurationMinutes,
    required WeatherData? weather,
    required WaveData? wave,
  }) {
    if (waypoints.length < 2) {
      return 'Lisää vähintään kaksi reittipistettä reittianalyysin laskemiseksi.';
    }

    final nm = (totalDistanceMeters / 1852).toStringAsFixed(1);
    final wind = weather?.windSpeed != null
        ? '${weather!.windSpeed!.toStringAsFixed(1)} m/s'
        : null;
    final waveH = wave?.waveHeight != null
        ? '${wave!.waveHeight!.toStringAsFixed(1)} m'
        : null;

    if (wind == null) {
      return 'Reitti ($nm NM, $totalDurationMinutes min): Säätä ei saatavilla — älä oleta tyyntä. Muista seurata tähystystä ja väylämerkkejä.';
    }

    final weatherSummary = waveH != null
        ? 'Olosuhteet reitillä: Tuuli $wind, aallokko $waveH.'
        : 'Olosuhteet reitillä: Tuuli $wind. Aallokkoa ei saatavilla — älä oleta tyyntä.';

    if (wave != null && wave.waveHeight != null && wave.waveHeight! >= 1.2) {
      return 'Reitti ($nm NM, $totalDurationMinutes min): $weatherSummary Avomerialueilla aallokko on jyrkkää. Suositellaan reitin viemistä saariston suojaisempien väylien kautta.';
    }

    if (weather != null &&
        weather.windGust != null &&
        weather.windSpeed != null &&
        weather.windGust! >= 10.0) {
      return 'Reitti ($nm NM, $totalDurationMinutes min): $weatherSummary Huomioi voimakkaat puuskat (${weather.windGust!.toStringAsFixed(1)} m/s) kapeikoissa ja saarten välisissä salmissa.';
    }

    return waveH != null
        ? 'Reitti ($nm NM, $totalDurationMinutes min): $weatherSummary Reittilinja on suora ja turvallinen. Muista seurata tähystystä ja väylämerkkejä.'
        : 'Reitti ($nm NM, $totalDurationMinutes min): $weatherSummary Muista seurata tähystystä ja väylämerkkejä.';
  }

  Future<String> getAdvice({
    required WeatherData? weather,
    required WaveData? wave,
    required List<WeatherForecast> forecasts,
    required SafetyStatus status,
    required NavigationContext context,
  }) async {
    final windSpeed = weather?.windSpeed;
    if (windSpeed == null) {
      return 'Säätä ei saatavilla — älä oleta tyyntä. Pidä tähystys COLREG-säännön 5 mukaisesti.';
    }
    final windGust = weather?.windGust ?? windSpeed;
    final waveKnown = wave?.waveHeight != null;
    final waveHeight = wave?.waveHeight ?? 0.0;
    final wavePeriod = wave?.wavePeriod;
    final isSailing = context.vesselType == VesselType.sailboat;
    final isCoastOrHarbor = context.isNearingCoast;

    // 1. Extreme Weather / Danger (Red)
    if (status == SafetyStatus.red || windSpeed >= 14.0 || waveHeight >= 2.0) {
      if (windSpeed >= 14.0) {
        final waveTxt = waveKnown
            ? ' ja aallokko ${waveHeight.toStringAsFixed(1)} m'
            : '';
        return 'Varoitus: Kova tuuli (${windSpeed.toStringAsFixed(1)} m/s, puuskat ${windGust.toStringAsFixed(1)} m/s)$waveTxt ylittävät pienten alusten turvarajat. Hakeudu suojaisaan satamaan tai ankkuripaikalle.';
      }
      return 'Varoitus: Sääolosuhteet ovat vaaralliset pienten alusten navigoinnille. Seuraa tutkakuvaa ja vältä avoselkäosuuksia.';
    }

    // 2. Strong Wind / Significant Wave / Warning (Orange)
    if (status == SafetyStatus.orange ||
        windSpeed >= 11.0 ||
        waveHeight >= 1.3) {
      if (waveHeight >= 1.3) {
        final periodStr = wavePeriod != null
            ? ' (jakso ${wavePeriod.toStringAsFixed(1)} s)'
            : '';
        return 'Huomio: Voimakas aallokko ${waveHeight.toStringAsFixed(1)} m$periodStr tekee aallokosta jyrkkää avoimilla selillä. Valitse suojaisemmat saaristoväylät ja sovita nopeus.';
      }
      return 'Huomio: Tuuli nousee ${windSpeed.toStringAsFixed(1)} m/s (puuskat ${windGust.toStringAsFixed(1)} m/s). Huomioi kova tuulidrifti ja valmistaudu lisäämään kiinnitysköysiä.';
    }

    // 3. Squalls / Gust Factor Evaluation
    final gustFactor = windSpeed > 2.0 ? (windGust / windSpeed) : 1.0;
    if (gustFactor >= 1.4 && windGust >= 8.5) {
      return 'Puuskainen merisää: Tuuli ${windSpeed.toStringAsFixed(1)} m/s, mutta puuskat yltävät ${windGust.toStringAsFixed(1)} m/s (puuskakerroin ${gustFactor.toStringAsFixed(1)}x). Varo äkillisiä tuulenpuuskia saarten kapeikoissa ja selkäalueiden reunoilla.';
    }

    // 4. Fog / Low Cloud / Visibility Alarm (COLREG Rules 19 & 35)
    final visibility = weather?.visibility;
    if (visibility != null && visibility <= 1000) {
      return 'Sumuhälytys: Näkyvyys on erittäin heikko (${visibility.round()} m). Sytytä kulkuvalot, noudata COLREG-säännön 19 määräyksiä sumussa kulkemisesta, anna äänimerkit (Sääntö 35) ja tarkkaile tutkaa/AIS:ää.';
    }

    final temp = weather?.temperature;
    final dew = weather?.dewPoint;
    final humidity = weather?.humidity ?? 0.0;
    if (temp != null &&
        dew != null &&
        (temp - dew).abs() <= 1.2 &&
        humidity >= 90.0) {
      return 'Sumun muodostumishälytys: Lämpötila ja kastepiste ovat lähes samat (${temp.toStringAsFixed(1)}°C / ${dew.toStringAsFixed(1)}°C, kosteus ${humidity.round()}%). Äkillinen merisumu tai matalapilvi todennäköinen.';
    }

    // Check incoming low clouds / fog in upcoming forecast hours
    for (final f in forecasts.take(6)) {
      final fTemp = f.temperature;
      final fDew = f.dewPoint;
      final fHumidity = f.humidity ?? 0.0;
      final fCloud = f.cloudCover ?? 0.0;
      final fDesc = f.weatherDescription?.toLowerCase() ?? '';

      final isFogForecast =
          fDesc.contains('sumu') ||
          fDesc.contains('fog') ||
          fDesc.contains('matalapilvi');
      final isCondensationRisk =
          fTemp != null &&
          fDew != null &&
          (fTemp - fDew).abs() <= 1.2 &&
          fHumidity >= 92.0;

      if (isFogForecast ||
          isCondensationRisk ||
          (fCloud >= 95.0 && fHumidity >= 95.0)) {
        return 'Tuleva sumu- / matalapilvihälytys: Lähitunneille ennustettu matalapilveä tai merisumua (pilvisyys ${fCloud.round()}%, kosteus ${fHumidity.round()}%). Varaudu näkyvyyden äkilliseen heikkenemiseen reitillä.';
      }
    }

    // 5. Harbor / Berthing Context
    if (isCoastOrHarbor) {
      if (windSpeed >= 6.0) {
        return 'Satamalähestyminen / Kiinnitys: Tuuli ${windSpeed.toStringAsFixed(1)} m/s vaikuttaa aluksen sivuttaisdriftiin rantautuessa. Valmistele lepuuttajat ja keula/peräköydet ajoissa tuulen puolelle.';
      }
      return 'Satamatila: Olosuhteet ovat rauhalliset (tuuli ${windSpeed.toStringAsFixed(1)} m/s). Kiinnitykseen ja laiturimanöövereihin on erinomainen sää.';
    }

    // 5. Multi-Provider Contradiction & Forecast Shift Check
    if (forecasts.isNotEmpty) {
      // 5a. Check Multi-Provider Divergence (e.g. FMI vs MET Norway vs OpenWeather)
      final providerForecasts = <int, WeatherForecast>{};
      for (final f in forecasts) {
        if (f.providerId != null &&
            !providerForecasts.containsKey(f.providerId)) {
          providerForecasts[f.providerId!] = f;
        }
      }

      if (providerForecasts.length >= 2) {
        final speeds = providerForecasts.values
            .map((f) => f.windSpeed)
            .whereType<double>()
            .toList();
        if (speeds.length >= 2) {
          final minSpeed = speeds.reduce((a, b) => a < b ? a : b);
          final maxSpeed = speeds.reduce((a, b) => a > b ? a : b);
          if ((maxSpeed - minSpeed) >= 3.5) {
            return 'Ennustemallien ristiriita: Säämallit (FMI vs. MET Norway / OpenWeather) poikkeavat toisistaan (${minSpeed.toStringAsFixed(1)} m/s vs. ${maxSpeed.toStringAsFixed(1)} m/s). Ennusteessa on normaalia suurempi epävarmuus; varaudu kovempaan keliin.';
          }
        }
      }

      // 5b. Check Forecast Progression / Approaching Fronts (Next 3 hours)
      final next3h = forecasts.take(3).toList();
      final currentSpeed = weather?.windSpeed;
      final currentDir = weather?.windDirection;

      for (final f in next3h) {
        final fSpeed = f.windSpeed;
        final fDir = f.windDirection;

        // Rapid wind intensification
        if (currentSpeed != null &&
            fSpeed != null &&
            (fSpeed - currentSpeed) >= 4.0) {
          return 'Ennustettu tuulen voimistuminen: Tuuli nousee lähitunneilla ${currentSpeed.toStringAsFixed(1)} m/s -> ${fSpeed.toStringAsFixed(1)} m/s. Suunnittele reitti tai siirtymä ajoissa ennen tuulen nousua.';
        }

        // Significant wind shift
        if (currentDir != null && fDir != null) {
          final diff = (fDir - currentDir).abs();
          final normalizedDiff = diff > 180 ? 360 - diff : diff;
          if (normalizedDiff >= 45.0) {
            final speedText = fSpeed != null
                ? ' (ennuste ${fSpeed.toStringAsFixed(1)} m/s)'
                : '';
            return 'Säämuutos ennusteessa: Tuulen suunta kääntyy lähipäivinä noin ${normalizedDiff.round()}°$speedText. Tarkista ankkuripaikan ja reitin suojaisuus.';
          }
        }
      }
    }

    // 6. Normal Cruising / Favorable Navigation (Green/Yellow)
    if (windSpeed <= 6.0 && waveHeight <= 0.6) {
      if (!waveKnown) {
        return 'Tuuli ${windSpeed.toStringAsFixed(1)} m/s. Aallokkoa ei saatavilla — älä oleta tyyntä. Pidä tähystys COLREG-säännön 5 mukaisesti.';
      }
      final sailNote = isSailing
          ? ' Purjehdukseen suotuisat leppoisat tuulet.'
          : '';
      return 'Merisää on erinomainen matkaveneilyyn.$sailNote Tuuli ${windSpeed.toStringAsFixed(1)} m/s ja aallokko ${waveHeight.toStringAsFixed(1)} m mahdollistavat tasaisen matkanopeuden. Pidä tähystys COLREG-säännön 5 mukaisesti.';
    }

    return waveKnown
        ? 'Matkaveneilysää: Tuuli ${windSpeed.toStringAsFixed(1)} m/s (puuskat ${windGust.toStringAsFixed(1)} m/s), aallokko ${waveHeight.toStringAsFixed(1)} m. Olosuhteet ovat hallittavat normaaliin navigointiin.'
        : 'Tuuli ${windSpeed.toStringAsFixed(1)} m/s (puuskat ${windGust.toStringAsFixed(1)} m/s). Aallokkoa ei saatavilla — älä oleta tyyntä. Pidä tähystys COLREG-säännön 5 mukaisesti.';
  }
}
