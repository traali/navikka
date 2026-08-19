// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dao.dart';

// ignore_for_file: type=lint
mixin _$WeatherDaoMixin on DatabaseAccessor<AppDatabase> {
  $WeatherProvidersTable get weatherProviders =>
      attachedDatabase.weatherProviders;
  $WeatherStationsTable get weatherStations => attachedDatabase.weatherStations;
  $WeatherObservationsTable get weatherObservations =>
      attachedDatabase.weatherObservations;
  $WeatherForecastsTable get weatherForecasts =>
      attachedDatabase.weatherForecasts;
  $WaveObservationsTable get waveObservations =>
      attachedDatabase.waveObservations;
  $SeaLevelReadingsTable get seaLevelReadings =>
      attachedDatabase.seaLevelReadings;
  $WeatherAlertsTable get weatherAlerts => attachedDatabase.weatherAlerts;
  $LightningStrikesTable get lightningStrikes =>
      attachedDatabase.lightningStrikes;
  $WaterQualityReadingsTable get waterQualityReadings =>
      attachedDatabase.waterQualityReadings;
  $AlgaeReportsTable get algaeReports => attachedDatabase.algaeReports;
  WeatherDaoManager get managers => WeatherDaoManager(this);
}

class WeatherDaoManager {
  final _$WeatherDaoMixin _db;
  WeatherDaoManager(this._db);
  $$WeatherProvidersTableTableManager get weatherProviders =>
      $$WeatherProvidersTableTableManager(
        _db.attachedDatabase,
        _db.weatherProviders,
      );
  $$WeatherStationsTableTableManager get weatherStations =>
      $$WeatherStationsTableTableManager(
        _db.attachedDatabase,
        _db.weatherStations,
      );
  $$WeatherObservationsTableTableManager get weatherObservations =>
      $$WeatherObservationsTableTableManager(
        _db.attachedDatabase,
        _db.weatherObservations,
      );
  $$WeatherForecastsTableTableManager get weatherForecasts =>
      $$WeatherForecastsTableTableManager(
        _db.attachedDatabase,
        _db.weatherForecasts,
      );
  $$WaveObservationsTableTableManager get waveObservations =>
      $$WaveObservationsTableTableManager(
        _db.attachedDatabase,
        _db.waveObservations,
      );
  $$SeaLevelReadingsTableTableManager get seaLevelReadings =>
      $$SeaLevelReadingsTableTableManager(
        _db.attachedDatabase,
        _db.seaLevelReadings,
      );
  $$WeatherAlertsTableTableManager get weatherAlerts =>
      $$WeatherAlertsTableTableManager(_db.attachedDatabase, _db.weatherAlerts);
  $$LightningStrikesTableTableManager get lightningStrikes =>
      $$LightningStrikesTableTableManager(
        _db.attachedDatabase,
        _db.lightningStrikes,
      );
  $$WaterQualityReadingsTableTableManager get waterQualityReadings =>
      $$WaterQualityReadingsTableTableManager(
        _db.attachedDatabase,
        _db.waterQualityReadings,
      );
  $$AlgaeReportsTableTableManager get algaeReports =>
      $$AlgaeReportsTableTableManager(_db.attachedDatabase, _db.algaeReports);
}
