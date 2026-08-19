class FmiConstants {
  static const String wfsBaseUrl = 'https://opendata.fmi.fi/wfs';
  static const String wmsBaseUrl = 'https://openwms.fmi.fi/geoserver/wms?';

  // Finland Approx Bounding Box (minLon, minLat, maxLon, maxLat)
  static const String finlandBBox = '19,59,32,70';

  // Stored Query IDs
  static const String queryLatestAlerts = 'fmi::alerts::cap::latest::fi';
  static const String queryLightning =
      'fmi::observations::lightning::multipointcoverage';

  // CAP Alerts Feed (Atom format - the correct endpoint for warnings)
  static const String capAlertsUrl =
      'https://alerts.fmi.fi/cap/feed/atom_fi-FI.xml';

  // WMS Layers (note: Radar namespace is capitalized)
  static const String layerRadarReflectivity = 'Radar:suomi_dbz_eureffin';
  static const String layerRadarRainIntensity = 'Radar:suomi_rr_eureffin';

  static const String queryWeatherObservations =
      'fmi::observations::weather::multipointcoverage';

  // Specific parameters to request to ensure we get visibility and other useful data
  // t2m=Temp, ws_10min=Wind, wg_10min=Gust, wd_10min=Dir, p_sea=Pressure,
  // vis=Visibility, rh=Humidity, r_1h=Precip(1h), n_man=CloudCover
  static const String observationParams =
      't2m,ws_10min,wg_10min,wd_10min,p_sea,vis,rh,r_1h,n_man';

  static const String queryWaveObservations =
      'fmi::observations::wave::timevaluepair';

  static const String queryForecast =
      'fmi::forecast::harmonie::surface::point::multipointcoverage';

  // Forecast parameters - must match order expected by WeatherForecastDto.fromMultipointCoverage
  // (temperature at index 0, wind at 1, gust at 2, direction at 3, precipitation at 4)
  static const String forecastParams =
      'Temperature,WindSpeedMS,WindGust,WindDirection,PrecipitationAmount,Pressure,Humidity,DewPoint,TotalCloudCover';

  // Lightning parameters - explicit order for LightningStrikeDto
  static const String lightningParams =
      'multiplicity,peak_current,cloud_indicator,ellipse_major';

  // Wave parameters - explicit ordering for WaveObservationDto
  // WaveHs=Signif. Height, ModalWDi=Direction, WTP=Modal Period, TWATER=Water Temp
  static const String waveParams = 'WaveHs,ModalWDi,WTP,TWATER';

  static const String queryMareograph =
      'fmi::observations::mareograph::timevaluepair';

  // Mareograph parameters
  // watlev=Sea Level (mm) specific to FMI
  static const String mareographParams = 'watlev';
}
