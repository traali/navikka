import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get openWeatherKey =>
      dotenv.get('OPENWEATHER_API_KEY', fallback: '');
  static bool get isStaging =>
      dotenv.get('APP_ENV', fallback: 'production') == 'staging';
  static String get dbName =>
      isStaging ? 'app_drift_db_staging.sqlite' : 'app_drift_db.sqlite';

  // SYKE (Finnish Environment Institute) API endpoints
  // Water quality OData v2.0 (upgraded from deprecated v1.0 which removed
  // the flat Vesilaatu and Levatiedot views).
  static String get sykeOdataBaseUrl => dotenv.get(
    'SYKE_ODATA_URL',
    fallback: 'https://rajapinnat.ymparisto.fi/api/vesla/2.0/odata',
  );
  // Citizen observations (Open311) - used for algae bloom reports.
  static String get sykeCitizenObsUrl => dotenv.get(
    'SYKE_CITIZEN_OBS_URL',
    fallback: 'https://rajapinnat.ymparisto.fi/api/kansalaishavainnot/1.0',
  );
  static String get sykeWmsUrl => dotenv.get(
    'SYKE_WMS_URL',
    fallback:
        'https://paikkatieto.ymparisto.fi/arcgis/services/Syke/Itameri/MapServer/WMSServer',
  );

  // AI model download URL (Gemma 3 1B quantized). Set via env or CI secret.
  // If empty/unset, AI model download will show as unavailable.
  static String get aiModelUrl => dotenv.get(
    'AI_MODEL_URL',
    fallback: '',
  );

  static const String commitHash = String.fromEnvironment(
    'APP_VERSION_HASH',
    defaultValue: 'dev',
  );

  static const String buildTime = String.fromEnvironment(
    'APP_VERSION_BUILD_TIME',
    defaultValue: 'unknown',
  );
}
