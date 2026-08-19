// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CatchesTable extends Catches with TableInfo<$CatchesTable, Catch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMsMeta = const VerificationMeta(
    'timestampMs',
  );
  @override
  late final GeneratedColumn<int> timestampMs = GeneratedColumn<int>(
    'timestamp_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightGramsMeta = const VerificationMeta(
    'weightGrams',
  );
  @override
  late final GeneratedColumn<int> weightGrams = GeneratedColumn<int>(
    'weight_grams',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lengthCmMeta = const VerificationMeta(
    'lengthCm',
  );
  @override
  late final GeneratedColumn<double> lengthCm = GeneratedColumn<double>(
    'length_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lureMeta = const VerificationMeta('lure');
  @override
  late final GeneratedColumn<String> lure = GeneratedColumn<String>(
    'lure',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherTempMeta = const VerificationMeta(
    'weatherTemp',
  );
  @override
  late final GeneratedColumn<double> weatherTemp = GeneratedColumn<double>(
    'weather_temp',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherWindSpeedMeta = const VerificationMeta(
    'weatherWindSpeed',
  );
  @override
  late final GeneratedColumn<double> weatherWindSpeed = GeneratedColumn<double>(
    'weather_wind_speed',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherWindDirMeta = const VerificationMeta(
    'weatherWindDir',
  );
  @override
  late final GeneratedColumn<double> weatherWindDir = GeneratedColumn<double>(
    'weather_wind_dir',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherDescMeta = const VerificationMeta(
    'weatherDesc',
  );
  @override
  late final GeneratedColumn<String> weatherDesc = GeneratedColumn<String>(
    'weather_desc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherIconMeta = const VerificationMeta(
    'weatherIcon',
  );
  @override
  late final GeneratedColumn<String> weatherIcon = GeneratedColumn<String>(
    'weather_icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    species,
    timestampMs,
    latitude,
    longitude,
    weightGrams,
    lengthCm,
    lure,
    method,
    notes,
    weatherTemp,
    weatherWindSpeed,
    weatherWindDir,
    weatherDesc,
    weatherIcon,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'catches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Catch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('timestamp_ms')) {
      context.handle(
        _timestampMsMeta,
        timestampMs.isAcceptableOrUnknown(
          data['timestamp_ms']!,
          _timestampMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timestampMsMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('weight_grams')) {
      context.handle(
        _weightGramsMeta,
        weightGrams.isAcceptableOrUnknown(
          data['weight_grams']!,
          _weightGramsMeta,
        ),
      );
    }
    if (data.containsKey('length_cm')) {
      context.handle(
        _lengthCmMeta,
        lengthCm.isAcceptableOrUnknown(data['length_cm']!, _lengthCmMeta),
      );
    }
    if (data.containsKey('lure')) {
      context.handle(
        _lureMeta,
        lure.isAcceptableOrUnknown(data['lure']!, _lureMeta),
      );
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('weather_temp')) {
      context.handle(
        _weatherTempMeta,
        weatherTemp.isAcceptableOrUnknown(
          data['weather_temp']!,
          _weatherTempMeta,
        ),
      );
    }
    if (data.containsKey('weather_wind_speed')) {
      context.handle(
        _weatherWindSpeedMeta,
        weatherWindSpeed.isAcceptableOrUnknown(
          data['weather_wind_speed']!,
          _weatherWindSpeedMeta,
        ),
      );
    }
    if (data.containsKey('weather_wind_dir')) {
      context.handle(
        _weatherWindDirMeta,
        weatherWindDir.isAcceptableOrUnknown(
          data['weather_wind_dir']!,
          _weatherWindDirMeta,
        ),
      );
    }
    if (data.containsKey('weather_desc')) {
      context.handle(
        _weatherDescMeta,
        weatherDesc.isAcceptableOrUnknown(
          data['weather_desc']!,
          _weatherDescMeta,
        ),
      );
    }
    if (data.containsKey('weather_icon')) {
      context.handle(
        _weatherIconMeta,
        weatherIcon.isAcceptableOrUnknown(
          data['weather_icon']!,
          _weatherIconMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Catch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Catch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      )!,
      timestampMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp_ms'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      weightGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight_grams'],
      ),
      lengthCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}length_cm'],
      ),
      lure: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lure'],
      ),
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      weatherTemp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weather_temp'],
      ),
      weatherWindSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weather_wind_speed'],
      ),
      weatherWindDir: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weather_wind_dir'],
      ),
      weatherDesc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_desc'],
      ),
      weatherIcon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_icon'],
      ),
    );
  }

  @override
  $CatchesTable createAlias(String alias) {
    return $CatchesTable(attachedDatabase, alias);
  }
}

class Catch extends DataClass implements Insertable<Catch> {
  final String id;
  final String species;
  final int timestampMs;
  final double latitude;
  final double longitude;
  final int? weightGrams;
  final double? lengthCm;
  final String? lure;
  final String? method;
  final String? notes;
  final double? weatherTemp;
  final double? weatherWindSpeed;
  final double? weatherWindDir;
  final String? weatherDesc;
  final String? weatherIcon;
  const Catch({
    required this.id,
    required this.species,
    required this.timestampMs,
    required this.latitude,
    required this.longitude,
    this.weightGrams,
    this.lengthCm,
    this.lure,
    this.method,
    this.notes,
    this.weatherTemp,
    this.weatherWindSpeed,
    this.weatherWindDir,
    this.weatherDesc,
    this.weatherIcon,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['species'] = Variable<String>(species);
    map['timestamp_ms'] = Variable<int>(timestampMs);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || weightGrams != null) {
      map['weight_grams'] = Variable<int>(weightGrams);
    }
    if (!nullToAbsent || lengthCm != null) {
      map['length_cm'] = Variable<double>(lengthCm);
    }
    if (!nullToAbsent || lure != null) {
      map['lure'] = Variable<String>(lure);
    }
    if (!nullToAbsent || method != null) {
      map['method'] = Variable<String>(method);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || weatherTemp != null) {
      map['weather_temp'] = Variable<double>(weatherTemp);
    }
    if (!nullToAbsent || weatherWindSpeed != null) {
      map['weather_wind_speed'] = Variable<double>(weatherWindSpeed);
    }
    if (!nullToAbsent || weatherWindDir != null) {
      map['weather_wind_dir'] = Variable<double>(weatherWindDir);
    }
    if (!nullToAbsent || weatherDesc != null) {
      map['weather_desc'] = Variable<String>(weatherDesc);
    }
    if (!nullToAbsent || weatherIcon != null) {
      map['weather_icon'] = Variable<String>(weatherIcon);
    }
    return map;
  }

  CatchesCompanion toCompanion(bool nullToAbsent) {
    return CatchesCompanion(
      id: Value(id),
      species: Value(species),
      timestampMs: Value(timestampMs),
      latitude: Value(latitude),
      longitude: Value(longitude),
      weightGrams: weightGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(weightGrams),
      lengthCm: lengthCm == null && nullToAbsent
          ? const Value.absent()
          : Value(lengthCm),
      lure: lure == null && nullToAbsent ? const Value.absent() : Value(lure),
      method: method == null && nullToAbsent
          ? const Value.absent()
          : Value(method),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      weatherTemp: weatherTemp == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherTemp),
      weatherWindSpeed: weatherWindSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherWindSpeed),
      weatherWindDir: weatherWindDir == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherWindDir),
      weatherDesc: weatherDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherDesc),
      weatherIcon: weatherIcon == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherIcon),
    );
  }

  factory Catch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Catch(
      id: serializer.fromJson<String>(json['id']),
      species: serializer.fromJson<String>(json['species']),
      timestampMs: serializer.fromJson<int>(json['timestampMs']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      weightGrams: serializer.fromJson<int?>(json['weightGrams']),
      lengthCm: serializer.fromJson<double?>(json['lengthCm']),
      lure: serializer.fromJson<String?>(json['lure']),
      method: serializer.fromJson<String?>(json['method']),
      notes: serializer.fromJson<String?>(json['notes']),
      weatherTemp: serializer.fromJson<double?>(json['weatherTemp']),
      weatherWindSpeed: serializer.fromJson<double?>(json['weatherWindSpeed']),
      weatherWindDir: serializer.fromJson<double?>(json['weatherWindDir']),
      weatherDesc: serializer.fromJson<String?>(json['weatherDesc']),
      weatherIcon: serializer.fromJson<String?>(json['weatherIcon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'species': serializer.toJson<String>(species),
      'timestampMs': serializer.toJson<int>(timestampMs),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'weightGrams': serializer.toJson<int?>(weightGrams),
      'lengthCm': serializer.toJson<double?>(lengthCm),
      'lure': serializer.toJson<String?>(lure),
      'method': serializer.toJson<String?>(method),
      'notes': serializer.toJson<String?>(notes),
      'weatherTemp': serializer.toJson<double?>(weatherTemp),
      'weatherWindSpeed': serializer.toJson<double?>(weatherWindSpeed),
      'weatherWindDir': serializer.toJson<double?>(weatherWindDir),
      'weatherDesc': serializer.toJson<String?>(weatherDesc),
      'weatherIcon': serializer.toJson<String?>(weatherIcon),
    };
  }

  Catch copyWith({
    String? id,
    String? species,
    int? timestampMs,
    double? latitude,
    double? longitude,
    Value<int?> weightGrams = const Value.absent(),
    Value<double?> lengthCm = const Value.absent(),
    Value<String?> lure = const Value.absent(),
    Value<String?> method = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<double?> weatherTemp = const Value.absent(),
    Value<double?> weatherWindSpeed = const Value.absent(),
    Value<double?> weatherWindDir = const Value.absent(),
    Value<String?> weatherDesc = const Value.absent(),
    Value<String?> weatherIcon = const Value.absent(),
  }) => Catch(
    id: id ?? this.id,
    species: species ?? this.species,
    timestampMs: timestampMs ?? this.timestampMs,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    weightGrams: weightGrams.present ? weightGrams.value : this.weightGrams,
    lengthCm: lengthCm.present ? lengthCm.value : this.lengthCm,
    lure: lure.present ? lure.value : this.lure,
    method: method.present ? method.value : this.method,
    notes: notes.present ? notes.value : this.notes,
    weatherTemp: weatherTemp.present ? weatherTemp.value : this.weatherTemp,
    weatherWindSpeed: weatherWindSpeed.present
        ? weatherWindSpeed.value
        : this.weatherWindSpeed,
    weatherWindDir: weatherWindDir.present
        ? weatherWindDir.value
        : this.weatherWindDir,
    weatherDesc: weatherDesc.present ? weatherDesc.value : this.weatherDesc,
    weatherIcon: weatherIcon.present ? weatherIcon.value : this.weatherIcon,
  );
  Catch copyWithCompanion(CatchesCompanion data) {
    return Catch(
      id: data.id.present ? data.id.value : this.id,
      species: data.species.present ? data.species.value : this.species,
      timestampMs: data.timestampMs.present
          ? data.timestampMs.value
          : this.timestampMs,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      weightGrams: data.weightGrams.present
          ? data.weightGrams.value
          : this.weightGrams,
      lengthCm: data.lengthCm.present ? data.lengthCm.value : this.lengthCm,
      lure: data.lure.present ? data.lure.value : this.lure,
      method: data.method.present ? data.method.value : this.method,
      notes: data.notes.present ? data.notes.value : this.notes,
      weatherTemp: data.weatherTemp.present
          ? data.weatherTemp.value
          : this.weatherTemp,
      weatherWindSpeed: data.weatherWindSpeed.present
          ? data.weatherWindSpeed.value
          : this.weatherWindSpeed,
      weatherWindDir: data.weatherWindDir.present
          ? data.weatherWindDir.value
          : this.weatherWindDir,
      weatherDesc: data.weatherDesc.present
          ? data.weatherDesc.value
          : this.weatherDesc,
      weatherIcon: data.weatherIcon.present
          ? data.weatherIcon.value
          : this.weatherIcon,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Catch(')
          ..write('id: $id, ')
          ..write('species: $species, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('weightGrams: $weightGrams, ')
          ..write('lengthCm: $lengthCm, ')
          ..write('lure: $lure, ')
          ..write('method: $method, ')
          ..write('notes: $notes, ')
          ..write('weatherTemp: $weatherTemp, ')
          ..write('weatherWindSpeed: $weatherWindSpeed, ')
          ..write('weatherWindDir: $weatherWindDir, ')
          ..write('weatherDesc: $weatherDesc, ')
          ..write('weatherIcon: $weatherIcon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    species,
    timestampMs,
    latitude,
    longitude,
    weightGrams,
    lengthCm,
    lure,
    method,
    notes,
    weatherTemp,
    weatherWindSpeed,
    weatherWindDir,
    weatherDesc,
    weatherIcon,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Catch &&
          other.id == this.id &&
          other.species == this.species &&
          other.timestampMs == this.timestampMs &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.weightGrams == this.weightGrams &&
          other.lengthCm == this.lengthCm &&
          other.lure == this.lure &&
          other.method == this.method &&
          other.notes == this.notes &&
          other.weatherTemp == this.weatherTemp &&
          other.weatherWindSpeed == this.weatherWindSpeed &&
          other.weatherWindDir == this.weatherWindDir &&
          other.weatherDesc == this.weatherDesc &&
          other.weatherIcon == this.weatherIcon);
}

class CatchesCompanion extends UpdateCompanion<Catch> {
  final Value<String> id;
  final Value<String> species;
  final Value<int> timestampMs;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<int?> weightGrams;
  final Value<double?> lengthCm;
  final Value<String?> lure;
  final Value<String?> method;
  final Value<String?> notes;
  final Value<double?> weatherTemp;
  final Value<double?> weatherWindSpeed;
  final Value<double?> weatherWindDir;
  final Value<String?> weatherDesc;
  final Value<String?> weatherIcon;
  final Value<int> rowid;
  const CatchesCompanion({
    this.id = const Value.absent(),
    this.species = const Value.absent(),
    this.timestampMs = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.weightGrams = const Value.absent(),
    this.lengthCm = const Value.absent(),
    this.lure = const Value.absent(),
    this.method = const Value.absent(),
    this.notes = const Value.absent(),
    this.weatherTemp = const Value.absent(),
    this.weatherWindSpeed = const Value.absent(),
    this.weatherWindDir = const Value.absent(),
    this.weatherDesc = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CatchesCompanion.insert({
    required String id,
    required String species,
    required int timestampMs,
    required double latitude,
    required double longitude,
    this.weightGrams = const Value.absent(),
    this.lengthCm = const Value.absent(),
    this.lure = const Value.absent(),
    this.method = const Value.absent(),
    this.notes = const Value.absent(),
    this.weatherTemp = const Value.absent(),
    this.weatherWindSpeed = const Value.absent(),
    this.weatherWindDir = const Value.absent(),
    this.weatherDesc = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       species = Value(species),
       timestampMs = Value(timestampMs),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<Catch> custom({
    Expression<String>? id,
    Expression<String>? species,
    Expression<int>? timestampMs,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<int>? weightGrams,
    Expression<double>? lengthCm,
    Expression<String>? lure,
    Expression<String>? method,
    Expression<String>? notes,
    Expression<double>? weatherTemp,
    Expression<double>? weatherWindSpeed,
    Expression<double>? weatherWindDir,
    Expression<String>? weatherDesc,
    Expression<String>? weatherIcon,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (species != null) 'species': species,
      if (timestampMs != null) 'timestamp_ms': timestampMs,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (weightGrams != null) 'weight_grams': weightGrams,
      if (lengthCm != null) 'length_cm': lengthCm,
      if (lure != null) 'lure': lure,
      if (method != null) 'method': method,
      if (notes != null) 'notes': notes,
      if (weatherTemp != null) 'weather_temp': weatherTemp,
      if (weatherWindSpeed != null) 'weather_wind_speed': weatherWindSpeed,
      if (weatherWindDir != null) 'weather_wind_dir': weatherWindDir,
      if (weatherDesc != null) 'weather_desc': weatherDesc,
      if (weatherIcon != null) 'weather_icon': weatherIcon,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CatchesCompanion copyWith({
    Value<String>? id,
    Value<String>? species,
    Value<int>? timestampMs,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<int?>? weightGrams,
    Value<double?>? lengthCm,
    Value<String?>? lure,
    Value<String?>? method,
    Value<String?>? notes,
    Value<double?>? weatherTemp,
    Value<double?>? weatherWindSpeed,
    Value<double?>? weatherWindDir,
    Value<String?>? weatherDesc,
    Value<String?>? weatherIcon,
    Value<int>? rowid,
  }) {
    return CatchesCompanion(
      id: id ?? this.id,
      species: species ?? this.species,
      timestampMs: timestampMs ?? this.timestampMs,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      weightGrams: weightGrams ?? this.weightGrams,
      lengthCm: lengthCm ?? this.lengthCm,
      lure: lure ?? this.lure,
      method: method ?? this.method,
      notes: notes ?? this.notes,
      weatherTemp: weatherTemp ?? this.weatherTemp,
      weatherWindSpeed: weatherWindSpeed ?? this.weatherWindSpeed,
      weatherWindDir: weatherWindDir ?? this.weatherWindDir,
      weatherDesc: weatherDesc ?? this.weatherDesc,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (timestampMs.present) {
      map['timestamp_ms'] = Variable<int>(timestampMs.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (weightGrams.present) {
      map['weight_grams'] = Variable<int>(weightGrams.value);
    }
    if (lengthCm.present) {
      map['length_cm'] = Variable<double>(lengthCm.value);
    }
    if (lure.present) {
      map['lure'] = Variable<String>(lure.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (weatherTemp.present) {
      map['weather_temp'] = Variable<double>(weatherTemp.value);
    }
    if (weatherWindSpeed.present) {
      map['weather_wind_speed'] = Variable<double>(weatherWindSpeed.value);
    }
    if (weatherWindDir.present) {
      map['weather_wind_dir'] = Variable<double>(weatherWindDir.value);
    }
    if (weatherDesc.present) {
      map['weather_desc'] = Variable<String>(weatherDesc.value);
    }
    if (weatherIcon.present) {
      map['weather_icon'] = Variable<String>(weatherIcon.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatchesCompanion(')
          ..write('id: $id, ')
          ..write('species: $species, ')
          ..write('timestampMs: $timestampMs, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('weightGrams: $weightGrams, ')
          ..write('lengthCm: $lengthCm, ')
          ..write('lure: $lure, ')
          ..write('method: $method, ')
          ..write('notes: $notes, ')
          ..write('weatherTemp: $weatherTemp, ')
          ..write('weatherWindSpeed: $weatherWindSpeed, ')
          ..write('weatherWindDir: $weatherWindDir, ')
          ..write('weatherDesc: $weatherDesc, ')
          ..write('weatherIcon: $weatherIcon, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserContributionsTable extends UserContributions
    with TableInfo<$UserContributionsTable, UserContributionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContributionType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ContributionType>($UserContributionsTable.$convertertype);
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    latitude,
    longitude,
    value,
    createdAt,
    isSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserContributionEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserContributionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserContributionEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: $UserContributionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
    );
  }

  @override
  $UserContributionsTable createAlias(String alias) {
    return $UserContributionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContributionType, int, int> $convertertype =
      const EnumIndexConverter<ContributionType>(ContributionType.values);
}

class UserContributionEntry extends DataClass
    implements Insertable<UserContributionEntry> {
  final String id;
  final ContributionType type;
  final double latitude;
  final double longitude;
  final String value;
  final DateTime createdAt;
  final bool isSynced;
  const UserContributionEntry({
    required this.id,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.value,
    required this.createdAt,
    required this.isSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['type'] = Variable<int>(
        $UserContributionsTable.$convertertype.toSql(type),
      );
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['value'] = Variable<String>(value);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_synced'] = Variable<bool>(isSynced);
    return map;
  }

  UserContributionsCompanion toCompanion(bool nullToAbsent) {
    return UserContributionsCompanion(
      id: Value(id),
      type: Value(type),
      latitude: Value(latitude),
      longitude: Value(longitude),
      value: Value(value),
      createdAt: Value(createdAt),
      isSynced: Value(isSynced),
    );
  }

  factory UserContributionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserContributionEntry(
      id: serializer.fromJson<String>(json['id']),
      type: $UserContributionsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      value: serializer.fromJson<String>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<int>(
        $UserContributionsTable.$convertertype.toJson(type),
      ),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'value': serializer.toJson<String>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isSynced': serializer.toJson<bool>(isSynced),
    };
  }

  UserContributionEntry copyWith({
    String? id,
    ContributionType? type,
    double? latitude,
    double? longitude,
    String? value,
    DateTime? createdAt,
    bool? isSynced,
  }) => UserContributionEntry(
    id: id ?? this.id,
    type: type ?? this.type,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    value: value ?? this.value,
    createdAt: createdAt ?? this.createdAt,
    isSynced: isSynced ?? this.isSynced,
  );
  UserContributionEntry copyWithCompanion(UserContributionsCompanion data) {
    return UserContributionEntry(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserContributionEntry(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, latitude, longitude, value, createdAt, isSynced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserContributionEntry &&
          other.id == this.id &&
          other.type == this.type &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.value == this.value &&
          other.createdAt == this.createdAt &&
          other.isSynced == this.isSynced);
}

class UserContributionsCompanion
    extends UpdateCompanion<UserContributionEntry> {
  final Value<String> id;
  final Value<ContributionType> type;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> value;
  final Value<DateTime> createdAt;
  final Value<bool> isSynced;
  final Value<int> rowid;
  const UserContributionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserContributionsCompanion.insert({
    required String id,
    required ContributionType type,
    required double latitude,
    required double longitude,
    required String value,
    required DateTime createdAt,
    this.isSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       latitude = Value(latitude),
       longitude = Value(longitude),
       value = Value(value),
       createdAt = Value(createdAt);
  static Insertable<UserContributionEntry> custom({
    Expression<String>? id,
    Expression<int>? type,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? value,
    Expression<DateTime>? createdAt,
    Expression<bool>? isSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
      if (isSynced != null) 'is_synced': isSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserContributionsCompanion copyWith({
    Value<String>? id,
    Value<ContributionType>? type,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? value,
    Value<DateTime>? createdAt,
    Value<bool>? isSynced,
    Value<int>? rowid,
  }) {
    return UserContributionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $UserContributionsTable.$convertertype.toSql(type.value),
      );
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserContributionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt, ')
          ..write('isSynced: $isSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedFeaturesTable extends CachedFeatures
    with TableInfo<$CachedFeaturesTable, CachedFeature> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedFeaturesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataJsonMeta = const VerificationMeta(
    'dataJson',
  );
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
    'data_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, category, cachedAt, dataJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_features';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedFeature> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    if (data.containsKey('data_json')) {
      context.handle(
        _dataJsonMeta,
        dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_dataJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, category};
  @override
  CachedFeature map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedFeature(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
      dataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_json'],
      )!,
    );
  }

  @override
  $CachedFeaturesTable createAlias(String alias) {
    return $CachedFeaturesTable(attachedDatabase, alias);
  }
}

class CachedFeature extends DataClass implements Insertable<CachedFeature> {
  final String id;
  final String category;
  final DateTime cachedAt;
  final String dataJson;
  const CachedFeature({
    required this.id,
    required this.category,
    required this.cachedAt,
    required this.dataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<String>(category);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    map['data_json'] = Variable<String>(dataJson);
    return map;
  }

  CachedFeaturesCompanion toCompanion(bool nullToAbsent) {
    return CachedFeaturesCompanion(
      id: Value(id),
      category: Value(category),
      cachedAt: Value(cachedAt),
      dataJson: Value(dataJson),
    );
  }

  factory CachedFeature.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedFeature(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
      dataJson: serializer.fromJson<String>(json['dataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(category),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
      'dataJson': serializer.toJson<String>(dataJson),
    };
  }

  CachedFeature copyWith({
    String? id,
    String? category,
    DateTime? cachedAt,
    String? dataJson,
  }) => CachedFeature(
    id: id ?? this.id,
    category: category ?? this.category,
    cachedAt: cachedAt ?? this.cachedAt,
    dataJson: dataJson ?? this.dataJson,
  );
  CachedFeature copyWithCompanion(CachedFeaturesCompanion data) {
    return CachedFeature(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedFeature(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('dataJson: $dataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, cachedAt, dataJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedFeature &&
          other.id == this.id &&
          other.category == this.category &&
          other.cachedAt == this.cachedAt &&
          other.dataJson == this.dataJson);
}

class CachedFeaturesCompanion extends UpdateCompanion<CachedFeature> {
  final Value<String> id;
  final Value<String> category;
  final Value<DateTime> cachedAt;
  final Value<String> dataJson;
  final Value<int> rowid;
  const CachedFeaturesCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.dataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedFeaturesCompanion.insert({
    required String id,
    required String category,
    required DateTime cachedAt,
    required String dataJson,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       category = Value(category),
       cachedAt = Value(cachedAt),
       dataJson = Value(dataJson);
  static Insertable<CachedFeature> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<DateTime>? cachedAt,
    Expression<String>? dataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (dataJson != null) 'data_json': dataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedFeaturesCompanion copyWith({
    Value<String>? id,
    Value<String>? category,
    Value<DateTime>? cachedAt,
    Value<String>? dataJson,
    Value<int>? rowid,
  }) {
    return CachedFeaturesCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      cachedAt: cachedAt ?? this.cachedAt,
      dataJson: dataJson ?? this.dataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedFeaturesCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('dataJson: $dataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeatherProvidersTable extends WeatherProviders
    with TableInfo<$WeatherProvidersTable, WeatherProvider> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherProvidersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _apiVersionMeta = const VerificationMeta(
    'apiVersion',
  );
  @override
  late final GeneratedColumn<String> apiVersion = GeneratedColumn<String>(
    'api_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    priority,
    apiVersion,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_providers';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherProvider> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('api_version')) {
      context.handle(
        _apiVersionMeta,
        apiVersion.isAcceptableOrUnknown(data['api_version']!, _apiVersionMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeatherProvider map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherProvider(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      apiVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}api_version'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $WeatherProvidersTable createAlias(String alias) {
    return $WeatherProvidersTable(attachedDatabase, alias);
  }
}

class WeatherProvider extends DataClass implements Insertable<WeatherProvider> {
  final int id;
  final String code;
  final String name;
  final int priority;
  final String? apiVersion;
  final bool isActive;
  const WeatherProvider({
    required this.id,
    required this.code,
    required this.name,
    required this.priority,
    this.apiVersion,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['priority'] = Variable<int>(priority);
    if (!nullToAbsent || apiVersion != null) {
      map['api_version'] = Variable<String>(apiVersion);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  WeatherProvidersCompanion toCompanion(bool nullToAbsent) {
    return WeatherProvidersCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      priority: Value(priority),
      apiVersion: apiVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(apiVersion),
      isActive: Value(isActive),
    );
  }

  factory WeatherProvider.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherProvider(
      id: serializer.fromJson<int>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      priority: serializer.fromJson<int>(json['priority']),
      apiVersion: serializer.fromJson<String?>(json['apiVersion']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'priority': serializer.toJson<int>(priority),
      'apiVersion': serializer.toJson<String?>(apiVersion),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  WeatherProvider copyWith({
    int? id,
    String? code,
    String? name,
    int? priority,
    Value<String?> apiVersion = const Value.absent(),
    bool? isActive,
  }) => WeatherProvider(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    priority: priority ?? this.priority,
    apiVersion: apiVersion.present ? apiVersion.value : this.apiVersion,
    isActive: isActive ?? this.isActive,
  );
  WeatherProvider copyWithCompanion(WeatherProvidersCompanion data) {
    return WeatherProvider(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      priority: data.priority.present ? data.priority.value : this.priority,
      apiVersion: data.apiVersion.present
          ? data.apiVersion.value
          : this.apiVersion,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherProvider(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priority: $priority, ')
          ..write('apiVersion: $apiVersion, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, code, name, priority, apiVersion, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherProvider &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.priority == this.priority &&
          other.apiVersion == this.apiVersion &&
          other.isActive == this.isActive);
}

class WeatherProvidersCompanion extends UpdateCompanion<WeatherProvider> {
  final Value<int> id;
  final Value<String> code;
  final Value<String> name;
  final Value<int> priority;
  final Value<String?> apiVersion;
  final Value<bool> isActive;
  const WeatherProvidersCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.priority = const Value.absent(),
    this.apiVersion = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  WeatherProvidersCompanion.insert({
    this.id = const Value.absent(),
    required String code,
    required String name,
    this.priority = const Value.absent(),
    this.apiVersion = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : code = Value(code),
       name = Value(name);
  static Insertable<WeatherProvider> custom({
    Expression<int>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? priority,
    Expression<String>? apiVersion,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (priority != null) 'priority': priority,
      if (apiVersion != null) 'api_version': apiVersion,
      if (isActive != null) 'is_active': isActive,
    });
  }

  WeatherProvidersCompanion copyWith({
    Value<int>? id,
    Value<String>? code,
    Value<String>? name,
    Value<int>? priority,
    Value<String?>? apiVersion,
    Value<bool>? isActive,
  }) {
    return WeatherProvidersCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      priority: priority ?? this.priority,
      apiVersion: apiVersion ?? this.apiVersion,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (apiVersion.present) {
      map['api_version'] = Variable<String>(apiVersion.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherProvidersCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('priority: $priority, ')
          ..write('apiVersion: $apiVersion, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $WeatherStationsTable extends WeatherStations
    with TableInfo<$WeatherStationsTable, WeatherStation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherStationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stationTypeMeta = const VerificationMeta(
    'stationType',
  );
  @override
  late final GeneratedColumn<String> stationType = GeneratedColumn<String>(
    'station_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (station_type IN (\'weather\', \'buoy\', \'mareograph\', \'water_quality\', \'algae\'))',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    latitude,
    longitude,
    stationType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_stations';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherStation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('station_type')) {
      context.handle(
        _stationTypeMeta,
        stationType.isAcceptableOrUnknown(
          data['station_type']!,
          _stationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stationTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {latitude, longitude, stationType},
  ];
  @override
  WeatherStation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherStation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      stationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station_type'],
      )!,
    );
  }

  @override
  $WeatherStationsTable createAlias(String alias) {
    return $WeatherStationsTable(attachedDatabase, alias);
  }
}

class WeatherStation extends DataClass implements Insertable<WeatherStation> {
  final int id;
  final String? name;
  final double latitude;
  final double longitude;
  final String stationType;
  const WeatherStation({
    required this.id,
    this.name,
    required this.latitude,
    required this.longitude,
    required this.stationType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['station_type'] = Variable<String>(stationType);
    return map;
  }

  WeatherStationsCompanion toCompanion(bool nullToAbsent) {
    return WeatherStationsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      stationType: Value(stationType),
    );
  }

  factory WeatherStation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherStation(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      stationType: serializer.fromJson<String>(json['stationType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'stationType': serializer.toJson<String>(stationType),
    };
  }

  WeatherStation copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
    double? latitude,
    double? longitude,
    String? stationType,
  }) => WeatherStation(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    stationType: stationType ?? this.stationType,
  );
  WeatherStation copyWithCompanion(WeatherStationsCompanion data) {
    return WeatherStation(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      stationType: data.stationType.present
          ? data.stationType.value
          : this.stationType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherStation(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('stationType: $stationType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, latitude, longitude, stationType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherStation &&
          other.id == this.id &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.stationType == this.stationType);
}

class WeatherStationsCompanion extends UpdateCompanion<WeatherStation> {
  final Value<int> id;
  final Value<String?> name;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> stationType;
  const WeatherStationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.stationType = const Value.absent(),
  });
  WeatherStationsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required double latitude,
    required double longitude,
    required String stationType,
  }) : latitude = Value(latitude),
       longitude = Value(longitude),
       stationType = Value(stationType);
  static Insertable<WeatherStation> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? stationType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (stationType != null) 'station_type': stationType,
    });
  }

  WeatherStationsCompanion copyWith({
    Value<int>? id,
    Value<String?>? name,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? stationType,
  }) {
    return WeatherStationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      stationType: stationType ?? this.stationType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (stationType.present) {
      map['station_type'] = Variable<String>(stationType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherStationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('stationType: $stationType')
          ..write(')'))
        .toString();
  }
}

class $WeatherObservationsTable extends WeatherObservations
    with TableInfo<$WeatherObservationsTable, WeatherObservation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherObservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stationIdMeta = const VerificationMeta(
    'stationId',
  );
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
    'station_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_stations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _windSpeedMeta = const VerificationMeta(
    'windSpeed',
  );
  @override
  late final GeneratedColumn<double> windSpeed = GeneratedColumn<double>(
    'wind_speed',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _windGustMeta = const VerificationMeta(
    'windGust',
  );
  @override
  late final GeneratedColumn<double> windGust = GeneratedColumn<double>(
    'wind_gust',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _windDirectionMeta = const VerificationMeta(
    'windDirection',
  );
  @override
  late final GeneratedColumn<double> windDirection = GeneratedColumn<double>(
    'wind_direction',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pressureMeta = const VerificationMeta(
    'pressure',
  );
  @override
  late final GeneratedColumn<double> pressure = GeneratedColumn<double>(
    'pressure',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _humidityMeta = const VerificationMeta(
    'humidity',
  );
  @override
  late final GeneratedColumn<double> humidity = GeneratedColumn<double>(
    'humidity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precipitationMeta = const VerificationMeta(
    'precipitation',
  );
  @override
  late final GeneratedColumn<double> precipitation = GeneratedColumn<double>(
    'precipitation',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cloudCoverMeta = const VerificationMeta(
    'cloudCover',
  );
  @override
  late final GeneratedColumn<double> cloudCover = GeneratedColumn<double>(
    'cloud_cover',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feelsLikeMeta = const VerificationMeta(
    'feelsLike',
  );
  @override
  late final GeneratedColumn<double> feelsLike = GeneratedColumn<double>(
    'feels_like',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dewPointMeta = const VerificationMeta(
    'dewPoint',
  );
  @override
  late final GeneratedColumn<double> dewPoint = GeneratedColumn<double>(
    'dew_point',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _visibilityMeta = const VerificationMeta(
    'visibility',
  );
  @override
  late final GeneratedColumn<double> visibility = GeneratedColumn<double>(
    'visibility',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uvIndexMeta = const VerificationMeta(
    'uvIndex',
  );
  @override
  late final GeneratedColumn<double> uvIndex = GeneratedColumn<double>(
    'uv_index',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _snowfallMeta = const VerificationMeta(
    'snowfall',
  );
  @override
  late final GeneratedColumn<double> snowfall = GeneratedColumn<double>(
    'snowfall',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherCodeMeta = const VerificationMeta(
    'weatherCode',
  );
  @override
  late final GeneratedColumn<int> weatherCode = GeneratedColumn<int>(
    'weather_code',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherIconMeta = const VerificationMeta(
    'weatherIcon',
  );
  @override
  late final GeneratedColumn<String> weatherIcon = GeneratedColumn<String>(
    'weather_icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherDescriptionMeta =
      const VerificationMeta('weatherDescription');
  @override
  late final GeneratedColumn<String> weatherDescription =
      GeneratedColumn<String>(
        'weather_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sunriseMeta = const VerificationMeta(
    'sunrise',
  );
  @override
  late final GeneratedColumn<DateTime> sunrise = GeneratedColumn<DateTime>(
    'sunrise',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sunsetMeta = const VerificationMeta('sunset');
  @override
  late final GeneratedColumn<DateTime> sunset = GeneratedColumn<DateTime>(
    'sunset',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stationId,
    providerId,
    timestamp,
    fetchedAt,
    temperature,
    windSpeed,
    windGust,
    windDirection,
    pressure,
    humidity,
    precipitation,
    cloudCover,
    feelsLike,
    dewPoint,
    visibility,
    uvIndex,
    snowfall,
    weatherCode,
    weatherIcon,
    weatherDescription,
    sunrise,
    sunset,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_observations';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherObservation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('station_id')) {
      context.handle(
        _stationIdMeta,
        stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('wind_speed')) {
      context.handle(
        _windSpeedMeta,
        windSpeed.isAcceptableOrUnknown(data['wind_speed']!, _windSpeedMeta),
      );
    }
    if (data.containsKey('wind_gust')) {
      context.handle(
        _windGustMeta,
        windGust.isAcceptableOrUnknown(data['wind_gust']!, _windGustMeta),
      );
    }
    if (data.containsKey('wind_direction')) {
      context.handle(
        _windDirectionMeta,
        windDirection.isAcceptableOrUnknown(
          data['wind_direction']!,
          _windDirectionMeta,
        ),
      );
    }
    if (data.containsKey('pressure')) {
      context.handle(
        _pressureMeta,
        pressure.isAcceptableOrUnknown(data['pressure']!, _pressureMeta),
      );
    }
    if (data.containsKey('humidity')) {
      context.handle(
        _humidityMeta,
        humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta),
      );
    }
    if (data.containsKey('precipitation')) {
      context.handle(
        _precipitationMeta,
        precipitation.isAcceptableOrUnknown(
          data['precipitation']!,
          _precipitationMeta,
        ),
      );
    }
    if (data.containsKey('cloud_cover')) {
      context.handle(
        _cloudCoverMeta,
        cloudCover.isAcceptableOrUnknown(data['cloud_cover']!, _cloudCoverMeta),
      );
    }
    if (data.containsKey('feels_like')) {
      context.handle(
        _feelsLikeMeta,
        feelsLike.isAcceptableOrUnknown(data['feels_like']!, _feelsLikeMeta),
      );
    }
    if (data.containsKey('dew_point')) {
      context.handle(
        _dewPointMeta,
        dewPoint.isAcceptableOrUnknown(data['dew_point']!, _dewPointMeta),
      );
    }
    if (data.containsKey('visibility')) {
      context.handle(
        _visibilityMeta,
        visibility.isAcceptableOrUnknown(data['visibility']!, _visibilityMeta),
      );
    }
    if (data.containsKey('uv_index')) {
      context.handle(
        _uvIndexMeta,
        uvIndex.isAcceptableOrUnknown(data['uv_index']!, _uvIndexMeta),
      );
    }
    if (data.containsKey('snowfall')) {
      context.handle(
        _snowfallMeta,
        snowfall.isAcceptableOrUnknown(data['snowfall']!, _snowfallMeta),
      );
    }
    if (data.containsKey('weather_code')) {
      context.handle(
        _weatherCodeMeta,
        weatherCode.isAcceptableOrUnknown(
          data['weather_code']!,
          _weatherCodeMeta,
        ),
      );
    }
    if (data.containsKey('weather_icon')) {
      context.handle(
        _weatherIconMeta,
        weatherIcon.isAcceptableOrUnknown(
          data['weather_icon']!,
          _weatherIconMeta,
        ),
      );
    }
    if (data.containsKey('weather_description')) {
      context.handle(
        _weatherDescriptionMeta,
        weatherDescription.isAcceptableOrUnknown(
          data['weather_description']!,
          _weatherDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('sunrise')) {
      context.handle(
        _sunriseMeta,
        sunrise.isAcceptableOrUnknown(data['sunrise']!, _sunriseMeta),
      );
    }
    if (data.containsKey('sunset')) {
      context.handle(
        _sunsetMeta,
        sunset.isAcceptableOrUnknown(data['sunset']!, _sunsetMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {stationId, timestamp, providerId},
  ];
  @override
  WeatherObservation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherObservation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}station_id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      windSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_speed'],
      ),
      windGust: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_gust'],
      ),
      windDirection: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_direction'],
      ),
      pressure: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure'],
      ),
      humidity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}humidity'],
      ),
      precipitation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precipitation'],
      ),
      cloudCover: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cloud_cover'],
      ),
      feelsLike: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}feels_like'],
      ),
      dewPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dew_point'],
      ),
      visibility: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}visibility'],
      ),
      uvIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}uv_index'],
      ),
      snowfall: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}snowfall'],
      ),
      weatherCode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weather_code'],
      ),
      weatherIcon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_icon'],
      ),
      weatherDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_description'],
      ),
      sunrise: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sunrise'],
      ),
      sunset: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sunset'],
      ),
    );
  }

  @override
  $WeatherObservationsTable createAlias(String alias) {
    return $WeatherObservationsTable(attachedDatabase, alias);
  }
}

class WeatherObservation extends DataClass
    implements Insertable<WeatherObservation> {
  final int id;
  final int stationId;
  final int providerId;
  final DateTime timestamp;
  final DateTime fetchedAt;
  final double? temperature;
  final double? windSpeed;
  final double? windGust;
  final double? windDirection;
  final double? pressure;
  final double? humidity;
  final double? precipitation;
  final double? cloudCover;
  final double? feelsLike;
  final double? dewPoint;
  final double? visibility;
  final double? uvIndex;
  final double? snowfall;
  final int? weatherCode;
  final String? weatherIcon;
  final String? weatherDescription;
  final DateTime? sunrise;
  final DateTime? sunset;
  const WeatherObservation({
    required this.id,
    required this.stationId,
    required this.providerId,
    required this.timestamp,
    required this.fetchedAt,
    this.temperature,
    this.windSpeed,
    this.windGust,
    this.windDirection,
    this.pressure,
    this.humidity,
    this.precipitation,
    this.cloudCover,
    this.feelsLike,
    this.dewPoint,
    this.visibility,
    this.uvIndex,
    this.snowfall,
    this.weatherCode,
    this.weatherIcon,
    this.weatherDescription,
    this.sunrise,
    this.sunset,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_id'] = Variable<int>(stationId);
    map['provider_id'] = Variable<int>(providerId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    if (!nullToAbsent || windSpeed != null) {
      map['wind_speed'] = Variable<double>(windSpeed);
    }
    if (!nullToAbsent || windGust != null) {
      map['wind_gust'] = Variable<double>(windGust);
    }
    if (!nullToAbsent || windDirection != null) {
      map['wind_direction'] = Variable<double>(windDirection);
    }
    if (!nullToAbsent || pressure != null) {
      map['pressure'] = Variable<double>(pressure);
    }
    if (!nullToAbsent || humidity != null) {
      map['humidity'] = Variable<double>(humidity);
    }
    if (!nullToAbsent || precipitation != null) {
      map['precipitation'] = Variable<double>(precipitation);
    }
    if (!nullToAbsent || cloudCover != null) {
      map['cloud_cover'] = Variable<double>(cloudCover);
    }
    if (!nullToAbsent || feelsLike != null) {
      map['feels_like'] = Variable<double>(feelsLike);
    }
    if (!nullToAbsent || dewPoint != null) {
      map['dew_point'] = Variable<double>(dewPoint);
    }
    if (!nullToAbsent || visibility != null) {
      map['visibility'] = Variable<double>(visibility);
    }
    if (!nullToAbsent || uvIndex != null) {
      map['uv_index'] = Variable<double>(uvIndex);
    }
    if (!nullToAbsent || snowfall != null) {
      map['snowfall'] = Variable<double>(snowfall);
    }
    if (!nullToAbsent || weatherCode != null) {
      map['weather_code'] = Variable<int>(weatherCode);
    }
    if (!nullToAbsent || weatherIcon != null) {
      map['weather_icon'] = Variable<String>(weatherIcon);
    }
    if (!nullToAbsent || weatherDescription != null) {
      map['weather_description'] = Variable<String>(weatherDescription);
    }
    if (!nullToAbsent || sunrise != null) {
      map['sunrise'] = Variable<DateTime>(sunrise);
    }
    if (!nullToAbsent || sunset != null) {
      map['sunset'] = Variable<DateTime>(sunset);
    }
    return map;
  }

  WeatherObservationsCompanion toCompanion(bool nullToAbsent) {
    return WeatherObservationsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      providerId: Value(providerId),
      timestamp: Value(timestamp),
      fetchedAt: Value(fetchedAt),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      windSpeed: windSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(windSpeed),
      windGust: windGust == null && nullToAbsent
          ? const Value.absent()
          : Value(windGust),
      windDirection: windDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(windDirection),
      pressure: pressure == null && nullToAbsent
          ? const Value.absent()
          : Value(pressure),
      humidity: humidity == null && nullToAbsent
          ? const Value.absent()
          : Value(humidity),
      precipitation: precipitation == null && nullToAbsent
          ? const Value.absent()
          : Value(precipitation),
      cloudCover: cloudCover == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudCover),
      feelsLike: feelsLike == null && nullToAbsent
          ? const Value.absent()
          : Value(feelsLike),
      dewPoint: dewPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(dewPoint),
      visibility: visibility == null && nullToAbsent
          ? const Value.absent()
          : Value(visibility),
      uvIndex: uvIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(uvIndex),
      snowfall: snowfall == null && nullToAbsent
          ? const Value.absent()
          : Value(snowfall),
      weatherCode: weatherCode == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherCode),
      weatherIcon: weatherIcon == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherIcon),
      weatherDescription: weatherDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherDescription),
      sunrise: sunrise == null && nullToAbsent
          ? const Value.absent()
          : Value(sunrise),
      sunset: sunset == null && nullToAbsent
          ? const Value.absent()
          : Value(sunset),
    );
  }

  factory WeatherObservation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherObservation(
      id: serializer.fromJson<int>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      providerId: serializer.fromJson<int>(json['providerId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      windSpeed: serializer.fromJson<double?>(json['windSpeed']),
      windGust: serializer.fromJson<double?>(json['windGust']),
      windDirection: serializer.fromJson<double?>(json['windDirection']),
      pressure: serializer.fromJson<double?>(json['pressure']),
      humidity: serializer.fromJson<double?>(json['humidity']),
      precipitation: serializer.fromJson<double?>(json['precipitation']),
      cloudCover: serializer.fromJson<double?>(json['cloudCover']),
      feelsLike: serializer.fromJson<double?>(json['feelsLike']),
      dewPoint: serializer.fromJson<double?>(json['dewPoint']),
      visibility: serializer.fromJson<double?>(json['visibility']),
      uvIndex: serializer.fromJson<double?>(json['uvIndex']),
      snowfall: serializer.fromJson<double?>(json['snowfall']),
      weatherCode: serializer.fromJson<int?>(json['weatherCode']),
      weatherIcon: serializer.fromJson<String?>(json['weatherIcon']),
      weatherDescription: serializer.fromJson<String?>(
        json['weatherDescription'],
      ),
      sunrise: serializer.fromJson<DateTime?>(json['sunrise']),
      sunset: serializer.fromJson<DateTime?>(json['sunset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationId': serializer.toJson<int>(stationId),
      'providerId': serializer.toJson<int>(providerId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'temperature': serializer.toJson<double?>(temperature),
      'windSpeed': serializer.toJson<double?>(windSpeed),
      'windGust': serializer.toJson<double?>(windGust),
      'windDirection': serializer.toJson<double?>(windDirection),
      'pressure': serializer.toJson<double?>(pressure),
      'humidity': serializer.toJson<double?>(humidity),
      'precipitation': serializer.toJson<double?>(precipitation),
      'cloudCover': serializer.toJson<double?>(cloudCover),
      'feelsLike': serializer.toJson<double?>(feelsLike),
      'dewPoint': serializer.toJson<double?>(dewPoint),
      'visibility': serializer.toJson<double?>(visibility),
      'uvIndex': serializer.toJson<double?>(uvIndex),
      'snowfall': serializer.toJson<double?>(snowfall),
      'weatherCode': serializer.toJson<int?>(weatherCode),
      'weatherIcon': serializer.toJson<String?>(weatherIcon),
      'weatherDescription': serializer.toJson<String?>(weatherDescription),
      'sunrise': serializer.toJson<DateTime?>(sunrise),
      'sunset': serializer.toJson<DateTime?>(sunset),
    };
  }

  WeatherObservation copyWith({
    int? id,
    int? stationId,
    int? providerId,
    DateTime? timestamp,
    DateTime? fetchedAt,
    Value<double?> temperature = const Value.absent(),
    Value<double?> windSpeed = const Value.absent(),
    Value<double?> windGust = const Value.absent(),
    Value<double?> windDirection = const Value.absent(),
    Value<double?> pressure = const Value.absent(),
    Value<double?> humidity = const Value.absent(),
    Value<double?> precipitation = const Value.absent(),
    Value<double?> cloudCover = const Value.absent(),
    Value<double?> feelsLike = const Value.absent(),
    Value<double?> dewPoint = const Value.absent(),
    Value<double?> visibility = const Value.absent(),
    Value<double?> uvIndex = const Value.absent(),
    Value<double?> snowfall = const Value.absent(),
    Value<int?> weatherCode = const Value.absent(),
    Value<String?> weatherIcon = const Value.absent(),
    Value<String?> weatherDescription = const Value.absent(),
    Value<DateTime?> sunrise = const Value.absent(),
    Value<DateTime?> sunset = const Value.absent(),
  }) => WeatherObservation(
    id: id ?? this.id,
    stationId: stationId ?? this.stationId,
    providerId: providerId ?? this.providerId,
    timestamp: timestamp ?? this.timestamp,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    temperature: temperature.present ? temperature.value : this.temperature,
    windSpeed: windSpeed.present ? windSpeed.value : this.windSpeed,
    windGust: windGust.present ? windGust.value : this.windGust,
    windDirection: windDirection.present
        ? windDirection.value
        : this.windDirection,
    pressure: pressure.present ? pressure.value : this.pressure,
    humidity: humidity.present ? humidity.value : this.humidity,
    precipitation: precipitation.present
        ? precipitation.value
        : this.precipitation,
    cloudCover: cloudCover.present ? cloudCover.value : this.cloudCover,
    feelsLike: feelsLike.present ? feelsLike.value : this.feelsLike,
    dewPoint: dewPoint.present ? dewPoint.value : this.dewPoint,
    visibility: visibility.present ? visibility.value : this.visibility,
    uvIndex: uvIndex.present ? uvIndex.value : this.uvIndex,
    snowfall: snowfall.present ? snowfall.value : this.snowfall,
    weatherCode: weatherCode.present ? weatherCode.value : this.weatherCode,
    weatherIcon: weatherIcon.present ? weatherIcon.value : this.weatherIcon,
    weatherDescription: weatherDescription.present
        ? weatherDescription.value
        : this.weatherDescription,
    sunrise: sunrise.present ? sunrise.value : this.sunrise,
    sunset: sunset.present ? sunset.value : this.sunset,
  );
  WeatherObservation copyWithCompanion(WeatherObservationsCompanion data) {
    return WeatherObservation(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      windSpeed: data.windSpeed.present ? data.windSpeed.value : this.windSpeed,
      windGust: data.windGust.present ? data.windGust.value : this.windGust,
      windDirection: data.windDirection.present
          ? data.windDirection.value
          : this.windDirection,
      pressure: data.pressure.present ? data.pressure.value : this.pressure,
      humidity: data.humidity.present ? data.humidity.value : this.humidity,
      precipitation: data.precipitation.present
          ? data.precipitation.value
          : this.precipitation,
      cloudCover: data.cloudCover.present
          ? data.cloudCover.value
          : this.cloudCover,
      feelsLike: data.feelsLike.present ? data.feelsLike.value : this.feelsLike,
      dewPoint: data.dewPoint.present ? data.dewPoint.value : this.dewPoint,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      uvIndex: data.uvIndex.present ? data.uvIndex.value : this.uvIndex,
      snowfall: data.snowfall.present ? data.snowfall.value : this.snowfall,
      weatherCode: data.weatherCode.present
          ? data.weatherCode.value
          : this.weatherCode,
      weatherIcon: data.weatherIcon.present
          ? data.weatherIcon.value
          : this.weatherIcon,
      weatherDescription: data.weatherDescription.present
          ? data.weatherDescription.value
          : this.weatherDescription,
      sunrise: data.sunrise.present ? data.sunrise.value : this.sunrise,
      sunset: data.sunset.present ? data.sunset.value : this.sunset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherObservation(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('timestamp: $timestamp, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('temperature: $temperature, ')
          ..write('windSpeed: $windSpeed, ')
          ..write('windGust: $windGust, ')
          ..write('windDirection: $windDirection, ')
          ..write('pressure: $pressure, ')
          ..write('humidity: $humidity, ')
          ..write('precipitation: $precipitation, ')
          ..write('cloudCover: $cloudCover, ')
          ..write('feelsLike: $feelsLike, ')
          ..write('dewPoint: $dewPoint, ')
          ..write('visibility: $visibility, ')
          ..write('uvIndex: $uvIndex, ')
          ..write('snowfall: $snowfall, ')
          ..write('weatherCode: $weatherCode, ')
          ..write('weatherIcon: $weatherIcon, ')
          ..write('weatherDescription: $weatherDescription, ')
          ..write('sunrise: $sunrise, ')
          ..write('sunset: $sunset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    stationId,
    providerId,
    timestamp,
    fetchedAt,
    temperature,
    windSpeed,
    windGust,
    windDirection,
    pressure,
    humidity,
    precipitation,
    cloudCover,
    feelsLike,
    dewPoint,
    visibility,
    uvIndex,
    snowfall,
    weatherCode,
    weatherIcon,
    weatherDescription,
    sunrise,
    sunset,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherObservation &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.providerId == this.providerId &&
          other.timestamp == this.timestamp &&
          other.fetchedAt == this.fetchedAt &&
          other.temperature == this.temperature &&
          other.windSpeed == this.windSpeed &&
          other.windGust == this.windGust &&
          other.windDirection == this.windDirection &&
          other.pressure == this.pressure &&
          other.humidity == this.humidity &&
          other.precipitation == this.precipitation &&
          other.cloudCover == this.cloudCover &&
          other.feelsLike == this.feelsLike &&
          other.dewPoint == this.dewPoint &&
          other.visibility == this.visibility &&
          other.uvIndex == this.uvIndex &&
          other.snowfall == this.snowfall &&
          other.weatherCode == this.weatherCode &&
          other.weatherIcon == this.weatherIcon &&
          other.weatherDescription == this.weatherDescription &&
          other.sunrise == this.sunrise &&
          other.sunset == this.sunset);
}

class WeatherObservationsCompanion extends UpdateCompanion<WeatherObservation> {
  final Value<int> id;
  final Value<int> stationId;
  final Value<int> providerId;
  final Value<DateTime> timestamp;
  final Value<DateTime> fetchedAt;
  final Value<double?> temperature;
  final Value<double?> windSpeed;
  final Value<double?> windGust;
  final Value<double?> windDirection;
  final Value<double?> pressure;
  final Value<double?> humidity;
  final Value<double?> precipitation;
  final Value<double?> cloudCover;
  final Value<double?> feelsLike;
  final Value<double?> dewPoint;
  final Value<double?> visibility;
  final Value<double?> uvIndex;
  final Value<double?> snowfall;
  final Value<int?> weatherCode;
  final Value<String?> weatherIcon;
  final Value<String?> weatherDescription;
  final Value<DateTime?> sunrise;
  final Value<DateTime?> sunset;
  const WeatherObservationsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.temperature = const Value.absent(),
    this.windSpeed = const Value.absent(),
    this.windGust = const Value.absent(),
    this.windDirection = const Value.absent(),
    this.pressure = const Value.absent(),
    this.humidity = const Value.absent(),
    this.precipitation = const Value.absent(),
    this.cloudCover = const Value.absent(),
    this.feelsLike = const Value.absent(),
    this.dewPoint = const Value.absent(),
    this.visibility = const Value.absent(),
    this.uvIndex = const Value.absent(),
    this.snowfall = const Value.absent(),
    this.weatherCode = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.weatherDescription = const Value.absent(),
    this.sunrise = const Value.absent(),
    this.sunset = const Value.absent(),
  });
  WeatherObservationsCompanion.insert({
    this.id = const Value.absent(),
    required int stationId,
    required int providerId,
    required DateTime timestamp,
    required DateTime fetchedAt,
    this.temperature = const Value.absent(),
    this.windSpeed = const Value.absent(),
    this.windGust = const Value.absent(),
    this.windDirection = const Value.absent(),
    this.pressure = const Value.absent(),
    this.humidity = const Value.absent(),
    this.precipitation = const Value.absent(),
    this.cloudCover = const Value.absent(),
    this.feelsLike = const Value.absent(),
    this.dewPoint = const Value.absent(),
    this.visibility = const Value.absent(),
    this.uvIndex = const Value.absent(),
    this.snowfall = const Value.absent(),
    this.weatherCode = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.weatherDescription = const Value.absent(),
    this.sunrise = const Value.absent(),
    this.sunset = const Value.absent(),
  }) : stationId = Value(stationId),
       providerId = Value(providerId),
       timestamp = Value(timestamp),
       fetchedAt = Value(fetchedAt);
  static Insertable<WeatherObservation> custom({
    Expression<int>? id,
    Expression<int>? stationId,
    Expression<int>? providerId,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? fetchedAt,
    Expression<double>? temperature,
    Expression<double>? windSpeed,
    Expression<double>? windGust,
    Expression<double>? windDirection,
    Expression<double>? pressure,
    Expression<double>? humidity,
    Expression<double>? precipitation,
    Expression<double>? cloudCover,
    Expression<double>? feelsLike,
    Expression<double>? dewPoint,
    Expression<double>? visibility,
    Expression<double>? uvIndex,
    Expression<double>? snowfall,
    Expression<int>? weatherCode,
    Expression<String>? weatherIcon,
    Expression<String>? weatherDescription,
    Expression<DateTime>? sunrise,
    Expression<DateTime>? sunset,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (providerId != null) 'provider_id': providerId,
      if (timestamp != null) 'timestamp': timestamp,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (temperature != null) 'temperature': temperature,
      if (windSpeed != null) 'wind_speed': windSpeed,
      if (windGust != null) 'wind_gust': windGust,
      if (windDirection != null) 'wind_direction': windDirection,
      if (pressure != null) 'pressure': pressure,
      if (humidity != null) 'humidity': humidity,
      if (precipitation != null) 'precipitation': precipitation,
      if (cloudCover != null) 'cloud_cover': cloudCover,
      if (feelsLike != null) 'feels_like': feelsLike,
      if (dewPoint != null) 'dew_point': dewPoint,
      if (visibility != null) 'visibility': visibility,
      if (uvIndex != null) 'uv_index': uvIndex,
      if (snowfall != null) 'snowfall': snowfall,
      if (weatherCode != null) 'weather_code': weatherCode,
      if (weatherIcon != null) 'weather_icon': weatherIcon,
      if (weatherDescription != null) 'weather_description': weatherDescription,
      if (sunrise != null) 'sunrise': sunrise,
      if (sunset != null) 'sunset': sunset,
    });
  }

  WeatherObservationsCompanion copyWith({
    Value<int>? id,
    Value<int>? stationId,
    Value<int>? providerId,
    Value<DateTime>? timestamp,
    Value<DateTime>? fetchedAt,
    Value<double?>? temperature,
    Value<double?>? windSpeed,
    Value<double?>? windGust,
    Value<double?>? windDirection,
    Value<double?>? pressure,
    Value<double?>? humidity,
    Value<double?>? precipitation,
    Value<double?>? cloudCover,
    Value<double?>? feelsLike,
    Value<double?>? dewPoint,
    Value<double?>? visibility,
    Value<double?>? uvIndex,
    Value<double?>? snowfall,
    Value<int?>? weatherCode,
    Value<String?>? weatherIcon,
    Value<String?>? weatherDescription,
    Value<DateTime?>? sunrise,
    Value<DateTime?>? sunset,
  }) {
    return WeatherObservationsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      providerId: providerId ?? this.providerId,
      timestamp: timestamp ?? this.timestamp,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      temperature: temperature ?? this.temperature,
      windSpeed: windSpeed ?? this.windSpeed,
      windGust: windGust ?? this.windGust,
      windDirection: windDirection ?? this.windDirection,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      precipitation: precipitation ?? this.precipitation,
      cloudCover: cloudCover ?? this.cloudCover,
      feelsLike: feelsLike ?? this.feelsLike,
      dewPoint: dewPoint ?? this.dewPoint,
      visibility: visibility ?? this.visibility,
      uvIndex: uvIndex ?? this.uvIndex,
      snowfall: snowfall ?? this.snowfall,
      weatherCode: weatherCode ?? this.weatherCode,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (windSpeed.present) {
      map['wind_speed'] = Variable<double>(windSpeed.value);
    }
    if (windGust.present) {
      map['wind_gust'] = Variable<double>(windGust.value);
    }
    if (windDirection.present) {
      map['wind_direction'] = Variable<double>(windDirection.value);
    }
    if (pressure.present) {
      map['pressure'] = Variable<double>(pressure.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<double>(humidity.value);
    }
    if (precipitation.present) {
      map['precipitation'] = Variable<double>(precipitation.value);
    }
    if (cloudCover.present) {
      map['cloud_cover'] = Variable<double>(cloudCover.value);
    }
    if (feelsLike.present) {
      map['feels_like'] = Variable<double>(feelsLike.value);
    }
    if (dewPoint.present) {
      map['dew_point'] = Variable<double>(dewPoint.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<double>(visibility.value);
    }
    if (uvIndex.present) {
      map['uv_index'] = Variable<double>(uvIndex.value);
    }
    if (snowfall.present) {
      map['snowfall'] = Variable<double>(snowfall.value);
    }
    if (weatherCode.present) {
      map['weather_code'] = Variable<int>(weatherCode.value);
    }
    if (weatherIcon.present) {
      map['weather_icon'] = Variable<String>(weatherIcon.value);
    }
    if (weatherDescription.present) {
      map['weather_description'] = Variable<String>(weatherDescription.value);
    }
    if (sunrise.present) {
      map['sunrise'] = Variable<DateTime>(sunrise.value);
    }
    if (sunset.present) {
      map['sunset'] = Variable<DateTime>(sunset.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherObservationsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('timestamp: $timestamp, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('temperature: $temperature, ')
          ..write('windSpeed: $windSpeed, ')
          ..write('windGust: $windGust, ')
          ..write('windDirection: $windDirection, ')
          ..write('pressure: $pressure, ')
          ..write('humidity: $humidity, ')
          ..write('precipitation: $precipitation, ')
          ..write('cloudCover: $cloudCover, ')
          ..write('feelsLike: $feelsLike, ')
          ..write('dewPoint: $dewPoint, ')
          ..write('visibility: $visibility, ')
          ..write('uvIndex: $uvIndex, ')
          ..write('snowfall: $snowfall, ')
          ..write('weatherCode: $weatherCode, ')
          ..write('weatherIcon: $weatherIcon, ')
          ..write('weatherDescription: $weatherDescription, ')
          ..write('sunrise: $sunrise, ')
          ..write('sunset: $sunset')
          ..write(')'))
        .toString();
  }
}

class $WeatherForecastsTable extends WeatherForecasts
    with TableInfo<$WeatherForecastsTable, WeatherForecast> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherForecastsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stationIdMeta = const VerificationMeta(
    'stationId',
  );
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
    'station_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_stations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _forecastTimeMeta = const VerificationMeta(
    'forecastTime',
  );
  @override
  late final GeneratedColumn<DateTime> forecastTime = GeneratedColumn<DateTime>(
    'forecast_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
    'issued_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureMinMeta = const VerificationMeta(
    'temperatureMin',
  );
  @override
  late final GeneratedColumn<double> temperatureMin = GeneratedColumn<double>(
    'temperature_min',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperatureMaxMeta = const VerificationMeta(
    'temperatureMax',
  );
  @override
  late final GeneratedColumn<double> temperatureMax = GeneratedColumn<double>(
    'temperature_max',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feelsLikeMeta = const VerificationMeta(
    'feelsLike',
  );
  @override
  late final GeneratedColumn<double> feelsLike = GeneratedColumn<double>(
    'feels_like',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _windSpeedMeta = const VerificationMeta(
    'windSpeed',
  );
  @override
  late final GeneratedColumn<double> windSpeed = GeneratedColumn<double>(
    'wind_speed',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _windGustMeta = const VerificationMeta(
    'windGust',
  );
  @override
  late final GeneratedColumn<double> windGust = GeneratedColumn<double>(
    'wind_gust',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _windDirectionMeta = const VerificationMeta(
    'windDirection',
  );
  @override
  late final GeneratedColumn<double> windDirection = GeneratedColumn<double>(
    'wind_direction',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pressureMeta = const VerificationMeta(
    'pressure',
  );
  @override
  late final GeneratedColumn<double> pressure = GeneratedColumn<double>(
    'pressure',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _humidityMeta = const VerificationMeta(
    'humidity',
  );
  @override
  late final GeneratedColumn<double> humidity = GeneratedColumn<double>(
    'humidity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dewPointMeta = const VerificationMeta(
    'dewPoint',
  );
  @override
  late final GeneratedColumn<double> dewPoint = GeneratedColumn<double>(
    'dew_point',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precipitationMeta = const VerificationMeta(
    'precipitation',
  );
  @override
  late final GeneratedColumn<double> precipitation = GeneratedColumn<double>(
    'precipitation',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precipitationProbabilityMeta =
      const VerificationMeta('precipitationProbability');
  @override
  late final GeneratedColumn<double> precipitationProbability =
      GeneratedColumn<double>(
        'precipitation_probability',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _cloudCoverMeta = const VerificationMeta(
    'cloudCover',
  );
  @override
  late final GeneratedColumn<double> cloudCover = GeneratedColumn<double>(
    'cloud_cover',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uvIndexMeta = const VerificationMeta(
    'uvIndex',
  );
  @override
  late final GeneratedColumn<double> uvIndex = GeneratedColumn<double>(
    'uv_index',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherIconMeta = const VerificationMeta(
    'weatherIcon',
  );
  @override
  late final GeneratedColumn<String> weatherIcon = GeneratedColumn<String>(
    'weather_icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weatherDescriptionMeta =
      const VerificationMeta('weatherDescription');
  @override
  late final GeneratedColumn<String> weatherDescription =
      GeneratedColumn<String>(
        'weather_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stationId,
    providerId,
    forecastTime,
    issuedAt,
    fetchedAt,
    temperature,
    temperatureMin,
    temperatureMax,
    feelsLike,
    windSpeed,
    windGust,
    windDirection,
    pressure,
    humidity,
    dewPoint,
    precipitation,
    precipitationProbability,
    cloudCover,
    uvIndex,
    weatherIcon,
    weatherDescription,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_forecasts';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherForecast> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('station_id')) {
      context.handle(
        _stationIdMeta,
        stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('forecast_time')) {
      context.handle(
        _forecastTimeMeta,
        forecastTime.isAcceptableOrUnknown(
          data['forecast_time']!,
          _forecastTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_forecastTimeMeta);
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_issuedAtMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('temperature_min')) {
      context.handle(
        _temperatureMinMeta,
        temperatureMin.isAcceptableOrUnknown(
          data['temperature_min']!,
          _temperatureMinMeta,
        ),
      );
    }
    if (data.containsKey('temperature_max')) {
      context.handle(
        _temperatureMaxMeta,
        temperatureMax.isAcceptableOrUnknown(
          data['temperature_max']!,
          _temperatureMaxMeta,
        ),
      );
    }
    if (data.containsKey('feels_like')) {
      context.handle(
        _feelsLikeMeta,
        feelsLike.isAcceptableOrUnknown(data['feels_like']!, _feelsLikeMeta),
      );
    }
    if (data.containsKey('wind_speed')) {
      context.handle(
        _windSpeedMeta,
        windSpeed.isAcceptableOrUnknown(data['wind_speed']!, _windSpeedMeta),
      );
    }
    if (data.containsKey('wind_gust')) {
      context.handle(
        _windGustMeta,
        windGust.isAcceptableOrUnknown(data['wind_gust']!, _windGustMeta),
      );
    }
    if (data.containsKey('wind_direction')) {
      context.handle(
        _windDirectionMeta,
        windDirection.isAcceptableOrUnknown(
          data['wind_direction']!,
          _windDirectionMeta,
        ),
      );
    }
    if (data.containsKey('pressure')) {
      context.handle(
        _pressureMeta,
        pressure.isAcceptableOrUnknown(data['pressure']!, _pressureMeta),
      );
    }
    if (data.containsKey('humidity')) {
      context.handle(
        _humidityMeta,
        humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta),
      );
    }
    if (data.containsKey('dew_point')) {
      context.handle(
        _dewPointMeta,
        dewPoint.isAcceptableOrUnknown(data['dew_point']!, _dewPointMeta),
      );
    }
    if (data.containsKey('precipitation')) {
      context.handle(
        _precipitationMeta,
        precipitation.isAcceptableOrUnknown(
          data['precipitation']!,
          _precipitationMeta,
        ),
      );
    }
    if (data.containsKey('precipitation_probability')) {
      context.handle(
        _precipitationProbabilityMeta,
        precipitationProbability.isAcceptableOrUnknown(
          data['precipitation_probability']!,
          _precipitationProbabilityMeta,
        ),
      );
    }
    if (data.containsKey('cloud_cover')) {
      context.handle(
        _cloudCoverMeta,
        cloudCover.isAcceptableOrUnknown(data['cloud_cover']!, _cloudCoverMeta),
      );
    }
    if (data.containsKey('uv_index')) {
      context.handle(
        _uvIndexMeta,
        uvIndex.isAcceptableOrUnknown(data['uv_index']!, _uvIndexMeta),
      );
    }
    if (data.containsKey('weather_icon')) {
      context.handle(
        _weatherIconMeta,
        weatherIcon.isAcceptableOrUnknown(
          data['weather_icon']!,
          _weatherIconMeta,
        ),
      );
    }
    if (data.containsKey('weather_description')) {
      context.handle(
        _weatherDescriptionMeta,
        weatherDescription.isAcceptableOrUnknown(
          data['weather_description']!,
          _weatherDescriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {stationId, forecastTime, providerId, issuedAt},
  ];
  @override
  WeatherForecast map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherForecast(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}station_id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      forecastTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}forecast_time'],
      )!,
      issuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issued_at'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      ),
      temperatureMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature_min'],
      ),
      temperatureMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature_max'],
      ),
      feelsLike: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}feels_like'],
      ),
      windSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_speed'],
      ),
      windGust: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_gust'],
      ),
      windDirection: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_direction'],
      ),
      pressure: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure'],
      ),
      humidity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}humidity'],
      ),
      dewPoint: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dew_point'],
      ),
      precipitation: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precipitation'],
      ),
      precipitationProbability: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precipitation_probability'],
      ),
      cloudCover: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cloud_cover'],
      ),
      uvIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}uv_index'],
      ),
      weatherIcon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_icon'],
      ),
      weatherDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_description'],
      ),
    );
  }

  @override
  $WeatherForecastsTable createAlias(String alias) {
    return $WeatherForecastsTable(attachedDatabase, alias);
  }
}

class WeatherForecast extends DataClass implements Insertable<WeatherForecast> {
  final int id;
  final int stationId;
  final int providerId;
  final DateTime forecastTime;
  final DateTime issuedAt;
  final DateTime fetchedAt;
  final double? temperature;
  final double? temperatureMin;
  final double? temperatureMax;
  final double? feelsLike;
  final double? windSpeed;
  final double? windGust;
  final double? windDirection;
  final double? pressure;
  final double? humidity;
  final double? dewPoint;
  final double? precipitation;
  final double? precipitationProbability;
  final double? cloudCover;
  final double? uvIndex;
  final String? weatherIcon;
  final String? weatherDescription;
  const WeatherForecast({
    required this.id,
    required this.stationId,
    required this.providerId,
    required this.forecastTime,
    required this.issuedAt,
    required this.fetchedAt,
    this.temperature,
    this.temperatureMin,
    this.temperatureMax,
    this.feelsLike,
    this.windSpeed,
    this.windGust,
    this.windDirection,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.precipitation,
    this.precipitationProbability,
    this.cloudCover,
    this.uvIndex,
    this.weatherIcon,
    this.weatherDescription,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_id'] = Variable<int>(stationId);
    map['provider_id'] = Variable<int>(providerId);
    map['forecast_time'] = Variable<DateTime>(forecastTime);
    map['issued_at'] = Variable<DateTime>(issuedAt);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    if (!nullToAbsent || temperature != null) {
      map['temperature'] = Variable<double>(temperature);
    }
    if (!nullToAbsent || temperatureMin != null) {
      map['temperature_min'] = Variable<double>(temperatureMin);
    }
    if (!nullToAbsent || temperatureMax != null) {
      map['temperature_max'] = Variable<double>(temperatureMax);
    }
    if (!nullToAbsent || feelsLike != null) {
      map['feels_like'] = Variable<double>(feelsLike);
    }
    if (!nullToAbsent || windSpeed != null) {
      map['wind_speed'] = Variable<double>(windSpeed);
    }
    if (!nullToAbsent || windGust != null) {
      map['wind_gust'] = Variable<double>(windGust);
    }
    if (!nullToAbsent || windDirection != null) {
      map['wind_direction'] = Variable<double>(windDirection);
    }
    if (!nullToAbsent || pressure != null) {
      map['pressure'] = Variable<double>(pressure);
    }
    if (!nullToAbsent || humidity != null) {
      map['humidity'] = Variable<double>(humidity);
    }
    if (!nullToAbsent || dewPoint != null) {
      map['dew_point'] = Variable<double>(dewPoint);
    }
    if (!nullToAbsent || precipitation != null) {
      map['precipitation'] = Variable<double>(precipitation);
    }
    if (!nullToAbsent || precipitationProbability != null) {
      map['precipitation_probability'] = Variable<double>(
        precipitationProbability,
      );
    }
    if (!nullToAbsent || cloudCover != null) {
      map['cloud_cover'] = Variable<double>(cloudCover);
    }
    if (!nullToAbsent || uvIndex != null) {
      map['uv_index'] = Variable<double>(uvIndex);
    }
    if (!nullToAbsent || weatherIcon != null) {
      map['weather_icon'] = Variable<String>(weatherIcon);
    }
    if (!nullToAbsent || weatherDescription != null) {
      map['weather_description'] = Variable<String>(weatherDescription);
    }
    return map;
  }

  WeatherForecastsCompanion toCompanion(bool nullToAbsent) {
    return WeatherForecastsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      providerId: Value(providerId),
      forecastTime: Value(forecastTime),
      issuedAt: Value(issuedAt),
      fetchedAt: Value(fetchedAt),
      temperature: temperature == null && nullToAbsent
          ? const Value.absent()
          : Value(temperature),
      temperatureMin: temperatureMin == null && nullToAbsent
          ? const Value.absent()
          : Value(temperatureMin),
      temperatureMax: temperatureMax == null && nullToAbsent
          ? const Value.absent()
          : Value(temperatureMax),
      feelsLike: feelsLike == null && nullToAbsent
          ? const Value.absent()
          : Value(feelsLike),
      windSpeed: windSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(windSpeed),
      windGust: windGust == null && nullToAbsent
          ? const Value.absent()
          : Value(windGust),
      windDirection: windDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(windDirection),
      pressure: pressure == null && nullToAbsent
          ? const Value.absent()
          : Value(pressure),
      humidity: humidity == null && nullToAbsent
          ? const Value.absent()
          : Value(humidity),
      dewPoint: dewPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(dewPoint),
      precipitation: precipitation == null && nullToAbsent
          ? const Value.absent()
          : Value(precipitation),
      precipitationProbability: precipitationProbability == null && nullToAbsent
          ? const Value.absent()
          : Value(precipitationProbability),
      cloudCover: cloudCover == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudCover),
      uvIndex: uvIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(uvIndex),
      weatherIcon: weatherIcon == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherIcon),
      weatherDescription: weatherDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherDescription),
    );
  }

  factory WeatherForecast.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherForecast(
      id: serializer.fromJson<int>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      providerId: serializer.fromJson<int>(json['providerId']),
      forecastTime: serializer.fromJson<DateTime>(json['forecastTime']),
      issuedAt: serializer.fromJson<DateTime>(json['issuedAt']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      temperature: serializer.fromJson<double?>(json['temperature']),
      temperatureMin: serializer.fromJson<double?>(json['temperatureMin']),
      temperatureMax: serializer.fromJson<double?>(json['temperatureMax']),
      feelsLike: serializer.fromJson<double?>(json['feelsLike']),
      windSpeed: serializer.fromJson<double?>(json['windSpeed']),
      windGust: serializer.fromJson<double?>(json['windGust']),
      windDirection: serializer.fromJson<double?>(json['windDirection']),
      pressure: serializer.fromJson<double?>(json['pressure']),
      humidity: serializer.fromJson<double?>(json['humidity']),
      dewPoint: serializer.fromJson<double?>(json['dewPoint']),
      precipitation: serializer.fromJson<double?>(json['precipitation']),
      precipitationProbability: serializer.fromJson<double?>(
        json['precipitationProbability'],
      ),
      cloudCover: serializer.fromJson<double?>(json['cloudCover']),
      uvIndex: serializer.fromJson<double?>(json['uvIndex']),
      weatherIcon: serializer.fromJson<String?>(json['weatherIcon']),
      weatherDescription: serializer.fromJson<String?>(
        json['weatherDescription'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationId': serializer.toJson<int>(stationId),
      'providerId': serializer.toJson<int>(providerId),
      'forecastTime': serializer.toJson<DateTime>(forecastTime),
      'issuedAt': serializer.toJson<DateTime>(issuedAt),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'temperature': serializer.toJson<double?>(temperature),
      'temperatureMin': serializer.toJson<double?>(temperatureMin),
      'temperatureMax': serializer.toJson<double?>(temperatureMax),
      'feelsLike': serializer.toJson<double?>(feelsLike),
      'windSpeed': serializer.toJson<double?>(windSpeed),
      'windGust': serializer.toJson<double?>(windGust),
      'windDirection': serializer.toJson<double?>(windDirection),
      'pressure': serializer.toJson<double?>(pressure),
      'humidity': serializer.toJson<double?>(humidity),
      'dewPoint': serializer.toJson<double?>(dewPoint),
      'precipitation': serializer.toJson<double?>(precipitation),
      'precipitationProbability': serializer.toJson<double?>(
        precipitationProbability,
      ),
      'cloudCover': serializer.toJson<double?>(cloudCover),
      'uvIndex': serializer.toJson<double?>(uvIndex),
      'weatherIcon': serializer.toJson<String?>(weatherIcon),
      'weatherDescription': serializer.toJson<String?>(weatherDescription),
    };
  }

  WeatherForecast copyWith({
    int? id,
    int? stationId,
    int? providerId,
    DateTime? forecastTime,
    DateTime? issuedAt,
    DateTime? fetchedAt,
    Value<double?> temperature = const Value.absent(),
    Value<double?> temperatureMin = const Value.absent(),
    Value<double?> temperatureMax = const Value.absent(),
    Value<double?> feelsLike = const Value.absent(),
    Value<double?> windSpeed = const Value.absent(),
    Value<double?> windGust = const Value.absent(),
    Value<double?> windDirection = const Value.absent(),
    Value<double?> pressure = const Value.absent(),
    Value<double?> humidity = const Value.absent(),
    Value<double?> dewPoint = const Value.absent(),
    Value<double?> precipitation = const Value.absent(),
    Value<double?> precipitationProbability = const Value.absent(),
    Value<double?> cloudCover = const Value.absent(),
    Value<double?> uvIndex = const Value.absent(),
    Value<String?> weatherIcon = const Value.absent(),
    Value<String?> weatherDescription = const Value.absent(),
  }) => WeatherForecast(
    id: id ?? this.id,
    stationId: stationId ?? this.stationId,
    providerId: providerId ?? this.providerId,
    forecastTime: forecastTime ?? this.forecastTime,
    issuedAt: issuedAt ?? this.issuedAt,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    temperature: temperature.present ? temperature.value : this.temperature,
    temperatureMin: temperatureMin.present
        ? temperatureMin.value
        : this.temperatureMin,
    temperatureMax: temperatureMax.present
        ? temperatureMax.value
        : this.temperatureMax,
    feelsLike: feelsLike.present ? feelsLike.value : this.feelsLike,
    windSpeed: windSpeed.present ? windSpeed.value : this.windSpeed,
    windGust: windGust.present ? windGust.value : this.windGust,
    windDirection: windDirection.present
        ? windDirection.value
        : this.windDirection,
    pressure: pressure.present ? pressure.value : this.pressure,
    humidity: humidity.present ? humidity.value : this.humidity,
    dewPoint: dewPoint.present ? dewPoint.value : this.dewPoint,
    precipitation: precipitation.present
        ? precipitation.value
        : this.precipitation,
    precipitationProbability: precipitationProbability.present
        ? precipitationProbability.value
        : this.precipitationProbability,
    cloudCover: cloudCover.present ? cloudCover.value : this.cloudCover,
    uvIndex: uvIndex.present ? uvIndex.value : this.uvIndex,
    weatherIcon: weatherIcon.present ? weatherIcon.value : this.weatherIcon,
    weatherDescription: weatherDescription.present
        ? weatherDescription.value
        : this.weatherDescription,
  );
  WeatherForecast copyWithCompanion(WeatherForecastsCompanion data) {
    return WeatherForecast(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      forecastTime: data.forecastTime.present
          ? data.forecastTime.value
          : this.forecastTime,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      temperatureMin: data.temperatureMin.present
          ? data.temperatureMin.value
          : this.temperatureMin,
      temperatureMax: data.temperatureMax.present
          ? data.temperatureMax.value
          : this.temperatureMax,
      feelsLike: data.feelsLike.present ? data.feelsLike.value : this.feelsLike,
      windSpeed: data.windSpeed.present ? data.windSpeed.value : this.windSpeed,
      windGust: data.windGust.present ? data.windGust.value : this.windGust,
      windDirection: data.windDirection.present
          ? data.windDirection.value
          : this.windDirection,
      pressure: data.pressure.present ? data.pressure.value : this.pressure,
      humidity: data.humidity.present ? data.humidity.value : this.humidity,
      dewPoint: data.dewPoint.present ? data.dewPoint.value : this.dewPoint,
      precipitation: data.precipitation.present
          ? data.precipitation.value
          : this.precipitation,
      precipitationProbability: data.precipitationProbability.present
          ? data.precipitationProbability.value
          : this.precipitationProbability,
      cloudCover: data.cloudCover.present
          ? data.cloudCover.value
          : this.cloudCover,
      uvIndex: data.uvIndex.present ? data.uvIndex.value : this.uvIndex,
      weatherIcon: data.weatherIcon.present
          ? data.weatherIcon.value
          : this.weatherIcon,
      weatherDescription: data.weatherDescription.present
          ? data.weatherDescription.value
          : this.weatherDescription,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherForecast(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('forecastTime: $forecastTime, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('temperature: $temperature, ')
          ..write('temperatureMin: $temperatureMin, ')
          ..write('temperatureMax: $temperatureMax, ')
          ..write('feelsLike: $feelsLike, ')
          ..write('windSpeed: $windSpeed, ')
          ..write('windGust: $windGust, ')
          ..write('windDirection: $windDirection, ')
          ..write('pressure: $pressure, ')
          ..write('humidity: $humidity, ')
          ..write('dewPoint: $dewPoint, ')
          ..write('precipitation: $precipitation, ')
          ..write('precipitationProbability: $precipitationProbability, ')
          ..write('cloudCover: $cloudCover, ')
          ..write('uvIndex: $uvIndex, ')
          ..write('weatherIcon: $weatherIcon, ')
          ..write('weatherDescription: $weatherDescription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    stationId,
    providerId,
    forecastTime,
    issuedAt,
    fetchedAt,
    temperature,
    temperatureMin,
    temperatureMax,
    feelsLike,
    windSpeed,
    windGust,
    windDirection,
    pressure,
    humidity,
    dewPoint,
    precipitation,
    precipitationProbability,
    cloudCover,
    uvIndex,
    weatherIcon,
    weatherDescription,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherForecast &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.providerId == this.providerId &&
          other.forecastTime == this.forecastTime &&
          other.issuedAt == this.issuedAt &&
          other.fetchedAt == this.fetchedAt &&
          other.temperature == this.temperature &&
          other.temperatureMin == this.temperatureMin &&
          other.temperatureMax == this.temperatureMax &&
          other.feelsLike == this.feelsLike &&
          other.windSpeed == this.windSpeed &&
          other.windGust == this.windGust &&
          other.windDirection == this.windDirection &&
          other.pressure == this.pressure &&
          other.humidity == this.humidity &&
          other.dewPoint == this.dewPoint &&
          other.precipitation == this.precipitation &&
          other.precipitationProbability == this.precipitationProbability &&
          other.cloudCover == this.cloudCover &&
          other.uvIndex == this.uvIndex &&
          other.weatherIcon == this.weatherIcon &&
          other.weatherDescription == this.weatherDescription);
}

class WeatherForecastsCompanion extends UpdateCompanion<WeatherForecast> {
  final Value<int> id;
  final Value<int> stationId;
  final Value<int> providerId;
  final Value<DateTime> forecastTime;
  final Value<DateTime> issuedAt;
  final Value<DateTime> fetchedAt;
  final Value<double?> temperature;
  final Value<double?> temperatureMin;
  final Value<double?> temperatureMax;
  final Value<double?> feelsLike;
  final Value<double?> windSpeed;
  final Value<double?> windGust;
  final Value<double?> windDirection;
  final Value<double?> pressure;
  final Value<double?> humidity;
  final Value<double?> dewPoint;
  final Value<double?> precipitation;
  final Value<double?> precipitationProbability;
  final Value<double?> cloudCover;
  final Value<double?> uvIndex;
  final Value<String?> weatherIcon;
  final Value<String?> weatherDescription;
  const WeatherForecastsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.forecastTime = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.temperature = const Value.absent(),
    this.temperatureMin = const Value.absent(),
    this.temperatureMax = const Value.absent(),
    this.feelsLike = const Value.absent(),
    this.windSpeed = const Value.absent(),
    this.windGust = const Value.absent(),
    this.windDirection = const Value.absent(),
    this.pressure = const Value.absent(),
    this.humidity = const Value.absent(),
    this.dewPoint = const Value.absent(),
    this.precipitation = const Value.absent(),
    this.precipitationProbability = const Value.absent(),
    this.cloudCover = const Value.absent(),
    this.uvIndex = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.weatherDescription = const Value.absent(),
  });
  WeatherForecastsCompanion.insert({
    this.id = const Value.absent(),
    required int stationId,
    required int providerId,
    required DateTime forecastTime,
    required DateTime issuedAt,
    required DateTime fetchedAt,
    this.temperature = const Value.absent(),
    this.temperatureMin = const Value.absent(),
    this.temperatureMax = const Value.absent(),
    this.feelsLike = const Value.absent(),
    this.windSpeed = const Value.absent(),
    this.windGust = const Value.absent(),
    this.windDirection = const Value.absent(),
    this.pressure = const Value.absent(),
    this.humidity = const Value.absent(),
    this.dewPoint = const Value.absent(),
    this.precipitation = const Value.absent(),
    this.precipitationProbability = const Value.absent(),
    this.cloudCover = const Value.absent(),
    this.uvIndex = const Value.absent(),
    this.weatherIcon = const Value.absent(),
    this.weatherDescription = const Value.absent(),
  }) : stationId = Value(stationId),
       providerId = Value(providerId),
       forecastTime = Value(forecastTime),
       issuedAt = Value(issuedAt),
       fetchedAt = Value(fetchedAt);
  static Insertable<WeatherForecast> custom({
    Expression<int>? id,
    Expression<int>? stationId,
    Expression<int>? providerId,
    Expression<DateTime>? forecastTime,
    Expression<DateTime>? issuedAt,
    Expression<DateTime>? fetchedAt,
    Expression<double>? temperature,
    Expression<double>? temperatureMin,
    Expression<double>? temperatureMax,
    Expression<double>? feelsLike,
    Expression<double>? windSpeed,
    Expression<double>? windGust,
    Expression<double>? windDirection,
    Expression<double>? pressure,
    Expression<double>? humidity,
    Expression<double>? dewPoint,
    Expression<double>? precipitation,
    Expression<double>? precipitationProbability,
    Expression<double>? cloudCover,
    Expression<double>? uvIndex,
    Expression<String>? weatherIcon,
    Expression<String>? weatherDescription,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (providerId != null) 'provider_id': providerId,
      if (forecastTime != null) 'forecast_time': forecastTime,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (temperature != null) 'temperature': temperature,
      if (temperatureMin != null) 'temperature_min': temperatureMin,
      if (temperatureMax != null) 'temperature_max': temperatureMax,
      if (feelsLike != null) 'feels_like': feelsLike,
      if (windSpeed != null) 'wind_speed': windSpeed,
      if (windGust != null) 'wind_gust': windGust,
      if (windDirection != null) 'wind_direction': windDirection,
      if (pressure != null) 'pressure': pressure,
      if (humidity != null) 'humidity': humidity,
      if (dewPoint != null) 'dew_point': dewPoint,
      if (precipitation != null) 'precipitation': precipitation,
      if (precipitationProbability != null)
        'precipitation_probability': precipitationProbability,
      if (cloudCover != null) 'cloud_cover': cloudCover,
      if (uvIndex != null) 'uv_index': uvIndex,
      if (weatherIcon != null) 'weather_icon': weatherIcon,
      if (weatherDescription != null) 'weather_description': weatherDescription,
    });
  }

  WeatherForecastsCompanion copyWith({
    Value<int>? id,
    Value<int>? stationId,
    Value<int>? providerId,
    Value<DateTime>? forecastTime,
    Value<DateTime>? issuedAt,
    Value<DateTime>? fetchedAt,
    Value<double?>? temperature,
    Value<double?>? temperatureMin,
    Value<double?>? temperatureMax,
    Value<double?>? feelsLike,
    Value<double?>? windSpeed,
    Value<double?>? windGust,
    Value<double?>? windDirection,
    Value<double?>? pressure,
    Value<double?>? humidity,
    Value<double?>? dewPoint,
    Value<double?>? precipitation,
    Value<double?>? precipitationProbability,
    Value<double?>? cloudCover,
    Value<double?>? uvIndex,
    Value<String?>? weatherIcon,
    Value<String?>? weatherDescription,
  }) {
    return WeatherForecastsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      providerId: providerId ?? this.providerId,
      forecastTime: forecastTime ?? this.forecastTime,
      issuedAt: issuedAt ?? this.issuedAt,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      temperature: temperature ?? this.temperature,
      temperatureMin: temperatureMin ?? this.temperatureMin,
      temperatureMax: temperatureMax ?? this.temperatureMax,
      feelsLike: feelsLike ?? this.feelsLike,
      windSpeed: windSpeed ?? this.windSpeed,
      windGust: windGust ?? this.windGust,
      windDirection: windDirection ?? this.windDirection,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      dewPoint: dewPoint ?? this.dewPoint,
      precipitation: precipitation ?? this.precipitation,
      precipitationProbability:
          precipitationProbability ?? this.precipitationProbability,
      cloudCover: cloudCover ?? this.cloudCover,
      uvIndex: uvIndex ?? this.uvIndex,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      weatherDescription: weatherDescription ?? this.weatherDescription,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (forecastTime.present) {
      map['forecast_time'] = Variable<DateTime>(forecastTime.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (temperatureMin.present) {
      map['temperature_min'] = Variable<double>(temperatureMin.value);
    }
    if (temperatureMax.present) {
      map['temperature_max'] = Variable<double>(temperatureMax.value);
    }
    if (feelsLike.present) {
      map['feels_like'] = Variable<double>(feelsLike.value);
    }
    if (windSpeed.present) {
      map['wind_speed'] = Variable<double>(windSpeed.value);
    }
    if (windGust.present) {
      map['wind_gust'] = Variable<double>(windGust.value);
    }
    if (windDirection.present) {
      map['wind_direction'] = Variable<double>(windDirection.value);
    }
    if (pressure.present) {
      map['pressure'] = Variable<double>(pressure.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<double>(humidity.value);
    }
    if (dewPoint.present) {
      map['dew_point'] = Variable<double>(dewPoint.value);
    }
    if (precipitation.present) {
      map['precipitation'] = Variable<double>(precipitation.value);
    }
    if (precipitationProbability.present) {
      map['precipitation_probability'] = Variable<double>(
        precipitationProbability.value,
      );
    }
    if (cloudCover.present) {
      map['cloud_cover'] = Variable<double>(cloudCover.value);
    }
    if (uvIndex.present) {
      map['uv_index'] = Variable<double>(uvIndex.value);
    }
    if (weatherIcon.present) {
      map['weather_icon'] = Variable<String>(weatherIcon.value);
    }
    if (weatherDescription.present) {
      map['weather_description'] = Variable<String>(weatherDescription.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherForecastsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('forecastTime: $forecastTime, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('temperature: $temperature, ')
          ..write('temperatureMin: $temperatureMin, ')
          ..write('temperatureMax: $temperatureMax, ')
          ..write('feelsLike: $feelsLike, ')
          ..write('windSpeed: $windSpeed, ')
          ..write('windGust: $windGust, ')
          ..write('windDirection: $windDirection, ')
          ..write('pressure: $pressure, ')
          ..write('humidity: $humidity, ')
          ..write('dewPoint: $dewPoint, ')
          ..write('precipitation: $precipitation, ')
          ..write('precipitationProbability: $precipitationProbability, ')
          ..write('cloudCover: $cloudCover, ')
          ..write('uvIndex: $uvIndex, ')
          ..write('weatherIcon: $weatherIcon, ')
          ..write('weatherDescription: $weatherDescription')
          ..write(')'))
        .toString();
  }
}

class $WaveObservationsTable extends WaveObservations
    with TableInfo<$WaveObservationsTable, WaveObservation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaveObservationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stationIdMeta = const VerificationMeta(
    'stationId',
  );
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
    'station_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_stations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waveHeightMeta = const VerificationMeta(
    'waveHeight',
  );
  @override
  late final GeneratedColumn<double> waveHeight = GeneratedColumn<double>(
    'wave_height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wavePeriodMeta = const VerificationMeta(
    'wavePeriod',
  );
  @override
  late final GeneratedColumn<double> wavePeriod = GeneratedColumn<double>(
    'wave_period',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waveDirectionMeta = const VerificationMeta(
    'waveDirection',
  );
  @override
  late final GeneratedColumn<double> waveDirection = GeneratedColumn<double>(
    'wave_direction',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterTemperatureMeta = const VerificationMeta(
    'waterTemperature',
  );
  @override
  late final GeneratedColumn<double> waterTemperature = GeneratedColumn<double>(
    'water_temperature',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stationId,
    providerId,
    timestamp,
    fetchedAt,
    waveHeight,
    wavePeriod,
    waveDirection,
    waterTemperature,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wave_observations';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaveObservation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('station_id')) {
      context.handle(
        _stationIdMeta,
        stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('wave_height')) {
      context.handle(
        _waveHeightMeta,
        waveHeight.isAcceptableOrUnknown(data['wave_height']!, _waveHeightMeta),
      );
    }
    if (data.containsKey('wave_period')) {
      context.handle(
        _wavePeriodMeta,
        wavePeriod.isAcceptableOrUnknown(data['wave_period']!, _wavePeriodMeta),
      );
    }
    if (data.containsKey('wave_direction')) {
      context.handle(
        _waveDirectionMeta,
        waveDirection.isAcceptableOrUnknown(
          data['wave_direction']!,
          _waveDirectionMeta,
        ),
      );
    }
    if (data.containsKey('water_temperature')) {
      context.handle(
        _waterTemperatureMeta,
        waterTemperature.isAcceptableOrUnknown(
          data['water_temperature']!,
          _waterTemperatureMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {stationId, timestamp, providerId},
  ];
  @override
  WaveObservation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaveObservation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}station_id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      waveHeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wave_height'],
      ),
      wavePeriod: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wave_period'],
      ),
      waveDirection: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wave_direction'],
      ),
      waterTemperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_temperature'],
      ),
    );
  }

  @override
  $WaveObservationsTable createAlias(String alias) {
    return $WaveObservationsTable(attachedDatabase, alias);
  }
}

class WaveObservation extends DataClass implements Insertable<WaveObservation> {
  final int id;
  final int stationId;
  final int providerId;
  final DateTime timestamp;
  final DateTime fetchedAt;
  final double? waveHeight;
  final double? wavePeriod;
  final double? waveDirection;
  final double? waterTemperature;
  const WaveObservation({
    required this.id,
    required this.stationId,
    required this.providerId,
    required this.timestamp,
    required this.fetchedAt,
    this.waveHeight,
    this.wavePeriod,
    this.waveDirection,
    this.waterTemperature,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_id'] = Variable<int>(stationId);
    map['provider_id'] = Variable<int>(providerId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    if (!nullToAbsent || waveHeight != null) {
      map['wave_height'] = Variable<double>(waveHeight);
    }
    if (!nullToAbsent || wavePeriod != null) {
      map['wave_period'] = Variable<double>(wavePeriod);
    }
    if (!nullToAbsent || waveDirection != null) {
      map['wave_direction'] = Variable<double>(waveDirection);
    }
    if (!nullToAbsent || waterTemperature != null) {
      map['water_temperature'] = Variable<double>(waterTemperature);
    }
    return map;
  }

  WaveObservationsCompanion toCompanion(bool nullToAbsent) {
    return WaveObservationsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      providerId: Value(providerId),
      timestamp: Value(timestamp),
      fetchedAt: Value(fetchedAt),
      waveHeight: waveHeight == null && nullToAbsent
          ? const Value.absent()
          : Value(waveHeight),
      wavePeriod: wavePeriod == null && nullToAbsent
          ? const Value.absent()
          : Value(wavePeriod),
      waveDirection: waveDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(waveDirection),
      waterTemperature: waterTemperature == null && nullToAbsent
          ? const Value.absent()
          : Value(waterTemperature),
    );
  }

  factory WaveObservation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaveObservation(
      id: serializer.fromJson<int>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      providerId: serializer.fromJson<int>(json['providerId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      waveHeight: serializer.fromJson<double?>(json['waveHeight']),
      wavePeriod: serializer.fromJson<double?>(json['wavePeriod']),
      waveDirection: serializer.fromJson<double?>(json['waveDirection']),
      waterTemperature: serializer.fromJson<double?>(json['waterTemperature']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationId': serializer.toJson<int>(stationId),
      'providerId': serializer.toJson<int>(providerId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'waveHeight': serializer.toJson<double?>(waveHeight),
      'wavePeriod': serializer.toJson<double?>(wavePeriod),
      'waveDirection': serializer.toJson<double?>(waveDirection),
      'waterTemperature': serializer.toJson<double?>(waterTemperature),
    };
  }

  WaveObservation copyWith({
    int? id,
    int? stationId,
    int? providerId,
    DateTime? timestamp,
    DateTime? fetchedAt,
    Value<double?> waveHeight = const Value.absent(),
    Value<double?> wavePeriod = const Value.absent(),
    Value<double?> waveDirection = const Value.absent(),
    Value<double?> waterTemperature = const Value.absent(),
  }) => WaveObservation(
    id: id ?? this.id,
    stationId: stationId ?? this.stationId,
    providerId: providerId ?? this.providerId,
    timestamp: timestamp ?? this.timestamp,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    waveHeight: waveHeight.present ? waveHeight.value : this.waveHeight,
    wavePeriod: wavePeriod.present ? wavePeriod.value : this.wavePeriod,
    waveDirection: waveDirection.present
        ? waveDirection.value
        : this.waveDirection,
    waterTemperature: waterTemperature.present
        ? waterTemperature.value
        : this.waterTemperature,
  );
  WaveObservation copyWithCompanion(WaveObservationsCompanion data) {
    return WaveObservation(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      waveHeight: data.waveHeight.present
          ? data.waveHeight.value
          : this.waveHeight,
      wavePeriod: data.wavePeriod.present
          ? data.wavePeriod.value
          : this.wavePeriod,
      waveDirection: data.waveDirection.present
          ? data.waveDirection.value
          : this.waveDirection,
      waterTemperature: data.waterTemperature.present
          ? data.waterTemperature.value
          : this.waterTemperature,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaveObservation(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('timestamp: $timestamp, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('waveHeight: $waveHeight, ')
          ..write('wavePeriod: $wavePeriod, ')
          ..write('waveDirection: $waveDirection, ')
          ..write('waterTemperature: $waterTemperature')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    stationId,
    providerId,
    timestamp,
    fetchedAt,
    waveHeight,
    wavePeriod,
    waveDirection,
    waterTemperature,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaveObservation &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.providerId == this.providerId &&
          other.timestamp == this.timestamp &&
          other.fetchedAt == this.fetchedAt &&
          other.waveHeight == this.waveHeight &&
          other.wavePeriod == this.wavePeriod &&
          other.waveDirection == this.waveDirection &&
          other.waterTemperature == this.waterTemperature);
}

class WaveObservationsCompanion extends UpdateCompanion<WaveObservation> {
  final Value<int> id;
  final Value<int> stationId;
  final Value<int> providerId;
  final Value<DateTime> timestamp;
  final Value<DateTime> fetchedAt;
  final Value<double?> waveHeight;
  final Value<double?> wavePeriod;
  final Value<double?> waveDirection;
  final Value<double?> waterTemperature;
  const WaveObservationsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.waveHeight = const Value.absent(),
    this.wavePeriod = const Value.absent(),
    this.waveDirection = const Value.absent(),
    this.waterTemperature = const Value.absent(),
  });
  WaveObservationsCompanion.insert({
    this.id = const Value.absent(),
    required int stationId,
    required int providerId,
    required DateTime timestamp,
    required DateTime fetchedAt,
    this.waveHeight = const Value.absent(),
    this.wavePeriod = const Value.absent(),
    this.waveDirection = const Value.absent(),
    this.waterTemperature = const Value.absent(),
  }) : stationId = Value(stationId),
       providerId = Value(providerId),
       timestamp = Value(timestamp),
       fetchedAt = Value(fetchedAt);
  static Insertable<WaveObservation> custom({
    Expression<int>? id,
    Expression<int>? stationId,
    Expression<int>? providerId,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? fetchedAt,
    Expression<double>? waveHeight,
    Expression<double>? wavePeriod,
    Expression<double>? waveDirection,
    Expression<double>? waterTemperature,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (providerId != null) 'provider_id': providerId,
      if (timestamp != null) 'timestamp': timestamp,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (waveHeight != null) 'wave_height': waveHeight,
      if (wavePeriod != null) 'wave_period': wavePeriod,
      if (waveDirection != null) 'wave_direction': waveDirection,
      if (waterTemperature != null) 'water_temperature': waterTemperature,
    });
  }

  WaveObservationsCompanion copyWith({
    Value<int>? id,
    Value<int>? stationId,
    Value<int>? providerId,
    Value<DateTime>? timestamp,
    Value<DateTime>? fetchedAt,
    Value<double?>? waveHeight,
    Value<double?>? wavePeriod,
    Value<double?>? waveDirection,
    Value<double?>? waterTemperature,
  }) {
    return WaveObservationsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      providerId: providerId ?? this.providerId,
      timestamp: timestamp ?? this.timestamp,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      waveHeight: waveHeight ?? this.waveHeight,
      wavePeriod: wavePeriod ?? this.wavePeriod,
      waveDirection: waveDirection ?? this.waveDirection,
      waterTemperature: waterTemperature ?? this.waterTemperature,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (waveHeight.present) {
      map['wave_height'] = Variable<double>(waveHeight.value);
    }
    if (wavePeriod.present) {
      map['wave_period'] = Variable<double>(wavePeriod.value);
    }
    if (waveDirection.present) {
      map['wave_direction'] = Variable<double>(waveDirection.value);
    }
    if (waterTemperature.present) {
      map['water_temperature'] = Variable<double>(waterTemperature.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaveObservationsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('timestamp: $timestamp, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('waveHeight: $waveHeight, ')
          ..write('wavePeriod: $wavePeriod, ')
          ..write('waveDirection: $waveDirection, ')
          ..write('waterTemperature: $waterTemperature')
          ..write(')'))
        .toString();
  }
}

class $SeaLevelReadingsTable extends SeaLevelReadings
    with TableInfo<$SeaLevelReadingsTable, SeaLevelReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeaLevelReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stationIdMeta = const VerificationMeta(
    'stationId',
  );
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
    'station_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_stations (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seaLevelMmMeta = const VerificationMeta(
    'seaLevelMm',
  );
  @override
  late final GeneratedColumn<double> seaLevelMm = GeneratedColumn<double>(
    'sea_level_mm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stationId,
    providerId,
    timestamp,
    fetchedAt,
    seaLevelMm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sea_level_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SeaLevelReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('station_id')) {
      context.handle(
        _stationIdMeta,
        stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('sea_level_mm')) {
      context.handle(
        _seaLevelMmMeta,
        seaLevelMm.isAcceptableOrUnknown(
          data['sea_level_mm']!,
          _seaLevelMmMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {stationId, timestamp, providerId},
  ];
  @override
  SeaLevelReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeaLevelReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}station_id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      seaLevelMm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sea_level_mm'],
      ),
    );
  }

  @override
  $SeaLevelReadingsTable createAlias(String alias) {
    return $SeaLevelReadingsTable(attachedDatabase, alias);
  }
}

class SeaLevelReading extends DataClass implements Insertable<SeaLevelReading> {
  final int id;
  final int stationId;
  final int providerId;
  final DateTime timestamp;
  final DateTime fetchedAt;
  final double? seaLevelMm;
  const SeaLevelReading({
    required this.id,
    required this.stationId,
    required this.providerId,
    required this.timestamp,
    required this.fetchedAt,
    this.seaLevelMm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_id'] = Variable<int>(stationId);
    map['provider_id'] = Variable<int>(providerId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    if (!nullToAbsent || seaLevelMm != null) {
      map['sea_level_mm'] = Variable<double>(seaLevelMm);
    }
    return map;
  }

  SeaLevelReadingsCompanion toCompanion(bool nullToAbsent) {
    return SeaLevelReadingsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      providerId: Value(providerId),
      timestamp: Value(timestamp),
      fetchedAt: Value(fetchedAt),
      seaLevelMm: seaLevelMm == null && nullToAbsent
          ? const Value.absent()
          : Value(seaLevelMm),
    );
  }

  factory SeaLevelReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeaLevelReading(
      id: serializer.fromJson<int>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      providerId: serializer.fromJson<int>(json['providerId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      seaLevelMm: serializer.fromJson<double?>(json['seaLevelMm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationId': serializer.toJson<int>(stationId),
      'providerId': serializer.toJson<int>(providerId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'seaLevelMm': serializer.toJson<double?>(seaLevelMm),
    };
  }

  SeaLevelReading copyWith({
    int? id,
    int? stationId,
    int? providerId,
    DateTime? timestamp,
    DateTime? fetchedAt,
    Value<double?> seaLevelMm = const Value.absent(),
  }) => SeaLevelReading(
    id: id ?? this.id,
    stationId: stationId ?? this.stationId,
    providerId: providerId ?? this.providerId,
    timestamp: timestamp ?? this.timestamp,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    seaLevelMm: seaLevelMm.present ? seaLevelMm.value : this.seaLevelMm,
  );
  SeaLevelReading copyWithCompanion(SeaLevelReadingsCompanion data) {
    return SeaLevelReading(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      seaLevelMm: data.seaLevelMm.present
          ? data.seaLevelMm.value
          : this.seaLevelMm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeaLevelReading(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('timestamp: $timestamp, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('seaLevelMm: $seaLevelMm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, stationId, providerId, timestamp, fetchedAt, seaLevelMm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeaLevelReading &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.providerId == this.providerId &&
          other.timestamp == this.timestamp &&
          other.fetchedAt == this.fetchedAt &&
          other.seaLevelMm == this.seaLevelMm);
}

class SeaLevelReadingsCompanion extends UpdateCompanion<SeaLevelReading> {
  final Value<int> id;
  final Value<int> stationId;
  final Value<int> providerId;
  final Value<DateTime> timestamp;
  final Value<DateTime> fetchedAt;
  final Value<double?> seaLevelMm;
  const SeaLevelReadingsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.seaLevelMm = const Value.absent(),
  });
  SeaLevelReadingsCompanion.insert({
    this.id = const Value.absent(),
    required int stationId,
    required int providerId,
    required DateTime timestamp,
    required DateTime fetchedAt,
    this.seaLevelMm = const Value.absent(),
  }) : stationId = Value(stationId),
       providerId = Value(providerId),
       timestamp = Value(timestamp),
       fetchedAt = Value(fetchedAt);
  static Insertable<SeaLevelReading> custom({
    Expression<int>? id,
    Expression<int>? stationId,
    Expression<int>? providerId,
    Expression<DateTime>? timestamp,
    Expression<DateTime>? fetchedAt,
    Expression<double>? seaLevelMm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (providerId != null) 'provider_id': providerId,
      if (timestamp != null) 'timestamp': timestamp,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (seaLevelMm != null) 'sea_level_mm': seaLevelMm,
    });
  }

  SeaLevelReadingsCompanion copyWith({
    Value<int>? id,
    Value<int>? stationId,
    Value<int>? providerId,
    Value<DateTime>? timestamp,
    Value<DateTime>? fetchedAt,
    Value<double?>? seaLevelMm,
  }) {
    return SeaLevelReadingsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      providerId: providerId ?? this.providerId,
      timestamp: timestamp ?? this.timestamp,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      seaLevelMm: seaLevelMm ?? this.seaLevelMm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (seaLevelMm.present) {
      map['sea_level_mm'] = Variable<double>(seaLevelMm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeaLevelReadingsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('timestamp: $timestamp, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('seaLevelMm: $seaLevelMm')
          ..write(')'))
        .toString();
  }
}

class $WeatherAlertsTable extends WeatherAlerts
    with TableInfo<$WeatherAlertsTable, WeatherAlert> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherAlertsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _externalIdMeta = const VerificationMeta(
    'externalId',
  );
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
    'external_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<String> event = GeneratedColumn<String>(
    'event',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL CHECK (severity IN (\'minor\', \'moderate\', \'severe\', \'extreme\'))',
  );
  static const VerificationMeta _onsetMeta = const VerificationMeta('onset');
  @override
  late final GeneratedColumn<DateTime> onset = GeneratedColumn<DateTime>(
    'onset',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresMeta = const VerificationMeta(
    'expires',
  );
  @override
  late final GeneratedColumn<DateTime> expires = GeneratedColumn<DateTime>(
    'expires',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _polygonJsonMeta = const VerificationMeta(
    'polygonJson',
  );
  @override
  late final GeneratedColumn<String> polygonJson = GeneratedColumn<String>(
    'polygon_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaDescriptionMeta = const VerificationMeta(
    'areaDescription',
  );
  @override
  late final GeneratedColumn<String> areaDescription = GeneratedColumn<String>(
    'area_description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    externalId,
    providerId,
    event,
    description,
    severity,
    onset,
    expires,
    fetchedAt,
    polygonJson,
    areaDescription,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_alerts';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherAlert> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('external_id')) {
      context.handle(
        _externalIdMeta,
        externalId.isAcceptableOrUnknown(data['external_id']!, _externalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_externalIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('event')) {
      context.handle(
        _eventMeta,
        event.isAcceptableOrUnknown(data['event']!, _eventMeta),
      );
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('onset')) {
      context.handle(
        _onsetMeta,
        onset.isAcceptableOrUnknown(data['onset']!, _onsetMeta),
      );
    } else if (isInserting) {
      context.missing(_onsetMeta);
    }
    if (data.containsKey('expires')) {
      context.handle(
        _expiresMeta,
        expires.isAcceptableOrUnknown(data['expires']!, _expiresMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('polygon_json')) {
      context.handle(
        _polygonJsonMeta,
        polygonJson.isAcceptableOrUnknown(
          data['polygon_json']!,
          _polygonJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_polygonJsonMeta);
    }
    if (data.containsKey('area_description')) {
      context.handle(
        _areaDescriptionMeta,
        areaDescription.isAcceptableOrUnknown(
          data['area_description']!,
          _areaDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_areaDescriptionMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeatherAlert map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherAlert(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      externalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      event: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
      onset: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}onset'],
      )!,
      expires: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      polygonJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}polygon_json'],
      )!,
      areaDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area_description'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      ),
    );
  }

  @override
  $WeatherAlertsTable createAlias(String alias) {
    return $WeatherAlertsTable(attachedDatabase, alias);
  }
}

class WeatherAlert extends DataClass implements Insertable<WeatherAlert> {
  final int id;
  final String externalId;
  final int providerId;
  final String event;
  final String description;
  final String severity;
  final DateTime onset;
  final DateTime expires;
  final DateTime fetchedAt;
  final String polygonJson;
  final String areaDescription;
  final String? source;
  const WeatherAlert({
    required this.id,
    required this.externalId,
    required this.providerId,
    required this.event,
    required this.description,
    required this.severity,
    required this.onset,
    required this.expires,
    required this.fetchedAt,
    required this.polygonJson,
    required this.areaDescription,
    this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['external_id'] = Variable<String>(externalId);
    map['provider_id'] = Variable<int>(providerId);
    map['event'] = Variable<String>(event);
    map['description'] = Variable<String>(description);
    map['severity'] = Variable<String>(severity);
    map['onset'] = Variable<DateTime>(onset);
    map['expires'] = Variable<DateTime>(expires);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['polygon_json'] = Variable<String>(polygonJson);
    map['area_description'] = Variable<String>(areaDescription);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    return map;
  }

  WeatherAlertsCompanion toCompanion(bool nullToAbsent) {
    return WeatherAlertsCompanion(
      id: Value(id),
      externalId: Value(externalId),
      providerId: Value(providerId),
      event: Value(event),
      description: Value(description),
      severity: Value(severity),
      onset: Value(onset),
      expires: Value(expires),
      fetchedAt: Value(fetchedAt),
      polygonJson: Value(polygonJson),
      areaDescription: Value(areaDescription),
      source: source == null && nullToAbsent
          ? const Value.absent()
          : Value(source),
    );
  }

  factory WeatherAlert.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherAlert(
      id: serializer.fromJson<int>(json['id']),
      externalId: serializer.fromJson<String>(json['externalId']),
      providerId: serializer.fromJson<int>(json['providerId']),
      event: serializer.fromJson<String>(json['event']),
      description: serializer.fromJson<String>(json['description']),
      severity: serializer.fromJson<String>(json['severity']),
      onset: serializer.fromJson<DateTime>(json['onset']),
      expires: serializer.fromJson<DateTime>(json['expires']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      polygonJson: serializer.fromJson<String>(json['polygonJson']),
      areaDescription: serializer.fromJson<String>(json['areaDescription']),
      source: serializer.fromJson<String?>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'externalId': serializer.toJson<String>(externalId),
      'providerId': serializer.toJson<int>(providerId),
      'event': serializer.toJson<String>(event),
      'description': serializer.toJson<String>(description),
      'severity': serializer.toJson<String>(severity),
      'onset': serializer.toJson<DateTime>(onset),
      'expires': serializer.toJson<DateTime>(expires),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'polygonJson': serializer.toJson<String>(polygonJson),
      'areaDescription': serializer.toJson<String>(areaDescription),
      'source': serializer.toJson<String?>(source),
    };
  }

  WeatherAlert copyWith({
    int? id,
    String? externalId,
    int? providerId,
    String? event,
    String? description,
    String? severity,
    DateTime? onset,
    DateTime? expires,
    DateTime? fetchedAt,
    String? polygonJson,
    String? areaDescription,
    Value<String?> source = const Value.absent(),
  }) => WeatherAlert(
    id: id ?? this.id,
    externalId: externalId ?? this.externalId,
    providerId: providerId ?? this.providerId,
    event: event ?? this.event,
    description: description ?? this.description,
    severity: severity ?? this.severity,
    onset: onset ?? this.onset,
    expires: expires ?? this.expires,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    polygonJson: polygonJson ?? this.polygonJson,
    areaDescription: areaDescription ?? this.areaDescription,
    source: source.present ? source.value : this.source,
  );
  WeatherAlert copyWithCompanion(WeatherAlertsCompanion data) {
    return WeatherAlert(
      id: data.id.present ? data.id.value : this.id,
      externalId: data.externalId.present
          ? data.externalId.value
          : this.externalId,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      event: data.event.present ? data.event.value : this.event,
      description: data.description.present
          ? data.description.value
          : this.description,
      severity: data.severity.present ? data.severity.value : this.severity,
      onset: data.onset.present ? data.onset.value : this.onset,
      expires: data.expires.present ? data.expires.value : this.expires,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      polygonJson: data.polygonJson.present
          ? data.polygonJson.value
          : this.polygonJson,
      areaDescription: data.areaDescription.present
          ? data.areaDescription.value
          : this.areaDescription,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherAlert(')
          ..write('id: $id, ')
          ..write('externalId: $externalId, ')
          ..write('providerId: $providerId, ')
          ..write('event: $event, ')
          ..write('description: $description, ')
          ..write('severity: $severity, ')
          ..write('onset: $onset, ')
          ..write('expires: $expires, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('polygonJson: $polygonJson, ')
          ..write('areaDescription: $areaDescription, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    externalId,
    providerId,
    event,
    description,
    severity,
    onset,
    expires,
    fetchedAt,
    polygonJson,
    areaDescription,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherAlert &&
          other.id == this.id &&
          other.externalId == this.externalId &&
          other.providerId == this.providerId &&
          other.event == this.event &&
          other.description == this.description &&
          other.severity == this.severity &&
          other.onset == this.onset &&
          other.expires == this.expires &&
          other.fetchedAt == this.fetchedAt &&
          other.polygonJson == this.polygonJson &&
          other.areaDescription == this.areaDescription &&
          other.source == this.source);
}

class WeatherAlertsCompanion extends UpdateCompanion<WeatherAlert> {
  final Value<int> id;
  final Value<String> externalId;
  final Value<int> providerId;
  final Value<String> event;
  final Value<String> description;
  final Value<String> severity;
  final Value<DateTime> onset;
  final Value<DateTime> expires;
  final Value<DateTime> fetchedAt;
  final Value<String> polygonJson;
  final Value<String> areaDescription;
  final Value<String?> source;
  const WeatherAlertsCompanion({
    this.id = const Value.absent(),
    this.externalId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.event = const Value.absent(),
    this.description = const Value.absent(),
    this.severity = const Value.absent(),
    this.onset = const Value.absent(),
    this.expires = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.polygonJson = const Value.absent(),
    this.areaDescription = const Value.absent(),
    this.source = const Value.absent(),
  });
  WeatherAlertsCompanion.insert({
    this.id = const Value.absent(),
    required String externalId,
    required int providerId,
    required String event,
    required String description,
    required String severity,
    required DateTime onset,
    required DateTime expires,
    required DateTime fetchedAt,
    required String polygonJson,
    required String areaDescription,
    this.source = const Value.absent(),
  }) : externalId = Value(externalId),
       providerId = Value(providerId),
       event = Value(event),
       description = Value(description),
       severity = Value(severity),
       onset = Value(onset),
       expires = Value(expires),
       fetchedAt = Value(fetchedAt),
       polygonJson = Value(polygonJson),
       areaDescription = Value(areaDescription);
  static Insertable<WeatherAlert> custom({
    Expression<int>? id,
    Expression<String>? externalId,
    Expression<int>? providerId,
    Expression<String>? event,
    Expression<String>? description,
    Expression<String>? severity,
    Expression<DateTime>? onset,
    Expression<DateTime>? expires,
    Expression<DateTime>? fetchedAt,
    Expression<String>? polygonJson,
    Expression<String>? areaDescription,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (externalId != null) 'external_id': externalId,
      if (providerId != null) 'provider_id': providerId,
      if (event != null) 'event': event,
      if (description != null) 'description': description,
      if (severity != null) 'severity': severity,
      if (onset != null) 'onset': onset,
      if (expires != null) 'expires': expires,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (polygonJson != null) 'polygon_json': polygonJson,
      if (areaDescription != null) 'area_description': areaDescription,
      if (source != null) 'source': source,
    });
  }

  WeatherAlertsCompanion copyWith({
    Value<int>? id,
    Value<String>? externalId,
    Value<int>? providerId,
    Value<String>? event,
    Value<String>? description,
    Value<String>? severity,
    Value<DateTime>? onset,
    Value<DateTime>? expires,
    Value<DateTime>? fetchedAt,
    Value<String>? polygonJson,
    Value<String>? areaDescription,
    Value<String?>? source,
  }) {
    return WeatherAlertsCompanion(
      id: id ?? this.id,
      externalId: externalId ?? this.externalId,
      providerId: providerId ?? this.providerId,
      event: event ?? this.event,
      description: description ?? this.description,
      severity: severity ?? this.severity,
      onset: onset ?? this.onset,
      expires: expires ?? this.expires,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      polygonJson: polygonJson ?? this.polygonJson,
      areaDescription: areaDescription ?? this.areaDescription,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (event.present) {
      map['event'] = Variable<String>(event.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (onset.present) {
      map['onset'] = Variable<DateTime>(onset.value);
    }
    if (expires.present) {
      map['expires'] = Variable<DateTime>(expires.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (polygonJson.present) {
      map['polygon_json'] = Variable<String>(polygonJson.value);
    }
    if (areaDescription.present) {
      map['area_description'] = Variable<String>(areaDescription.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherAlertsCompanion(')
          ..write('id: $id, ')
          ..write('externalId: $externalId, ')
          ..write('providerId: $providerId, ')
          ..write('event: $event, ')
          ..write('description: $description, ')
          ..write('severity: $severity, ')
          ..write('onset: $onset, ')
          ..write('expires: $expires, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('polygonJson: $polygonJson, ')
          ..write('areaDescription: $areaDescription, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

class $LightningStrikesTable extends LightningStrikes
    with TableInfo<$LightningStrikesTable, LightningStrike> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LightningStrikesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _strikeTimeMeta = const VerificationMeta(
    'strikeTime',
  );
  @override
  late final GeneratedColumn<DateTime> strikeTime = GeneratedColumn<DateTime>(
    'strike_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _peakCurrentKaMeta = const VerificationMeta(
    'peakCurrentKa',
  );
  @override
  late final GeneratedColumn<double> peakCurrentKa = GeneratedColumn<double>(
    'peak_current_ka',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _multiplicityMeta = const VerificationMeta(
    'multiplicity',
  );
  @override
  late final GeneratedColumn<int> multiplicity = GeneratedColumn<int>(
    'multiplicity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cloudToGroundMeta = const VerificationMeta(
    'cloudToGround',
  );
  @override
  late final GeneratedColumn<bool> cloudToGround = GeneratedColumn<bool>(
    'cloud_to_ground',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cloud_to_ground" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    providerId,
    strikeTime,
    fetchedAt,
    latitude,
    longitude,
    peakCurrentKa,
    multiplicity,
    cloudToGround,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lightning_strikes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LightningStrike> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('strike_time')) {
      context.handle(
        _strikeTimeMeta,
        strikeTime.isAcceptableOrUnknown(data['strike_time']!, _strikeTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_strikeTimeMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('peak_current_ka')) {
      context.handle(
        _peakCurrentKaMeta,
        peakCurrentKa.isAcceptableOrUnknown(
          data['peak_current_ka']!,
          _peakCurrentKaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_peakCurrentKaMeta);
    }
    if (data.containsKey('multiplicity')) {
      context.handle(
        _multiplicityMeta,
        multiplicity.isAcceptableOrUnknown(
          data['multiplicity']!,
          _multiplicityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_multiplicityMeta);
    }
    if (data.containsKey('cloud_to_ground')) {
      context.handle(
        _cloudToGroundMeta,
        cloudToGround.isAcceptableOrUnknown(
          data['cloud_to_ground']!,
          _cloudToGroundMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {strikeTime, latitude, longitude, providerId},
  ];
  @override
  LightningStrike map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LightningStrike(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      strikeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}strike_time'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      peakCurrentKa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peak_current_ka'],
      )!,
      multiplicity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}multiplicity'],
      )!,
      cloudToGround: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cloud_to_ground'],
      ),
    );
  }

  @override
  $LightningStrikesTable createAlias(String alias) {
    return $LightningStrikesTable(attachedDatabase, alias);
  }
}

class LightningStrike extends DataClass implements Insertable<LightningStrike> {
  final int id;
  final int providerId;
  final DateTime strikeTime;
  final DateTime fetchedAt;
  final double latitude;
  final double longitude;
  final double peakCurrentKa;
  final int multiplicity;
  final bool? cloudToGround;
  const LightningStrike({
    required this.id,
    required this.providerId,
    required this.strikeTime,
    required this.fetchedAt,
    required this.latitude,
    required this.longitude,
    required this.peakCurrentKa,
    required this.multiplicity,
    this.cloudToGround,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['provider_id'] = Variable<int>(providerId);
    map['strike_time'] = Variable<DateTime>(strikeTime);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['peak_current_ka'] = Variable<double>(peakCurrentKa);
    map['multiplicity'] = Variable<int>(multiplicity);
    if (!nullToAbsent || cloudToGround != null) {
      map['cloud_to_ground'] = Variable<bool>(cloudToGround);
    }
    return map;
  }

  LightningStrikesCompanion toCompanion(bool nullToAbsent) {
    return LightningStrikesCompanion(
      id: Value(id),
      providerId: Value(providerId),
      strikeTime: Value(strikeTime),
      fetchedAt: Value(fetchedAt),
      latitude: Value(latitude),
      longitude: Value(longitude),
      peakCurrentKa: Value(peakCurrentKa),
      multiplicity: Value(multiplicity),
      cloudToGround: cloudToGround == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudToGround),
    );
  }

  factory LightningStrike.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LightningStrike(
      id: serializer.fromJson<int>(json['id']),
      providerId: serializer.fromJson<int>(json['providerId']),
      strikeTime: serializer.fromJson<DateTime>(json['strikeTime']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      peakCurrentKa: serializer.fromJson<double>(json['peakCurrentKa']),
      multiplicity: serializer.fromJson<int>(json['multiplicity']),
      cloudToGround: serializer.fromJson<bool?>(json['cloudToGround']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'providerId': serializer.toJson<int>(providerId),
      'strikeTime': serializer.toJson<DateTime>(strikeTime),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'peakCurrentKa': serializer.toJson<double>(peakCurrentKa),
      'multiplicity': serializer.toJson<int>(multiplicity),
      'cloudToGround': serializer.toJson<bool?>(cloudToGround),
    };
  }

  LightningStrike copyWith({
    int? id,
    int? providerId,
    DateTime? strikeTime,
    DateTime? fetchedAt,
    double? latitude,
    double? longitude,
    double? peakCurrentKa,
    int? multiplicity,
    Value<bool?> cloudToGround = const Value.absent(),
  }) => LightningStrike(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    strikeTime: strikeTime ?? this.strikeTime,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    peakCurrentKa: peakCurrentKa ?? this.peakCurrentKa,
    multiplicity: multiplicity ?? this.multiplicity,
    cloudToGround: cloudToGround.present
        ? cloudToGround.value
        : this.cloudToGround,
  );
  LightningStrike copyWithCompanion(LightningStrikesCompanion data) {
    return LightningStrike(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      strikeTime: data.strikeTime.present
          ? data.strikeTime.value
          : this.strikeTime,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      peakCurrentKa: data.peakCurrentKa.present
          ? data.peakCurrentKa.value
          : this.peakCurrentKa,
      multiplicity: data.multiplicity.present
          ? data.multiplicity.value
          : this.multiplicity,
      cloudToGround: data.cloudToGround.present
          ? data.cloudToGround.value
          : this.cloudToGround,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LightningStrike(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('strikeTime: $strikeTime, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('peakCurrentKa: $peakCurrentKa, ')
          ..write('multiplicity: $multiplicity, ')
          ..write('cloudToGround: $cloudToGround')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    providerId,
    strikeTime,
    fetchedAt,
    latitude,
    longitude,
    peakCurrentKa,
    multiplicity,
    cloudToGround,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LightningStrike &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.strikeTime == this.strikeTime &&
          other.fetchedAt == this.fetchedAt &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.peakCurrentKa == this.peakCurrentKa &&
          other.multiplicity == this.multiplicity &&
          other.cloudToGround == this.cloudToGround);
}

class LightningStrikesCompanion extends UpdateCompanion<LightningStrike> {
  final Value<int> id;
  final Value<int> providerId;
  final Value<DateTime> strikeTime;
  final Value<DateTime> fetchedAt;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> peakCurrentKa;
  final Value<int> multiplicity;
  final Value<bool?> cloudToGround;
  const LightningStrikesCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.strikeTime = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.peakCurrentKa = const Value.absent(),
    this.multiplicity = const Value.absent(),
    this.cloudToGround = const Value.absent(),
  });
  LightningStrikesCompanion.insert({
    this.id = const Value.absent(),
    required int providerId,
    required DateTime strikeTime,
    required DateTime fetchedAt,
    required double latitude,
    required double longitude,
    required double peakCurrentKa,
    required int multiplicity,
    this.cloudToGround = const Value.absent(),
  }) : providerId = Value(providerId),
       strikeTime = Value(strikeTime),
       fetchedAt = Value(fetchedAt),
       latitude = Value(latitude),
       longitude = Value(longitude),
       peakCurrentKa = Value(peakCurrentKa),
       multiplicity = Value(multiplicity);
  static Insertable<LightningStrike> custom({
    Expression<int>? id,
    Expression<int>? providerId,
    Expression<DateTime>? strikeTime,
    Expression<DateTime>? fetchedAt,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? peakCurrentKa,
    Expression<int>? multiplicity,
    Expression<bool>? cloudToGround,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (strikeTime != null) 'strike_time': strikeTime,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (peakCurrentKa != null) 'peak_current_ka': peakCurrentKa,
      if (multiplicity != null) 'multiplicity': multiplicity,
      if (cloudToGround != null) 'cloud_to_ground': cloudToGround,
    });
  }

  LightningStrikesCompanion copyWith({
    Value<int>? id,
    Value<int>? providerId,
    Value<DateTime>? strikeTime,
    Value<DateTime>? fetchedAt,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double>? peakCurrentKa,
    Value<int>? multiplicity,
    Value<bool?>? cloudToGround,
  }) {
    return LightningStrikesCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      strikeTime: strikeTime ?? this.strikeTime,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      peakCurrentKa: peakCurrentKa ?? this.peakCurrentKa,
      multiplicity: multiplicity ?? this.multiplicity,
      cloudToGround: cloudToGround ?? this.cloudToGround,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (strikeTime.present) {
      map['strike_time'] = Variable<DateTime>(strikeTime.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (peakCurrentKa.present) {
      map['peak_current_ka'] = Variable<double>(peakCurrentKa.value);
    }
    if (multiplicity.present) {
      map['multiplicity'] = Variable<int>(multiplicity.value);
    }
    if (cloudToGround.present) {
      map['cloud_to_ground'] = Variable<bool>(cloudToGround.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LightningStrikesCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('strikeTime: $strikeTime, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('peakCurrentKa: $peakCurrentKa, ')
          ..write('multiplicity: $multiplicity, ')
          ..write('cloudToGround: $cloudToGround')
          ..write(')'))
        .toString();
  }
}

class $WaterQualityReadingsTable extends WaterQualityReadings
    with TableInfo<$WaterQualityReadingsTable, WaterQualityReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterQualityReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stationIdMeta = const VerificationMeta(
    'stationId',
  );
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
    'station_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_stations (id)',
    ),
  );
  static const VerificationMeta _sampleTimeMeta = const VerificationMeta(
    'sampleTime',
  );
  @override
  late final GeneratedColumn<DateTime> sampleTime = GeneratedColumn<DateTime>(
    'sample_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _dissolvedOxygenMeta = const VerificationMeta(
    'dissolvedOxygen',
  );
  @override
  late final GeneratedColumn<double> dissolvedOxygen = GeneratedColumn<double>(
    'dissolved_oxygen',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pHMeta = const VerificationMeta('pH');
  @override
  late final GeneratedColumn<double> pH = GeneratedColumn<double>(
    'p_h',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chlorophyllAMeta = const VerificationMeta(
    'chlorophyllA',
  );
  @override
  late final GeneratedColumn<double> chlorophyllA = GeneratedColumn<double>(
    'chlorophyll_a',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _turbidityMeta = const VerificationMeta(
    'turbidity',
  );
  @override
  late final GeneratedColumn<double> turbidity = GeneratedColumn<double>(
    'turbidity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sampleDepthMeta = const VerificationMeta(
    'sampleDepth',
  );
  @override
  late final GeneratedColumn<double> sampleDepth = GeneratedColumn<double>(
    'sample_depth',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labMeta = const VerificationMeta('lab');
  @override
  late final GeneratedColumn<String> lab = GeneratedColumn<String>(
    'lab',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stationId,
    sampleTime,
    fetchedAt,
    providerId,
    dissolvedOxygen,
    pH,
    chlorophyllA,
    turbidity,
    sampleDepth,
    lab,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_quality_readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaterQualityReading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('station_id')) {
      context.handle(
        _stationIdMeta,
        stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('sample_time')) {
      context.handle(
        _sampleTimeMeta,
        sampleTime.isAcceptableOrUnknown(data['sample_time']!, _sampleTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_sampleTimeMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('dissolved_oxygen')) {
      context.handle(
        _dissolvedOxygenMeta,
        dissolvedOxygen.isAcceptableOrUnknown(
          data['dissolved_oxygen']!,
          _dissolvedOxygenMeta,
        ),
      );
    }
    if (data.containsKey('p_h')) {
      context.handle(_pHMeta, pH.isAcceptableOrUnknown(data['p_h']!, _pHMeta));
    }
    if (data.containsKey('chlorophyll_a')) {
      context.handle(
        _chlorophyllAMeta,
        chlorophyllA.isAcceptableOrUnknown(
          data['chlorophyll_a']!,
          _chlorophyllAMeta,
        ),
      );
    }
    if (data.containsKey('turbidity')) {
      context.handle(
        _turbidityMeta,
        turbidity.isAcceptableOrUnknown(data['turbidity']!, _turbidityMeta),
      );
    }
    if (data.containsKey('sample_depth')) {
      context.handle(
        _sampleDepthMeta,
        sampleDepth.isAcceptableOrUnknown(
          data['sample_depth']!,
          _sampleDepthMeta,
        ),
      );
    }
    if (data.containsKey('lab')) {
      context.handle(
        _labMeta,
        lab.isAcceptableOrUnknown(data['lab']!, _labMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {stationId, sampleTime, providerId},
  ];
  @override
  WaterQualityReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterQualityReading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}station_id'],
      )!,
      sampleTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sample_time'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      dissolvedOxygen: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dissolved_oxygen'],
      ),
      pH: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}p_h'],
      ),
      chlorophyllA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}chlorophyll_a'],
      ),
      turbidity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}turbidity'],
      ),
      sampleDepth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sample_depth'],
      ),
      lab: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lab'],
      ),
    );
  }

  @override
  $WaterQualityReadingsTable createAlias(String alias) {
    return $WaterQualityReadingsTable(attachedDatabase, alias);
  }
}

class WaterQualityReading extends DataClass
    implements Insertable<WaterQualityReading> {
  final int id;
  final int stationId;
  final DateTime sampleTime;
  final DateTime fetchedAt;
  final int providerId;
  final double? dissolvedOxygen;
  final double? pH;
  final double? chlorophyllA;
  final double? turbidity;
  final double? sampleDepth;
  final String? lab;
  const WaterQualityReading({
    required this.id,
    required this.stationId,
    required this.sampleTime,
    required this.fetchedAt,
    required this.providerId,
    this.dissolvedOxygen,
    this.pH,
    this.chlorophyllA,
    this.turbidity,
    this.sampleDepth,
    this.lab,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_id'] = Variable<int>(stationId);
    map['sample_time'] = Variable<DateTime>(sampleTime);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    map['provider_id'] = Variable<int>(providerId);
    if (!nullToAbsent || dissolvedOxygen != null) {
      map['dissolved_oxygen'] = Variable<double>(dissolvedOxygen);
    }
    if (!nullToAbsent || pH != null) {
      map['p_h'] = Variable<double>(pH);
    }
    if (!nullToAbsent || chlorophyllA != null) {
      map['chlorophyll_a'] = Variable<double>(chlorophyllA);
    }
    if (!nullToAbsent || turbidity != null) {
      map['turbidity'] = Variable<double>(turbidity);
    }
    if (!nullToAbsent || sampleDepth != null) {
      map['sample_depth'] = Variable<double>(sampleDepth);
    }
    if (!nullToAbsent || lab != null) {
      map['lab'] = Variable<String>(lab);
    }
    return map;
  }

  WaterQualityReadingsCompanion toCompanion(bool nullToAbsent) {
    return WaterQualityReadingsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      sampleTime: Value(sampleTime),
      fetchedAt: Value(fetchedAt),
      providerId: Value(providerId),
      dissolvedOxygen: dissolvedOxygen == null && nullToAbsent
          ? const Value.absent()
          : Value(dissolvedOxygen),
      pH: pH == null && nullToAbsent ? const Value.absent() : Value(pH),
      chlorophyllA: chlorophyllA == null && nullToAbsent
          ? const Value.absent()
          : Value(chlorophyllA),
      turbidity: turbidity == null && nullToAbsent
          ? const Value.absent()
          : Value(turbidity),
      sampleDepth: sampleDepth == null && nullToAbsent
          ? const Value.absent()
          : Value(sampleDepth),
      lab: lab == null && nullToAbsent ? const Value.absent() : Value(lab),
    );
  }

  factory WaterQualityReading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterQualityReading(
      id: serializer.fromJson<int>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      sampleTime: serializer.fromJson<DateTime>(json['sampleTime']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      providerId: serializer.fromJson<int>(json['providerId']),
      dissolvedOxygen: serializer.fromJson<double?>(json['dissolvedOxygen']),
      pH: serializer.fromJson<double?>(json['pH']),
      chlorophyllA: serializer.fromJson<double?>(json['chlorophyllA']),
      turbidity: serializer.fromJson<double?>(json['turbidity']),
      sampleDepth: serializer.fromJson<double?>(json['sampleDepth']),
      lab: serializer.fromJson<String?>(json['lab']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationId': serializer.toJson<int>(stationId),
      'sampleTime': serializer.toJson<DateTime>(sampleTime),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'providerId': serializer.toJson<int>(providerId),
      'dissolvedOxygen': serializer.toJson<double?>(dissolvedOxygen),
      'pH': serializer.toJson<double?>(pH),
      'chlorophyllA': serializer.toJson<double?>(chlorophyllA),
      'turbidity': serializer.toJson<double?>(turbidity),
      'sampleDepth': serializer.toJson<double?>(sampleDepth),
      'lab': serializer.toJson<String?>(lab),
    };
  }

  WaterQualityReading copyWith({
    int? id,
    int? stationId,
    DateTime? sampleTime,
    DateTime? fetchedAt,
    int? providerId,
    Value<double?> dissolvedOxygen = const Value.absent(),
    Value<double?> pH = const Value.absent(),
    Value<double?> chlorophyllA = const Value.absent(),
    Value<double?> turbidity = const Value.absent(),
    Value<double?> sampleDepth = const Value.absent(),
    Value<String?> lab = const Value.absent(),
  }) => WaterQualityReading(
    id: id ?? this.id,
    stationId: stationId ?? this.stationId,
    sampleTime: sampleTime ?? this.sampleTime,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    providerId: providerId ?? this.providerId,
    dissolvedOxygen: dissolvedOxygen.present
        ? dissolvedOxygen.value
        : this.dissolvedOxygen,
    pH: pH.present ? pH.value : this.pH,
    chlorophyllA: chlorophyllA.present ? chlorophyllA.value : this.chlorophyllA,
    turbidity: turbidity.present ? turbidity.value : this.turbidity,
    sampleDepth: sampleDepth.present ? sampleDepth.value : this.sampleDepth,
    lab: lab.present ? lab.value : this.lab,
  );
  WaterQualityReading copyWithCompanion(WaterQualityReadingsCompanion data) {
    return WaterQualityReading(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      sampleTime: data.sampleTime.present
          ? data.sampleTime.value
          : this.sampleTime,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      dissolvedOxygen: data.dissolvedOxygen.present
          ? data.dissolvedOxygen.value
          : this.dissolvedOxygen,
      pH: data.pH.present ? data.pH.value : this.pH,
      chlorophyllA: data.chlorophyllA.present
          ? data.chlorophyllA.value
          : this.chlorophyllA,
      turbidity: data.turbidity.present ? data.turbidity.value : this.turbidity,
      sampleDepth: data.sampleDepth.present
          ? data.sampleDepth.value
          : this.sampleDepth,
      lab: data.lab.present ? data.lab.value : this.lab,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterQualityReading(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('sampleTime: $sampleTime, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('providerId: $providerId, ')
          ..write('dissolvedOxygen: $dissolvedOxygen, ')
          ..write('pH: $pH, ')
          ..write('chlorophyllA: $chlorophyllA, ')
          ..write('turbidity: $turbidity, ')
          ..write('sampleDepth: $sampleDepth, ')
          ..write('lab: $lab')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    stationId,
    sampleTime,
    fetchedAt,
    providerId,
    dissolvedOxygen,
    pH,
    chlorophyllA,
    turbidity,
    sampleDepth,
    lab,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterQualityReading &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.sampleTime == this.sampleTime &&
          other.fetchedAt == this.fetchedAt &&
          other.providerId == this.providerId &&
          other.dissolvedOxygen == this.dissolvedOxygen &&
          other.pH == this.pH &&
          other.chlorophyllA == this.chlorophyllA &&
          other.turbidity == this.turbidity &&
          other.sampleDepth == this.sampleDepth &&
          other.lab == this.lab);
}

class WaterQualityReadingsCompanion
    extends UpdateCompanion<WaterQualityReading> {
  final Value<int> id;
  final Value<int> stationId;
  final Value<DateTime> sampleTime;
  final Value<DateTime> fetchedAt;
  final Value<int> providerId;
  final Value<double?> dissolvedOxygen;
  final Value<double?> pH;
  final Value<double?> chlorophyllA;
  final Value<double?> turbidity;
  final Value<double?> sampleDepth;
  final Value<String?> lab;
  const WaterQualityReadingsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.sampleTime = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.providerId = const Value.absent(),
    this.dissolvedOxygen = const Value.absent(),
    this.pH = const Value.absent(),
    this.chlorophyllA = const Value.absent(),
    this.turbidity = const Value.absent(),
    this.sampleDepth = const Value.absent(),
    this.lab = const Value.absent(),
  });
  WaterQualityReadingsCompanion.insert({
    this.id = const Value.absent(),
    required int stationId,
    required DateTime sampleTime,
    required DateTime fetchedAt,
    required int providerId,
    this.dissolvedOxygen = const Value.absent(),
    this.pH = const Value.absent(),
    this.chlorophyllA = const Value.absent(),
    this.turbidity = const Value.absent(),
    this.sampleDepth = const Value.absent(),
    this.lab = const Value.absent(),
  }) : stationId = Value(stationId),
       sampleTime = Value(sampleTime),
       fetchedAt = Value(fetchedAt),
       providerId = Value(providerId);
  static Insertable<WaterQualityReading> custom({
    Expression<int>? id,
    Expression<int>? stationId,
    Expression<DateTime>? sampleTime,
    Expression<DateTime>? fetchedAt,
    Expression<int>? providerId,
    Expression<double>? dissolvedOxygen,
    Expression<double>? pH,
    Expression<double>? chlorophyllA,
    Expression<double>? turbidity,
    Expression<double>? sampleDepth,
    Expression<String>? lab,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (sampleTime != null) 'sample_time': sampleTime,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (providerId != null) 'provider_id': providerId,
      if (dissolvedOxygen != null) 'dissolved_oxygen': dissolvedOxygen,
      if (pH != null) 'p_h': pH,
      if (chlorophyllA != null) 'chlorophyll_a': chlorophyllA,
      if (turbidity != null) 'turbidity': turbidity,
      if (sampleDepth != null) 'sample_depth': sampleDepth,
      if (lab != null) 'lab': lab,
    });
  }

  WaterQualityReadingsCompanion copyWith({
    Value<int>? id,
    Value<int>? stationId,
    Value<DateTime>? sampleTime,
    Value<DateTime>? fetchedAt,
    Value<int>? providerId,
    Value<double?>? dissolvedOxygen,
    Value<double?>? pH,
    Value<double?>? chlorophyllA,
    Value<double?>? turbidity,
    Value<double?>? sampleDepth,
    Value<String?>? lab,
  }) {
    return WaterQualityReadingsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      sampleTime: sampleTime ?? this.sampleTime,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      providerId: providerId ?? this.providerId,
      dissolvedOxygen: dissolvedOxygen ?? this.dissolvedOxygen,
      pH: pH ?? this.pH,
      chlorophyllA: chlorophyllA ?? this.chlorophyllA,
      turbidity: turbidity ?? this.turbidity,
      sampleDepth: sampleDepth ?? this.sampleDepth,
      lab: lab ?? this.lab,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (sampleTime.present) {
      map['sample_time'] = Variable<DateTime>(sampleTime.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (dissolvedOxygen.present) {
      map['dissolved_oxygen'] = Variable<double>(dissolvedOxygen.value);
    }
    if (pH.present) {
      map['p_h'] = Variable<double>(pH.value);
    }
    if (chlorophyllA.present) {
      map['chlorophyll_a'] = Variable<double>(chlorophyllA.value);
    }
    if (turbidity.present) {
      map['turbidity'] = Variable<double>(turbidity.value);
    }
    if (sampleDepth.present) {
      map['sample_depth'] = Variable<double>(sampleDepth.value);
    }
    if (lab.present) {
      map['lab'] = Variable<String>(lab.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterQualityReadingsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('sampleTime: $sampleTime, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('providerId: $providerId, ')
          ..write('dissolvedOxygen: $dissolvedOxygen, ')
          ..write('pH: $pH, ')
          ..write('chlorophyllA: $chlorophyllA, ')
          ..write('turbidity: $turbidity, ')
          ..write('sampleDepth: $sampleDepth, ')
          ..write('lab: $lab')
          ..write(')'))
        .toString();
  }
}

class $AlgaeReportsTable extends AlgaeReports
    with TableInfo<$AlgaeReportsTable, AlgaeReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlgaeReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stationIdMeta = const VerificationMeta(
    'stationId',
  );
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
    'station_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_stations (id)',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES weather_providers (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _observationTimeMeta = const VerificationMeta(
    'observationTime',
  );
  @override
  late final GeneratedColumn<DateTime> observationTime =
      GeneratedColumn<DateTime>(
        'observation_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesNameMeta = const VerificationMeta(
    'speciesName',
  );
  @override
  late final GeneratedColumn<String> speciesName = GeneratedColumn<String>(
    'species_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _biomassMeta = const VerificationMeta(
    'biomass',
  );
  @override
  late final GeneratedColumn<double> biomass = GeneratedColumn<double>(
    'biomass',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cellCountMeta = const VerificationMeta(
    'cellCount',
  );
  @override
  late final GeneratedColumn<int> cellCount = GeneratedColumn<int>(
    'cell_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dominantSpeciesMeta = const VerificationMeta(
    'dominantSpecies',
  );
  @override
  late final GeneratedColumn<String> dominantSpecies = GeneratedColumn<String>(
    'dominant_species',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _riskLevelMeta = const VerificationMeta(
    'riskLevel',
  );
  @override
  late final GeneratedColumn<int> riskLevel = GeneratedColumn<int>(
    'risk_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stationId,
    providerId,
    observationTime,
    fetchedAt,
    speciesName,
    biomass,
    cellCount,
    dominantSpecies,
    riskLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'algae_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<AlgaeReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('station_id')) {
      context.handle(
        _stationIdMeta,
        stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('observation_time')) {
      context.handle(
        _observationTimeMeta,
        observationTime.isAcceptableOrUnknown(
          data['observation_time']!,
          _observationTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_observationTimeMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('species_name')) {
      context.handle(
        _speciesNameMeta,
        speciesName.isAcceptableOrUnknown(
          data['species_name']!,
          _speciesNameMeta,
        ),
      );
    }
    if (data.containsKey('biomass')) {
      context.handle(
        _biomassMeta,
        biomass.isAcceptableOrUnknown(data['biomass']!, _biomassMeta),
      );
    }
    if (data.containsKey('cell_count')) {
      context.handle(
        _cellCountMeta,
        cellCount.isAcceptableOrUnknown(data['cell_count']!, _cellCountMeta),
      );
    }
    if (data.containsKey('dominant_species')) {
      context.handle(
        _dominantSpeciesMeta,
        dominantSpecies.isAcceptableOrUnknown(
          data['dominant_species']!,
          _dominantSpeciesMeta,
        ),
      );
    }
    if (data.containsKey('risk_level')) {
      context.handle(
        _riskLevelMeta,
        riskLevel.isAcceptableOrUnknown(data['risk_level']!, _riskLevelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {stationId, observationTime, providerId},
  ];
  @override
  AlgaeReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AlgaeReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}station_id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      observationTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}observation_time'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      speciesName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_name'],
      ),
      biomass: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}biomass'],
      ),
      cellCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cell_count'],
      ),
      dominantSpecies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dominant_species'],
      ),
      riskLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}risk_level'],
      ),
    );
  }

  @override
  $AlgaeReportsTable createAlias(String alias) {
    return $AlgaeReportsTable(attachedDatabase, alias);
  }
}

class AlgaeReport extends DataClass implements Insertable<AlgaeReport> {
  final int id;
  final int stationId;
  final int providerId;
  final DateTime observationTime;
  final DateTime fetchedAt;
  final String? speciesName;
  final double? biomass;
  final int? cellCount;
  final String? dominantSpecies;
  final int? riskLevel;
  const AlgaeReport({
    required this.id,
    required this.stationId,
    required this.providerId,
    required this.observationTime,
    required this.fetchedAt,
    this.speciesName,
    this.biomass,
    this.cellCount,
    this.dominantSpecies,
    this.riskLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_id'] = Variable<int>(stationId);
    map['provider_id'] = Variable<int>(providerId);
    map['observation_time'] = Variable<DateTime>(observationTime);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    if (!nullToAbsent || speciesName != null) {
      map['species_name'] = Variable<String>(speciesName);
    }
    if (!nullToAbsent || biomass != null) {
      map['biomass'] = Variable<double>(biomass);
    }
    if (!nullToAbsent || cellCount != null) {
      map['cell_count'] = Variable<int>(cellCount);
    }
    if (!nullToAbsent || dominantSpecies != null) {
      map['dominant_species'] = Variable<String>(dominantSpecies);
    }
    if (!nullToAbsent || riskLevel != null) {
      map['risk_level'] = Variable<int>(riskLevel);
    }
    return map;
  }

  AlgaeReportsCompanion toCompanion(bool nullToAbsent) {
    return AlgaeReportsCompanion(
      id: Value(id),
      stationId: Value(stationId),
      providerId: Value(providerId),
      observationTime: Value(observationTime),
      fetchedAt: Value(fetchedAt),
      speciesName: speciesName == null && nullToAbsent
          ? const Value.absent()
          : Value(speciesName),
      biomass: biomass == null && nullToAbsent
          ? const Value.absent()
          : Value(biomass),
      cellCount: cellCount == null && nullToAbsent
          ? const Value.absent()
          : Value(cellCount),
      dominantSpecies: dominantSpecies == null && nullToAbsent
          ? const Value.absent()
          : Value(dominantSpecies),
      riskLevel: riskLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(riskLevel),
    );
  }

  factory AlgaeReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AlgaeReport(
      id: serializer.fromJson<int>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      providerId: serializer.fromJson<int>(json['providerId']),
      observationTime: serializer.fromJson<DateTime>(json['observationTime']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      speciesName: serializer.fromJson<String?>(json['speciesName']),
      biomass: serializer.fromJson<double?>(json['biomass']),
      cellCount: serializer.fromJson<int?>(json['cellCount']),
      dominantSpecies: serializer.fromJson<String?>(json['dominantSpecies']),
      riskLevel: serializer.fromJson<int?>(json['riskLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationId': serializer.toJson<int>(stationId),
      'providerId': serializer.toJson<int>(providerId),
      'observationTime': serializer.toJson<DateTime>(observationTime),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'speciesName': serializer.toJson<String?>(speciesName),
      'biomass': serializer.toJson<double?>(biomass),
      'cellCount': serializer.toJson<int?>(cellCount),
      'dominantSpecies': serializer.toJson<String?>(dominantSpecies),
      'riskLevel': serializer.toJson<int?>(riskLevel),
    };
  }

  AlgaeReport copyWith({
    int? id,
    int? stationId,
    int? providerId,
    DateTime? observationTime,
    DateTime? fetchedAt,
    Value<String?> speciesName = const Value.absent(),
    Value<double?> biomass = const Value.absent(),
    Value<int?> cellCount = const Value.absent(),
    Value<String?> dominantSpecies = const Value.absent(),
    Value<int?> riskLevel = const Value.absent(),
  }) => AlgaeReport(
    id: id ?? this.id,
    stationId: stationId ?? this.stationId,
    providerId: providerId ?? this.providerId,
    observationTime: observationTime ?? this.observationTime,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    speciesName: speciesName.present ? speciesName.value : this.speciesName,
    biomass: biomass.present ? biomass.value : this.biomass,
    cellCount: cellCount.present ? cellCount.value : this.cellCount,
    dominantSpecies: dominantSpecies.present
        ? dominantSpecies.value
        : this.dominantSpecies,
    riskLevel: riskLevel.present ? riskLevel.value : this.riskLevel,
  );
  AlgaeReport copyWithCompanion(AlgaeReportsCompanion data) {
    return AlgaeReport(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      observationTime: data.observationTime.present
          ? data.observationTime.value
          : this.observationTime,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      speciesName: data.speciesName.present
          ? data.speciesName.value
          : this.speciesName,
      biomass: data.biomass.present ? data.biomass.value : this.biomass,
      cellCount: data.cellCount.present ? data.cellCount.value : this.cellCount,
      dominantSpecies: data.dominantSpecies.present
          ? data.dominantSpecies.value
          : this.dominantSpecies,
      riskLevel: data.riskLevel.present ? data.riskLevel.value : this.riskLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AlgaeReport(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('observationTime: $observationTime, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('speciesName: $speciesName, ')
          ..write('biomass: $biomass, ')
          ..write('cellCount: $cellCount, ')
          ..write('dominantSpecies: $dominantSpecies, ')
          ..write('riskLevel: $riskLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    stationId,
    providerId,
    observationTime,
    fetchedAt,
    speciesName,
    biomass,
    cellCount,
    dominantSpecies,
    riskLevel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AlgaeReport &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.providerId == this.providerId &&
          other.observationTime == this.observationTime &&
          other.fetchedAt == this.fetchedAt &&
          other.speciesName == this.speciesName &&
          other.biomass == this.biomass &&
          other.cellCount == this.cellCount &&
          other.dominantSpecies == this.dominantSpecies &&
          other.riskLevel == this.riskLevel);
}

class AlgaeReportsCompanion extends UpdateCompanion<AlgaeReport> {
  final Value<int> id;
  final Value<int> stationId;
  final Value<int> providerId;
  final Value<DateTime> observationTime;
  final Value<DateTime> fetchedAt;
  final Value<String?> speciesName;
  final Value<double?> biomass;
  final Value<int?> cellCount;
  final Value<String?> dominantSpecies;
  final Value<int?> riskLevel;
  const AlgaeReportsCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.observationTime = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.speciesName = const Value.absent(),
    this.biomass = const Value.absent(),
    this.cellCount = const Value.absent(),
    this.dominantSpecies = const Value.absent(),
    this.riskLevel = const Value.absent(),
  });
  AlgaeReportsCompanion.insert({
    this.id = const Value.absent(),
    required int stationId,
    required int providerId,
    required DateTime observationTime,
    required DateTime fetchedAt,
    this.speciesName = const Value.absent(),
    this.biomass = const Value.absent(),
    this.cellCount = const Value.absent(),
    this.dominantSpecies = const Value.absent(),
    this.riskLevel = const Value.absent(),
  }) : stationId = Value(stationId),
       providerId = Value(providerId),
       observationTime = Value(observationTime),
       fetchedAt = Value(fetchedAt);
  static Insertable<AlgaeReport> custom({
    Expression<int>? id,
    Expression<int>? stationId,
    Expression<int>? providerId,
    Expression<DateTime>? observationTime,
    Expression<DateTime>? fetchedAt,
    Expression<String>? speciesName,
    Expression<double>? biomass,
    Expression<int>? cellCount,
    Expression<String>? dominantSpecies,
    Expression<int>? riskLevel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (providerId != null) 'provider_id': providerId,
      if (observationTime != null) 'observation_time': observationTime,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (speciesName != null) 'species_name': speciesName,
      if (biomass != null) 'biomass': biomass,
      if (cellCount != null) 'cell_count': cellCount,
      if (dominantSpecies != null) 'dominant_species': dominantSpecies,
      if (riskLevel != null) 'risk_level': riskLevel,
    });
  }

  AlgaeReportsCompanion copyWith({
    Value<int>? id,
    Value<int>? stationId,
    Value<int>? providerId,
    Value<DateTime>? observationTime,
    Value<DateTime>? fetchedAt,
    Value<String?>? speciesName,
    Value<double?>? biomass,
    Value<int?>? cellCount,
    Value<String?>? dominantSpecies,
    Value<int?>? riskLevel,
  }) {
    return AlgaeReportsCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      providerId: providerId ?? this.providerId,
      observationTime: observationTime ?? this.observationTime,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      speciesName: speciesName ?? this.speciesName,
      biomass: biomass ?? this.biomass,
      cellCount: cellCount ?? this.cellCount,
      dominantSpecies: dominantSpecies ?? this.dominantSpecies,
      riskLevel: riskLevel ?? this.riskLevel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (observationTime.present) {
      map['observation_time'] = Variable<DateTime>(observationTime.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (speciesName.present) {
      map['species_name'] = Variable<String>(speciesName.value);
    }
    if (biomass.present) {
      map['biomass'] = Variable<double>(biomass.value);
    }
    if (cellCount.present) {
      map['cell_count'] = Variable<int>(cellCount.value);
    }
    if (dominantSpecies.present) {
      map['dominant_species'] = Variable<String>(dominantSpecies.value);
    }
    if (riskLevel.present) {
      map['risk_level'] = Variable<int>(riskLevel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlgaeReportsCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('providerId: $providerId, ')
          ..write('observationTime: $observationTime, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('speciesName: $speciesName, ')
          ..write('biomass: $biomass, ')
          ..write('cellCount: $cellCount, ')
          ..write('dominantSpecies: $dominantSpecies, ')
          ..write('riskLevel: $riskLevel')
          ..write(')'))
        .toString();
  }
}

class $MarineMapTilesTable extends MarineMapTiles
    with TableInfo<$MarineMapTilesTable, MarineMapTile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MarineMapTilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _zoomMeta = const VerificationMeta('zoom');
  @override
  late final GeneratedColumn<int> zoom = GeneratedColumn<int>(
    'zoom',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<int> x = GeneratedColumn<int>(
    'x',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<int> y = GeneratedColumn<int>(
    'y',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tileDataMeta = const VerificationMeta(
    'tileData',
  );
  @override
  late final GeneratedColumn<Uint8List> tileData = GeneratedColumn<Uint8List>(
    'tile_data',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refCountMeta = const VerificationMeta(
    'refCount',
  );
  @override
  late final GeneratedColumn<int> refCount = GeneratedColumn<int>(
    'ref_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastAccessedMeta = const VerificationMeta(
    'lastAccessed',
  );
  @override
  late final GeneratedColumn<DateTime> lastAccessed = GeneratedColumn<DateTime>(
    'last_accessed',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _md5HashMeta = const VerificationMeta(
    'md5Hash',
  );
  @override
  late final GeneratedColumn<String> md5Hash = GeneratedColumn<String>(
    'md5_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    zoom,
    x,
    y,
    tileData,
    refCount,
    lastAccessed,
    sourceId,
    md5Hash,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'marine_map_tiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<MarineMapTile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('zoom')) {
      context.handle(
        _zoomMeta,
        zoom.isAcceptableOrUnknown(data['zoom']!, _zoomMeta),
      );
    } else if (isInserting) {
      context.missing(_zoomMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('tile_data')) {
      context.handle(
        _tileDataMeta,
        tileData.isAcceptableOrUnknown(data['tile_data']!, _tileDataMeta),
      );
    } else if (isInserting) {
      context.missing(_tileDataMeta);
    }
    if (data.containsKey('ref_count')) {
      context.handle(
        _refCountMeta,
        refCount.isAcceptableOrUnknown(data['ref_count']!, _refCountMeta),
      );
    }
    if (data.containsKey('last_accessed')) {
      context.handle(
        _lastAccessedMeta,
        lastAccessed.isAcceptableOrUnknown(
          data['last_accessed']!,
          _lastAccessedMeta,
        ),
      );
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    if (data.containsKey('md5_hash')) {
      context.handle(
        _md5HashMeta,
        md5Hash.isAcceptableOrUnknown(data['md5_hash']!, _md5HashMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {zoom, x, y, sourceId};
  @override
  MarineMapTile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MarineMapTile(
      zoom: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}zoom'],
      )!,
      x: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}x'],
      )!,
      y: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}y'],
      )!,
      tileData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}tile_data'],
      )!,
      refCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ref_count'],
      )!,
      lastAccessed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_accessed'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
      md5Hash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}md5_hash'],
      ),
    );
  }

  @override
  $MarineMapTilesTable createAlias(String alias) {
    return $MarineMapTilesTable(attachedDatabase, alias);
  }
}

class MarineMapTile extends DataClass implements Insertable<MarineMapTile> {
  final int zoom;
  final int x;
  final int y;
  final Uint8List tileData;

  /// Number of offline regions that use this tile.
  /// Tile is deleted only when refCount reaches 0.
  final int refCount;

  /// For LRU caching if we ever implement soft-cache limits
  final DateTime lastAccessed;

  /// Identifier for the map source (e.g. URL template or source name)
  final String sourceId;

  /// Optional MD5 hash for integrity checks
  final String? md5Hash;
  const MarineMapTile({
    required this.zoom,
    required this.x,
    required this.y,
    required this.tileData,
    required this.refCount,
    required this.lastAccessed,
    required this.sourceId,
    this.md5Hash,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['zoom'] = Variable<int>(zoom);
    map['x'] = Variable<int>(x);
    map['y'] = Variable<int>(y);
    map['tile_data'] = Variable<Uint8List>(tileData);
    map['ref_count'] = Variable<int>(refCount);
    map['last_accessed'] = Variable<DateTime>(lastAccessed);
    map['source_id'] = Variable<String>(sourceId);
    if (!nullToAbsent || md5Hash != null) {
      map['md5_hash'] = Variable<String>(md5Hash);
    }
    return map;
  }

  MarineMapTilesCompanion toCompanion(bool nullToAbsent) {
    return MarineMapTilesCompanion(
      zoom: Value(zoom),
      x: Value(x),
      y: Value(y),
      tileData: Value(tileData),
      refCount: Value(refCount),
      lastAccessed: Value(lastAccessed),
      sourceId: Value(sourceId),
      md5Hash: md5Hash == null && nullToAbsent
          ? const Value.absent()
          : Value(md5Hash),
    );
  }

  factory MarineMapTile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MarineMapTile(
      zoom: serializer.fromJson<int>(json['zoom']),
      x: serializer.fromJson<int>(json['x']),
      y: serializer.fromJson<int>(json['y']),
      tileData: serializer.fromJson<Uint8List>(json['tileData']),
      refCount: serializer.fromJson<int>(json['refCount']),
      lastAccessed: serializer.fromJson<DateTime>(json['lastAccessed']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
      md5Hash: serializer.fromJson<String?>(json['md5Hash']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'zoom': serializer.toJson<int>(zoom),
      'x': serializer.toJson<int>(x),
      'y': serializer.toJson<int>(y),
      'tileData': serializer.toJson<Uint8List>(tileData),
      'refCount': serializer.toJson<int>(refCount),
      'lastAccessed': serializer.toJson<DateTime>(lastAccessed),
      'sourceId': serializer.toJson<String>(sourceId),
      'md5Hash': serializer.toJson<String?>(md5Hash),
    };
  }

  MarineMapTile copyWith({
    int? zoom,
    int? x,
    int? y,
    Uint8List? tileData,
    int? refCount,
    DateTime? lastAccessed,
    String? sourceId,
    Value<String?> md5Hash = const Value.absent(),
  }) => MarineMapTile(
    zoom: zoom ?? this.zoom,
    x: x ?? this.x,
    y: y ?? this.y,
    tileData: tileData ?? this.tileData,
    refCount: refCount ?? this.refCount,
    lastAccessed: lastAccessed ?? this.lastAccessed,
    sourceId: sourceId ?? this.sourceId,
    md5Hash: md5Hash.present ? md5Hash.value : this.md5Hash,
  );
  MarineMapTile copyWithCompanion(MarineMapTilesCompanion data) {
    return MarineMapTile(
      zoom: data.zoom.present ? data.zoom.value : this.zoom,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      tileData: data.tileData.present ? data.tileData.value : this.tileData,
      refCount: data.refCount.present ? data.refCount.value : this.refCount,
      lastAccessed: data.lastAccessed.present
          ? data.lastAccessed.value
          : this.lastAccessed,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      md5Hash: data.md5Hash.present ? data.md5Hash.value : this.md5Hash,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MarineMapTile(')
          ..write('zoom: $zoom, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('tileData: $tileData, ')
          ..write('refCount: $refCount, ')
          ..write('lastAccessed: $lastAccessed, ')
          ..write('sourceId: $sourceId, ')
          ..write('md5Hash: $md5Hash')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    zoom,
    x,
    y,
    $driftBlobEquality.hash(tileData),
    refCount,
    lastAccessed,
    sourceId,
    md5Hash,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MarineMapTile &&
          other.zoom == this.zoom &&
          other.x == this.x &&
          other.y == this.y &&
          $driftBlobEquality.equals(other.tileData, this.tileData) &&
          other.refCount == this.refCount &&
          other.lastAccessed == this.lastAccessed &&
          other.sourceId == this.sourceId &&
          other.md5Hash == this.md5Hash);
}

class MarineMapTilesCompanion extends UpdateCompanion<MarineMapTile> {
  final Value<int> zoom;
  final Value<int> x;
  final Value<int> y;
  final Value<Uint8List> tileData;
  final Value<int> refCount;
  final Value<DateTime> lastAccessed;
  final Value<String> sourceId;
  final Value<String?> md5Hash;
  final Value<int> rowid;
  const MarineMapTilesCompanion({
    this.zoom = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.tileData = const Value.absent(),
    this.refCount = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.md5Hash = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MarineMapTilesCompanion.insert({
    required int zoom,
    required int x,
    required int y,
    required Uint8List tileData,
    this.refCount = const Value.absent(),
    this.lastAccessed = const Value.absent(),
    required String sourceId,
    this.md5Hash = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : zoom = Value(zoom),
       x = Value(x),
       y = Value(y),
       tileData = Value(tileData),
       sourceId = Value(sourceId);
  static Insertable<MarineMapTile> custom({
    Expression<int>? zoom,
    Expression<int>? x,
    Expression<int>? y,
    Expression<Uint8List>? tileData,
    Expression<int>? refCount,
    Expression<DateTime>? lastAccessed,
    Expression<String>? sourceId,
    Expression<String>? md5Hash,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (zoom != null) 'zoom': zoom,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (tileData != null) 'tile_data': tileData,
      if (refCount != null) 'ref_count': refCount,
      if (lastAccessed != null) 'last_accessed': lastAccessed,
      if (sourceId != null) 'source_id': sourceId,
      if (md5Hash != null) 'md5_hash': md5Hash,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MarineMapTilesCompanion copyWith({
    Value<int>? zoom,
    Value<int>? x,
    Value<int>? y,
    Value<Uint8List>? tileData,
    Value<int>? refCount,
    Value<DateTime>? lastAccessed,
    Value<String>? sourceId,
    Value<String?>? md5Hash,
    Value<int>? rowid,
  }) {
    return MarineMapTilesCompanion(
      zoom: zoom ?? this.zoom,
      x: x ?? this.x,
      y: y ?? this.y,
      tileData: tileData ?? this.tileData,
      refCount: refCount ?? this.refCount,
      lastAccessed: lastAccessed ?? this.lastAccessed,
      sourceId: sourceId ?? this.sourceId,
      md5Hash: md5Hash ?? this.md5Hash,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (zoom.present) {
      map['zoom'] = Variable<int>(zoom.value);
    }
    if (x.present) {
      map['x'] = Variable<int>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<int>(y.value);
    }
    if (tileData.present) {
      map['tile_data'] = Variable<Uint8List>(tileData.value);
    }
    if (refCount.present) {
      map['ref_count'] = Variable<int>(refCount.value);
    }
    if (lastAccessed.present) {
      map['last_accessed'] = Variable<DateTime>(lastAccessed.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (md5Hash.present) {
      map['md5_hash'] = Variable<String>(md5Hash.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MarineMapTilesCompanion(')
          ..write('zoom: $zoom, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('tileData: $tileData, ')
          ..write('refCount: $refCount, ')
          ..write('lastAccessed: $lastAccessed, ')
          ..write('sourceId: $sourceId, ')
          ..write('md5Hash: $md5Hash, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OfflineRegionsTable extends OfflineRegions
    with TableInfo<$OfflineRegionsTable, OfflineRegion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfflineRegionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minLatMeta = const VerificationMeta('minLat');
  @override
  late final GeneratedColumn<double> minLat = GeneratedColumn<double>(
    'min_lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxLatMeta = const VerificationMeta('maxLat');
  @override
  late final GeneratedColumn<double> maxLat = GeneratedColumn<double>(
    'max_lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minLonMeta = const VerificationMeta('minLon');
  @override
  late final GeneratedColumn<double> minLon = GeneratedColumn<double>(
    'min_lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxLonMeta = const VerificationMeta('maxLon');
  @override
  late final GeneratedColumn<double> maxLon = GeneratedColumn<double>(
    'max_lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalTilesMeta = const VerificationMeta(
    'totalTiles',
  );
  @override
  late final GeneratedColumn<int> totalTiles = GeneratedColumn<int>(
    'total_tiles',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedSizeBytesMeta =
      const VerificationMeta('estimatedSizeBytes');
  @override
  late final GeneratedColumn<int> estimatedSizeBytes = GeneratedColumn<int>(
    'estimated_size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _downloadStatusMeta = const VerificationMeta(
    'downloadStatus',
  );
  @override
  late final GeneratedColumn<int> downloadStatus = GeneratedColumn<int>(
    'download_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    minLat,
    maxLat,
    minLon,
    maxLon,
    totalTiles,
    estimatedSizeBytes,
    downloadStatus,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offline_regions';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfflineRegion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('min_lat')) {
      context.handle(
        _minLatMeta,
        minLat.isAcceptableOrUnknown(data['min_lat']!, _minLatMeta),
      );
    } else if (isInserting) {
      context.missing(_minLatMeta);
    }
    if (data.containsKey('max_lat')) {
      context.handle(
        _maxLatMeta,
        maxLat.isAcceptableOrUnknown(data['max_lat']!, _maxLatMeta),
      );
    } else if (isInserting) {
      context.missing(_maxLatMeta);
    }
    if (data.containsKey('min_lon')) {
      context.handle(
        _minLonMeta,
        minLon.isAcceptableOrUnknown(data['min_lon']!, _minLonMeta),
      );
    } else if (isInserting) {
      context.missing(_minLonMeta);
    }
    if (data.containsKey('max_lon')) {
      context.handle(
        _maxLonMeta,
        maxLon.isAcceptableOrUnknown(data['max_lon']!, _maxLonMeta),
      );
    } else if (isInserting) {
      context.missing(_maxLonMeta);
    }
    if (data.containsKey('total_tiles')) {
      context.handle(
        _totalTilesMeta,
        totalTiles.isAcceptableOrUnknown(data['total_tiles']!, _totalTilesMeta),
      );
    } else if (isInserting) {
      context.missing(_totalTilesMeta);
    }
    if (data.containsKey('estimated_size_bytes')) {
      context.handle(
        _estimatedSizeBytesMeta,
        estimatedSizeBytes.isAcceptableOrUnknown(
          data['estimated_size_bytes']!,
          _estimatedSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('download_status')) {
      context.handle(
        _downloadStatusMeta,
        downloadStatus.isAcceptableOrUnknown(
          data['download_status']!,
          _downloadStatusMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OfflineRegion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfflineRegion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      minLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}min_lat'],
      )!,
      maxLat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_lat'],
      )!,
      minLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}min_lon'],
      )!,
      maxLon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_lon'],
      )!,
      totalTiles: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_tiles'],
      )!,
      estimatedSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_size_bytes'],
      )!,
      downloadStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}download_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $OfflineRegionsTable createAlias(String alias) {
    return $OfflineRegionsTable(attachedDatabase, alias);
  }
}

class OfflineRegion extends DataClass implements Insertable<OfflineRegion> {
  final int id;
  final String name;
  final double minLat;
  final double maxLat;
  final double minLon;
  final double maxLon;
  final int totalTiles;
  final int estimatedSizeBytes;

  /// Download status: 0=Pending, 1=Downloading, 2=Success, 3=Error, 4=Paused
  final int downloadStatus;
  final DateTime createdAt;
  const OfflineRegion({
    required this.id,
    required this.name,
    required this.minLat,
    required this.maxLat,
    required this.minLon,
    required this.maxLon,
    required this.totalTiles,
    required this.estimatedSizeBytes,
    required this.downloadStatus,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['min_lat'] = Variable<double>(minLat);
    map['max_lat'] = Variable<double>(maxLat);
    map['min_lon'] = Variable<double>(minLon);
    map['max_lon'] = Variable<double>(maxLon);
    map['total_tiles'] = Variable<int>(totalTiles);
    map['estimated_size_bytes'] = Variable<int>(estimatedSizeBytes);
    map['download_status'] = Variable<int>(downloadStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OfflineRegionsCompanion toCompanion(bool nullToAbsent) {
    return OfflineRegionsCompanion(
      id: Value(id),
      name: Value(name),
      minLat: Value(minLat),
      maxLat: Value(maxLat),
      minLon: Value(minLon),
      maxLon: Value(maxLon),
      totalTiles: Value(totalTiles),
      estimatedSizeBytes: Value(estimatedSizeBytes),
      downloadStatus: Value(downloadStatus),
      createdAt: Value(createdAt),
    );
  }

  factory OfflineRegion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfflineRegion(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      minLat: serializer.fromJson<double>(json['minLat']),
      maxLat: serializer.fromJson<double>(json['maxLat']),
      minLon: serializer.fromJson<double>(json['minLon']),
      maxLon: serializer.fromJson<double>(json['maxLon']),
      totalTiles: serializer.fromJson<int>(json['totalTiles']),
      estimatedSizeBytes: serializer.fromJson<int>(json['estimatedSizeBytes']),
      downloadStatus: serializer.fromJson<int>(json['downloadStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'minLat': serializer.toJson<double>(minLat),
      'maxLat': serializer.toJson<double>(maxLat),
      'minLon': serializer.toJson<double>(minLon),
      'maxLon': serializer.toJson<double>(maxLon),
      'totalTiles': serializer.toJson<int>(totalTiles),
      'estimatedSizeBytes': serializer.toJson<int>(estimatedSizeBytes),
      'downloadStatus': serializer.toJson<int>(downloadStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OfflineRegion copyWith({
    int? id,
    String? name,
    double? minLat,
    double? maxLat,
    double? minLon,
    double? maxLon,
    int? totalTiles,
    int? estimatedSizeBytes,
    int? downloadStatus,
    DateTime? createdAt,
  }) => OfflineRegion(
    id: id ?? this.id,
    name: name ?? this.name,
    minLat: minLat ?? this.minLat,
    maxLat: maxLat ?? this.maxLat,
    minLon: minLon ?? this.minLon,
    maxLon: maxLon ?? this.maxLon,
    totalTiles: totalTiles ?? this.totalTiles,
    estimatedSizeBytes: estimatedSizeBytes ?? this.estimatedSizeBytes,
    downloadStatus: downloadStatus ?? this.downloadStatus,
    createdAt: createdAt ?? this.createdAt,
  );
  OfflineRegion copyWithCompanion(OfflineRegionsCompanion data) {
    return OfflineRegion(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      minLat: data.minLat.present ? data.minLat.value : this.minLat,
      maxLat: data.maxLat.present ? data.maxLat.value : this.maxLat,
      minLon: data.minLon.present ? data.minLon.value : this.minLon,
      maxLon: data.maxLon.present ? data.maxLon.value : this.maxLon,
      totalTiles: data.totalTiles.present
          ? data.totalTiles.value
          : this.totalTiles,
      estimatedSizeBytes: data.estimatedSizeBytes.present
          ? data.estimatedSizeBytes.value
          : this.estimatedSizeBytes,
      downloadStatus: data.downloadStatus.present
          ? data.downloadStatus.value
          : this.downloadStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfflineRegion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('minLat: $minLat, ')
          ..write('maxLat: $maxLat, ')
          ..write('minLon: $minLon, ')
          ..write('maxLon: $maxLon, ')
          ..write('totalTiles: $totalTiles, ')
          ..write('estimatedSizeBytes: $estimatedSizeBytes, ')
          ..write('downloadStatus: $downloadStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    minLat,
    maxLat,
    minLon,
    maxLon,
    totalTiles,
    estimatedSizeBytes,
    downloadStatus,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfflineRegion &&
          other.id == this.id &&
          other.name == this.name &&
          other.minLat == this.minLat &&
          other.maxLat == this.maxLat &&
          other.minLon == this.minLon &&
          other.maxLon == this.maxLon &&
          other.totalTiles == this.totalTiles &&
          other.estimatedSizeBytes == this.estimatedSizeBytes &&
          other.downloadStatus == this.downloadStatus &&
          other.createdAt == this.createdAt);
}

class OfflineRegionsCompanion extends UpdateCompanion<OfflineRegion> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> minLat;
  final Value<double> maxLat;
  final Value<double> minLon;
  final Value<double> maxLon;
  final Value<int> totalTiles;
  final Value<int> estimatedSizeBytes;
  final Value<int> downloadStatus;
  final Value<DateTime> createdAt;
  const OfflineRegionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.minLat = const Value.absent(),
    this.maxLat = const Value.absent(),
    this.minLon = const Value.absent(),
    this.maxLon = const Value.absent(),
    this.totalTiles = const Value.absent(),
    this.estimatedSizeBytes = const Value.absent(),
    this.downloadStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OfflineRegionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double minLat,
    required double maxLat,
    required double minLon,
    required double maxLon,
    required int totalTiles,
    this.estimatedSizeBytes = const Value.absent(),
    this.downloadStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       minLat = Value(minLat),
       maxLat = Value(maxLat),
       minLon = Value(minLon),
       maxLon = Value(maxLon),
       totalTiles = Value(totalTiles);
  static Insertable<OfflineRegion> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? minLat,
    Expression<double>? maxLat,
    Expression<double>? minLon,
    Expression<double>? maxLon,
    Expression<int>? totalTiles,
    Expression<int>? estimatedSizeBytes,
    Expression<int>? downloadStatus,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (minLat != null) 'min_lat': minLat,
      if (maxLat != null) 'max_lat': maxLat,
      if (minLon != null) 'min_lon': minLon,
      if (maxLon != null) 'max_lon': maxLon,
      if (totalTiles != null) 'total_tiles': totalTiles,
      if (estimatedSizeBytes != null)
        'estimated_size_bytes': estimatedSizeBytes,
      if (downloadStatus != null) 'download_status': downloadStatus,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OfflineRegionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? minLat,
    Value<double>? maxLat,
    Value<double>? minLon,
    Value<double>? maxLon,
    Value<int>? totalTiles,
    Value<int>? estimatedSizeBytes,
    Value<int>? downloadStatus,
    Value<DateTime>? createdAt,
  }) {
    return OfflineRegionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      minLat: minLat ?? this.minLat,
      maxLat: maxLat ?? this.maxLat,
      minLon: minLon ?? this.minLon,
      maxLon: maxLon ?? this.maxLon,
      totalTiles: totalTiles ?? this.totalTiles,
      estimatedSizeBytes: estimatedSizeBytes ?? this.estimatedSizeBytes,
      downloadStatus: downloadStatus ?? this.downloadStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (minLat.present) {
      map['min_lat'] = Variable<double>(minLat.value);
    }
    if (maxLat.present) {
      map['max_lat'] = Variable<double>(maxLat.value);
    }
    if (minLon.present) {
      map['min_lon'] = Variable<double>(minLon.value);
    }
    if (maxLon.present) {
      map['max_lon'] = Variable<double>(maxLon.value);
    }
    if (totalTiles.present) {
      map['total_tiles'] = Variable<int>(totalTiles.value);
    }
    if (estimatedSizeBytes.present) {
      map['estimated_size_bytes'] = Variable<int>(estimatedSizeBytes.value);
    }
    if (downloadStatus.present) {
      map['download_status'] = Variable<int>(downloadStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfflineRegionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('minLat: $minLat, ')
          ..write('maxLat: $maxLat, ')
          ..write('minLon: $minLon, ')
          ..write('maxLon: $maxLon, ')
          ..write('totalTiles: $totalTiles, ')
          ..write('estimatedSizeBytes: $estimatedSizeBytes, ')
          ..write('downloadStatus: $downloadStatus, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $RegionTileRefsTable extends RegionTileRefs
    with TableInfo<$RegionTileRefsTable, RegionTileRef> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegionTileRefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _regionIdMeta = const VerificationMeta(
    'regionId',
  );
  @override
  late final GeneratedColumn<int> regionId = GeneratedColumn<int>(
    'region_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES offline_regions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _zoomMeta = const VerificationMeta('zoom');
  @override
  late final GeneratedColumn<int> zoom = GeneratedColumn<int>(
    'zoom',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<int> x = GeneratedColumn<int>(
    'x',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<int> y = GeneratedColumn<int>(
    'y',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [regionId, zoom, x, y, sourceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'region_tile_refs';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegionTileRef> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('region_id')) {
      context.handle(
        _regionIdMeta,
        regionId.isAcceptableOrUnknown(data['region_id']!, _regionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_regionIdMeta);
    }
    if (data.containsKey('zoom')) {
      context.handle(
        _zoomMeta,
        zoom.isAcceptableOrUnknown(data['zoom']!, _zoomMeta),
      );
    } else if (isInserting) {
      context.missing(_zoomMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {regionId, zoom, x, y, sourceId};
  @override
  RegionTileRef map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegionTileRef(
      regionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}region_id'],
      )!,
      zoom: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}zoom'],
      )!,
      x: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}x'],
      )!,
      y: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}y'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      )!,
    );
  }

  @override
  $RegionTileRefsTable createAlias(String alias) {
    return $RegionTileRefsTable(attachedDatabase, alias);
  }
}

class RegionTileRef extends DataClass implements Insertable<RegionTileRef> {
  final int regionId;
  final int zoom;
  final int x;
  final int y;
  final String sourceId;
  const RegionTileRef({
    required this.regionId,
    required this.zoom,
    required this.x,
    required this.y,
    required this.sourceId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['region_id'] = Variable<int>(regionId);
    map['zoom'] = Variable<int>(zoom);
    map['x'] = Variable<int>(x);
    map['y'] = Variable<int>(y);
    map['source_id'] = Variable<String>(sourceId);
    return map;
  }

  RegionTileRefsCompanion toCompanion(bool nullToAbsent) {
    return RegionTileRefsCompanion(
      regionId: Value(regionId),
      zoom: Value(zoom),
      x: Value(x),
      y: Value(y),
      sourceId: Value(sourceId),
    );
  }

  factory RegionTileRef.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegionTileRef(
      regionId: serializer.fromJson<int>(json['regionId']),
      zoom: serializer.fromJson<int>(json['zoom']),
      x: serializer.fromJson<int>(json['x']),
      y: serializer.fromJson<int>(json['y']),
      sourceId: serializer.fromJson<String>(json['sourceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'regionId': serializer.toJson<int>(regionId),
      'zoom': serializer.toJson<int>(zoom),
      'x': serializer.toJson<int>(x),
      'y': serializer.toJson<int>(y),
      'sourceId': serializer.toJson<String>(sourceId),
    };
  }

  RegionTileRef copyWith({
    int? regionId,
    int? zoom,
    int? x,
    int? y,
    String? sourceId,
  }) => RegionTileRef(
    regionId: regionId ?? this.regionId,
    zoom: zoom ?? this.zoom,
    x: x ?? this.x,
    y: y ?? this.y,
    sourceId: sourceId ?? this.sourceId,
  );
  RegionTileRef copyWithCompanion(RegionTileRefsCompanion data) {
    return RegionTileRef(
      regionId: data.regionId.present ? data.regionId.value : this.regionId,
      zoom: data.zoom.present ? data.zoom.value : this.zoom,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegionTileRef(')
          ..write('regionId: $regionId, ')
          ..write('zoom: $zoom, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('sourceId: $sourceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(regionId, zoom, x, y, sourceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegionTileRef &&
          other.regionId == this.regionId &&
          other.zoom == this.zoom &&
          other.x == this.x &&
          other.y == this.y &&
          other.sourceId == this.sourceId);
}

class RegionTileRefsCompanion extends UpdateCompanion<RegionTileRef> {
  final Value<int> regionId;
  final Value<int> zoom;
  final Value<int> x;
  final Value<int> y;
  final Value<String> sourceId;
  final Value<int> rowid;
  const RegionTileRefsCompanion({
    this.regionId = const Value.absent(),
    this.zoom = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RegionTileRefsCompanion.insert({
    required int regionId,
    required int zoom,
    required int x,
    required int y,
    required String sourceId,
    this.rowid = const Value.absent(),
  }) : regionId = Value(regionId),
       zoom = Value(zoom),
       x = Value(x),
       y = Value(y),
       sourceId = Value(sourceId);
  static Insertable<RegionTileRef> custom({
    Expression<int>? regionId,
    Expression<int>? zoom,
    Expression<int>? x,
    Expression<int>? y,
    Expression<String>? sourceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (regionId != null) 'region_id': regionId,
      if (zoom != null) 'zoom': zoom,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (sourceId != null) 'source_id': sourceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RegionTileRefsCompanion copyWith({
    Value<int>? regionId,
    Value<int>? zoom,
    Value<int>? x,
    Value<int>? y,
    Value<String>? sourceId,
    Value<int>? rowid,
  }) {
    return RegionTileRefsCompanion(
      regionId: regionId ?? this.regionId,
      zoom: zoom ?? this.zoom,
      x: x ?? this.x,
      y: y ?? this.y,
      sourceId: sourceId ?? this.sourceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (regionId.present) {
      map['region_id'] = Variable<int>(regionId.value);
    }
    if (zoom.present) {
      map['zoom'] = Variable<int>(zoom.value);
    }
    if (x.present) {
      map['x'] = Variable<int>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<int>(y.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegionTileRefsCompanion(')
          ..write('regionId: $regionId, ')
          ..write('zoom: $zoom, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('sourceId: $sourceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoutesTable extends Routes with TableInfo<$RoutesTable, DbRoute> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoutesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _totalDistanceMetersMeta =
      const VerificationMeta('totalDistanceMeters');
  @override
  late final GeneratedColumn<double> totalDistanceMeters =
      GeneratedColumn<double>(
        'total_distance_meters',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    updatedAt,
    isActive,
    totalDistanceMeters,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'routes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbRoute> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('total_distance_meters')) {
      context.handle(
        _totalDistanceMetersMeta,
        totalDistanceMeters.isAcceptableOrUnknown(
          data['total_distance_meters']!,
          _totalDistanceMetersMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbRoute map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbRoute(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      totalDistanceMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_distance_meters'],
      )!,
    );
  }

  @override
  $RoutesTable createAlias(String alias) {
    return $RoutesTable(attachedDatabase, alias);
  }
}

class DbRoute extends DataClass implements Insertable<DbRoute> {
  final int id;

  /// User-friendly name of the route (e.g., "Helsinki to Tallinn").
  final String name;

  /// When this route was created (UTC).
  final DateTime createdAt;

  /// Last modification time (UTC).
  final DateTime updatedAt;

  /// Whether this is the currently active navigation route.
  /// Only one route should be active at a time (enforced by logic).
  final bool isActive;

  /// Total calculates distance in meters (cached for performance).
  final double totalDistanceMeters;
  const DbRoute({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
    required this.totalDistanceMeters,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_active'] = Variable<bool>(isActive);
    map['total_distance_meters'] = Variable<double>(totalDistanceMeters);
    return map;
  }

  RoutesCompanion toCompanion(bool nullToAbsent) {
    return RoutesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isActive: Value(isActive),
      totalDistanceMeters: Value(totalDistanceMeters),
    );
  }

  factory DbRoute.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbRoute(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      totalDistanceMeters: serializer.fromJson<double>(
        json['totalDistanceMeters'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isActive': serializer.toJson<bool>(isActive),
      'totalDistanceMeters': serializer.toJson<double>(totalDistanceMeters),
    };
  }

  DbRoute copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    double? totalDistanceMeters,
  }) => DbRoute(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    isActive: isActive ?? this.isActive,
    totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
  );
  DbRoute copyWithCompanion(RoutesCompanion data) {
    return DbRoute(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      totalDistanceMeters: data.totalDistanceMeters.present
          ? data.totalDistanceMeters.value
          : this.totalDistanceMeters,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbRoute(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('totalDistanceMeters: $totalDistanceMeters')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    createdAt,
    updatedAt,
    isActive,
    totalDistanceMeters,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbRoute &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isActive == this.isActive &&
          other.totalDistanceMeters == this.totalDistanceMeters);
}

class RoutesCompanion extends UpdateCompanion<DbRoute> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isActive;
  final Value<double> totalDistanceMeters;
  const RoutesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.totalDistanceMeters = const Value.absent(),
  });
  RoutesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.totalDistanceMeters = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DbRoute> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isActive,
    Expression<double>? totalDistanceMeters,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isActive != null) 'is_active': isActive,
      if (totalDistanceMeters != null)
        'total_distance_meters': totalDistanceMeters,
    });
  }

  RoutesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? isActive,
    Value<double>? totalDistanceMeters,
  }) {
    return RoutesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (totalDistanceMeters.present) {
      map['total_distance_meters'] = Variable<double>(
        totalDistanceMeters.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoutesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('totalDistanceMeters: $totalDistanceMeters')
          ..write(')'))
        .toString();
  }
}

class $WaypointsTable extends Waypoints
    with TableInfo<$WaypointsTable, Waypoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaypointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _routeIdMeta = const VerificationMeta(
    'routeId',
  );
  @override
  late final GeneratedColumn<int> routeId = GeneratedColumn<int>(
    'route_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES routes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    routeId,
    lat,
    lon,
    orderIndex,
    label,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'waypoints';
  @override
  VerificationContext validateIntegrity(
    Insertable<Waypoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('route_id')) {
      context.handle(
        _routeIdMeta,
        routeId.isAcceptableOrUnknown(data['route_id']!, _routeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_routeIdMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Waypoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Waypoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      routeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}route_id'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
    );
  }

  @override
  $WaypointsTable createAlias(String alias) {
    return $WaypointsTable(attachedDatabase, alias);
  }
}

class Waypoint extends DataClass implements Insertable<Waypoint> {
  final int id;

  /// Foreign key to the parent [Route].
  /// Cascade delete ensures waypoints are removed when route is deleted.
  final int routeId;

  /// Latitude in decimal degrees (WGS84).
  final double lat;

  /// Longitude in decimal degrees (WGS84).
  final double lon;

  /// Zero-based index defining the sequence in the route.
  final int orderIndex;

  /// Optional label for this specific point (e.g., "Turn point", "Harbor").
  final String? label;
  const Waypoint({
    required this.id,
    required this.routeId,
    required this.lat,
    required this.lon,
    required this.orderIndex,
    this.label,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['route_id'] = Variable<int>(routeId);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    return map;
  }

  WaypointsCompanion toCompanion(bool nullToAbsent) {
    return WaypointsCompanion(
      id: Value(id),
      routeId: Value(routeId),
      lat: Value(lat),
      lon: Value(lon),
      orderIndex: Value(orderIndex),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
    );
  }

  factory Waypoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Waypoint(
      id: serializer.fromJson<int>(json['id']),
      routeId: serializer.fromJson<int>(json['routeId']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      label: serializer.fromJson<String?>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'routeId': serializer.toJson<int>(routeId),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'label': serializer.toJson<String?>(label),
    };
  }

  Waypoint copyWith({
    int? id,
    int? routeId,
    double? lat,
    double? lon,
    int? orderIndex,
    Value<String?> label = const Value.absent(),
  }) => Waypoint(
    id: id ?? this.id,
    routeId: routeId ?? this.routeId,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    orderIndex: orderIndex ?? this.orderIndex,
    label: label.present ? label.value : this.label,
  );
  Waypoint copyWithCompanion(WaypointsCompanion data) {
    return Waypoint(
      id: data.id.present ? data.id.value : this.id,
      routeId: data.routeId.present ? data.routeId.value : this.routeId,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      label: data.label.present ? data.label.value : this.label,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Waypoint(')
          ..write('id: $id, ')
          ..write('routeId: $routeId, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, routeId, lat, lon, orderIndex, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Waypoint &&
          other.id == this.id &&
          other.routeId == this.routeId &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.orderIndex == this.orderIndex &&
          other.label == this.label);
}

class WaypointsCompanion extends UpdateCompanion<Waypoint> {
  final Value<int> id;
  final Value<int> routeId;
  final Value<double> lat;
  final Value<double> lon;
  final Value<int> orderIndex;
  final Value<String?> label;
  const WaypointsCompanion({
    this.id = const Value.absent(),
    this.routeId = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.label = const Value.absent(),
  });
  WaypointsCompanion.insert({
    this.id = const Value.absent(),
    required int routeId,
    required double lat,
    required double lon,
    required int orderIndex,
    this.label = const Value.absent(),
  }) : routeId = Value(routeId),
       lat = Value(lat),
       lon = Value(lon),
       orderIndex = Value(orderIndex);
  static Insertable<Waypoint> custom({
    Expression<int>? id,
    Expression<int>? routeId,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<int>? orderIndex,
    Expression<String>? label,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (routeId != null) 'route_id': routeId,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (orderIndex != null) 'order_index': orderIndex,
      if (label != null) 'label': label,
    });
  }

  WaypointsCompanion copyWith({
    Value<int>? id,
    Value<int>? routeId,
    Value<double>? lat,
    Value<double>? lon,
    Value<int>? orderIndex,
    Value<String?>? label,
  }) {
    return WaypointsCompanion(
      id: id ?? this.id,
      routeId: routeId ?? this.routeId,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      orderIndex: orderIndex ?? this.orderIndex,
      label: label ?? this.label,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (routeId.present) {
      map['route_id'] = Variable<int>(routeId.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaypointsCompanion(')
          ..write('id: $id, ')
          ..write('routeId: $routeId, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }
}

class $VesselProfilesTable extends VesselProfiles
    with TableInfo<$VesselProfilesTable, VesselProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VesselProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VesselType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VesselType>($VesselProfilesTable.$convertertype);
  static const VerificationMeta _maxWindLimitMeta = const VerificationMeta(
    'maxWindLimit',
  );
  @override
  late final GeneratedColumn<double> maxWindLimit = GeneratedColumn<double>(
    'max_wind_limit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxWaveLimitMeta = const VerificationMeta(
    'maxWaveLimit',
  );
  @override
  late final GeneratedColumn<double> maxWaveLimit = GeneratedColumn<double>(
    'max_wave_limit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _draftDepthMeta = const VerificationMeta(
    'draftDepth',
  );
  @override
  late final GeneratedColumn<double> draftDepth = GeneratedColumn<double>(
    'draft_depth',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cruisingSpeedKmhMeta = const VerificationMeta(
    'cruisingSpeedKmh',
  );
  @override
  late final GeneratedColumn<double> cruisingSpeedKmh = GeneratedColumn<double>(
    'cruising_speed_kmh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
    'is_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hinCodeMeta = const VerificationMeta(
    'hinCode',
  );
  @override
  late final GeneratedColumn<String> hinCode = GeneratedColumn<String>(
    'hin_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _engineManufacturerMeta =
      const VerificationMeta('engineManufacturer');
  @override
  late final GeneratedColumn<String> engineManufacturer =
      GeneratedColumn<String>(
        'engine_manufacturer',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _engineModelMeta = const VerificationMeta(
    'engineModel',
  );
  @override
  late final GeneratedColumn<String> engineModel = GeneratedColumn<String>(
    'engine_model',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    maxWindLimit,
    maxWaveLimit,
    draftDepth,
    cruisingSpeedKmh,
    isSelected,
    hinCode,
    engineManufacturer,
    engineModel,
    fuelType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vessel_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<VesselProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('max_wind_limit')) {
      context.handle(
        _maxWindLimitMeta,
        maxWindLimit.isAcceptableOrUnknown(
          data['max_wind_limit']!,
          _maxWindLimitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxWindLimitMeta);
    }
    if (data.containsKey('max_wave_limit')) {
      context.handle(
        _maxWaveLimitMeta,
        maxWaveLimit.isAcceptableOrUnknown(
          data['max_wave_limit']!,
          _maxWaveLimitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxWaveLimitMeta);
    }
    if (data.containsKey('draft_depth')) {
      context.handle(
        _draftDepthMeta,
        draftDepth.isAcceptableOrUnknown(data['draft_depth']!, _draftDepthMeta),
      );
    }
    if (data.containsKey('cruising_speed_kmh')) {
      context.handle(
        _cruisingSpeedKmhMeta,
        cruisingSpeedKmh.isAcceptableOrUnknown(
          data['cruising_speed_kmh']!,
          _cruisingSpeedKmhMeta,
        ),
      );
    }
    if (data.containsKey('is_selected')) {
      context.handle(
        _isSelectedMeta,
        isSelected.isAcceptableOrUnknown(data['is_selected']!, _isSelectedMeta),
      );
    }
    if (data.containsKey('hin_code')) {
      context.handle(
        _hinCodeMeta,
        hinCode.isAcceptableOrUnknown(data['hin_code']!, _hinCodeMeta),
      );
    }
    if (data.containsKey('engine_manufacturer')) {
      context.handle(
        _engineManufacturerMeta,
        engineManufacturer.isAcceptableOrUnknown(
          data['engine_manufacturer']!,
          _engineManufacturerMeta,
        ),
      );
    }
    if (data.containsKey('engine_model')) {
      context.handle(
        _engineModelMeta,
        engineModel.isAcceptableOrUnknown(
          data['engine_model']!,
          _engineModelMeta,
        ),
      );
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VesselProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VesselProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: $VesselProfilesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      maxWindLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_wind_limit'],
      )!,
      maxWaveLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_wave_limit'],
      )!,
      draftDepth: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}draft_depth'],
      ),
      cruisingSpeedKmh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cruising_speed_kmh'],
      )!,
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_selected'],
      )!,
      hinCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hin_code'],
      ),
      engineManufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine_manufacturer'],
      ),
      engineModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine_model'],
      ),
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      ),
    );
  }

  @override
  $VesselProfilesTable createAlias(String alias) {
    return $VesselProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<VesselType, String, String> $convertertype =
      const EnumNameConverter<VesselType>(VesselType.values);
}

class VesselProfile extends DataClass implements Insertable<VesselProfile> {
  final int id;

  /// User's name for the boat (e.g., "My Buster").
  final String name;

  /// The hull type which dictates default physical limitations.
  final VesselType type;

  /// Maximum safe wind speed in m/s.
  /// Anything above this triggers critical "Seek Shelter" alerts.
  final double maxWindLimit;

  /// Maximum safe significant wave height in meters.
  final double maxWaveLimit;

  /// Vertical clearance in meters (for under-bridge routing).
  final double? draftDepth;

  /// Recommended cruising speed in KM/h.
  /// Used for ETA calculations in routing.
  final double cruisingSpeedKmh;

  /// Is this the currently selected profile?
  final bool isSelected;

  /// Hull Identification Number (HIN / CIN / VIN code).
  final String? hinCode;

  /// Engine manufacturer (e.g. Volvo Penta, Yanmar, Yamaha, Mercury, Torqeedo).
  final String? engineManufacturer;

  /// Engine model (e.g. D4-300, F150, 3YM30).
  final String? engineModel;

  /// Fuel type (e.g. Bensiini, Diesel, Sähkö).
  final String? fuelType;
  const VesselProfile({
    required this.id,
    required this.name,
    required this.type,
    required this.maxWindLimit,
    required this.maxWaveLimit,
    this.draftDepth,
    required this.cruisingSpeedKmh,
    required this.isSelected,
    this.hinCode,
    this.engineManufacturer,
    this.engineModel,
    this.fuelType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['type'] = Variable<String>(
        $VesselProfilesTable.$convertertype.toSql(type),
      );
    }
    map['max_wind_limit'] = Variable<double>(maxWindLimit);
    map['max_wave_limit'] = Variable<double>(maxWaveLimit);
    if (!nullToAbsent || draftDepth != null) {
      map['draft_depth'] = Variable<double>(draftDepth);
    }
    map['cruising_speed_kmh'] = Variable<double>(cruisingSpeedKmh);
    map['is_selected'] = Variable<bool>(isSelected);
    if (!nullToAbsent || hinCode != null) {
      map['hin_code'] = Variable<String>(hinCode);
    }
    if (!nullToAbsent || engineManufacturer != null) {
      map['engine_manufacturer'] = Variable<String>(engineManufacturer);
    }
    if (!nullToAbsent || engineModel != null) {
      map['engine_model'] = Variable<String>(engineModel);
    }
    if (!nullToAbsent || fuelType != null) {
      map['fuel_type'] = Variable<String>(fuelType);
    }
    return map;
  }

  VesselProfilesCompanion toCompanion(bool nullToAbsent) {
    return VesselProfilesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      maxWindLimit: Value(maxWindLimit),
      maxWaveLimit: Value(maxWaveLimit),
      draftDepth: draftDepth == null && nullToAbsent
          ? const Value.absent()
          : Value(draftDepth),
      cruisingSpeedKmh: Value(cruisingSpeedKmh),
      isSelected: Value(isSelected),
      hinCode: hinCode == null && nullToAbsent
          ? const Value.absent()
          : Value(hinCode),
      engineManufacturer: engineManufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(engineManufacturer),
      engineModel: engineModel == null && nullToAbsent
          ? const Value.absent()
          : Value(engineModel),
      fuelType: fuelType == null && nullToAbsent
          ? const Value.absent()
          : Value(fuelType),
    );
  }

  factory VesselProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VesselProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: $VesselProfilesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      maxWindLimit: serializer.fromJson<double>(json['maxWindLimit']),
      maxWaveLimit: serializer.fromJson<double>(json['maxWaveLimit']),
      draftDepth: serializer.fromJson<double?>(json['draftDepth']),
      cruisingSpeedKmh: serializer.fromJson<double>(json['cruisingSpeedKmh']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      hinCode: serializer.fromJson<String?>(json['hinCode']),
      engineManufacturer: serializer.fromJson<String?>(
        json['engineManufacturer'],
      ),
      engineModel: serializer.fromJson<String?>(json['engineModel']),
      fuelType: serializer.fromJson<String?>(json['fuelType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(
        $VesselProfilesTable.$convertertype.toJson(type),
      ),
      'maxWindLimit': serializer.toJson<double>(maxWindLimit),
      'maxWaveLimit': serializer.toJson<double>(maxWaveLimit),
      'draftDepth': serializer.toJson<double?>(draftDepth),
      'cruisingSpeedKmh': serializer.toJson<double>(cruisingSpeedKmh),
      'isSelected': serializer.toJson<bool>(isSelected),
      'hinCode': serializer.toJson<String?>(hinCode),
      'engineManufacturer': serializer.toJson<String?>(engineManufacturer),
      'engineModel': serializer.toJson<String?>(engineModel),
      'fuelType': serializer.toJson<String?>(fuelType),
    };
  }

  VesselProfile copyWith({
    int? id,
    String? name,
    VesselType? type,
    double? maxWindLimit,
    double? maxWaveLimit,
    Value<double?> draftDepth = const Value.absent(),
    double? cruisingSpeedKmh,
    bool? isSelected,
    Value<String?> hinCode = const Value.absent(),
    Value<String?> engineManufacturer = const Value.absent(),
    Value<String?> engineModel = const Value.absent(),
    Value<String?> fuelType = const Value.absent(),
  }) => VesselProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    maxWindLimit: maxWindLimit ?? this.maxWindLimit,
    maxWaveLimit: maxWaveLimit ?? this.maxWaveLimit,
    draftDepth: draftDepth.present ? draftDepth.value : this.draftDepth,
    cruisingSpeedKmh: cruisingSpeedKmh ?? this.cruisingSpeedKmh,
    isSelected: isSelected ?? this.isSelected,
    hinCode: hinCode.present ? hinCode.value : this.hinCode,
    engineManufacturer: engineManufacturer.present
        ? engineManufacturer.value
        : this.engineManufacturer,
    engineModel: engineModel.present ? engineModel.value : this.engineModel,
    fuelType: fuelType.present ? fuelType.value : this.fuelType,
  );
  VesselProfile copyWithCompanion(VesselProfilesCompanion data) {
    return VesselProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      maxWindLimit: data.maxWindLimit.present
          ? data.maxWindLimit.value
          : this.maxWindLimit,
      maxWaveLimit: data.maxWaveLimit.present
          ? data.maxWaveLimit.value
          : this.maxWaveLimit,
      draftDepth: data.draftDepth.present
          ? data.draftDepth.value
          : this.draftDepth,
      cruisingSpeedKmh: data.cruisingSpeedKmh.present
          ? data.cruisingSpeedKmh.value
          : this.cruisingSpeedKmh,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
      hinCode: data.hinCode.present ? data.hinCode.value : this.hinCode,
      engineManufacturer: data.engineManufacturer.present
          ? data.engineManufacturer.value
          : this.engineManufacturer,
      engineModel: data.engineModel.present
          ? data.engineModel.value
          : this.engineModel,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VesselProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('maxWindLimit: $maxWindLimit, ')
          ..write('maxWaveLimit: $maxWaveLimit, ')
          ..write('draftDepth: $draftDepth, ')
          ..write('cruisingSpeedKmh: $cruisingSpeedKmh, ')
          ..write('isSelected: $isSelected, ')
          ..write('hinCode: $hinCode, ')
          ..write('engineManufacturer: $engineManufacturer, ')
          ..write('engineModel: $engineModel, ')
          ..write('fuelType: $fuelType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    maxWindLimit,
    maxWaveLimit,
    draftDepth,
    cruisingSpeedKmh,
    isSelected,
    hinCode,
    engineManufacturer,
    engineModel,
    fuelType,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VesselProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.maxWindLimit == this.maxWindLimit &&
          other.maxWaveLimit == this.maxWaveLimit &&
          other.draftDepth == this.draftDepth &&
          other.cruisingSpeedKmh == this.cruisingSpeedKmh &&
          other.isSelected == this.isSelected &&
          other.hinCode == this.hinCode &&
          other.engineManufacturer == this.engineManufacturer &&
          other.engineModel == this.engineModel &&
          other.fuelType == this.fuelType);
}

class VesselProfilesCompanion extends UpdateCompanion<VesselProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<VesselType> type;
  final Value<double> maxWindLimit;
  final Value<double> maxWaveLimit;
  final Value<double?> draftDepth;
  final Value<double> cruisingSpeedKmh;
  final Value<bool> isSelected;
  final Value<String?> hinCode;
  final Value<String?> engineManufacturer;
  final Value<String?> engineModel;
  final Value<String?> fuelType;
  const VesselProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.maxWindLimit = const Value.absent(),
    this.maxWaveLimit = const Value.absent(),
    this.draftDepth = const Value.absent(),
    this.cruisingSpeedKmh = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.hinCode = const Value.absent(),
    this.engineManufacturer = const Value.absent(),
    this.engineModel = const Value.absent(),
    this.fuelType = const Value.absent(),
  });
  VesselProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required VesselType type,
    required double maxWindLimit,
    required double maxWaveLimit,
    this.draftDepth = const Value.absent(),
    this.cruisingSpeedKmh = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.hinCode = const Value.absent(),
    this.engineManufacturer = const Value.absent(),
    this.engineModel = const Value.absent(),
    this.fuelType = const Value.absent(),
  }) : name = Value(name),
       type = Value(type),
       maxWindLimit = Value(maxWindLimit),
       maxWaveLimit = Value(maxWaveLimit);
  static Insertable<VesselProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<double>? maxWindLimit,
    Expression<double>? maxWaveLimit,
    Expression<double>? draftDepth,
    Expression<double>? cruisingSpeedKmh,
    Expression<bool>? isSelected,
    Expression<String>? hinCode,
    Expression<String>? engineManufacturer,
    Expression<String>? engineModel,
    Expression<String>? fuelType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (maxWindLimit != null) 'max_wind_limit': maxWindLimit,
      if (maxWaveLimit != null) 'max_wave_limit': maxWaveLimit,
      if (draftDepth != null) 'draft_depth': draftDepth,
      if (cruisingSpeedKmh != null) 'cruising_speed_kmh': cruisingSpeedKmh,
      if (isSelected != null) 'is_selected': isSelected,
      if (hinCode != null) 'hin_code': hinCode,
      if (engineManufacturer != null) 'engine_manufacturer': engineManufacturer,
      if (engineModel != null) 'engine_model': engineModel,
      if (fuelType != null) 'fuel_type': fuelType,
    });
  }

  VesselProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<VesselType>? type,
    Value<double>? maxWindLimit,
    Value<double>? maxWaveLimit,
    Value<double?>? draftDepth,
    Value<double>? cruisingSpeedKmh,
    Value<bool>? isSelected,
    Value<String?>? hinCode,
    Value<String?>? engineManufacturer,
    Value<String?>? engineModel,
    Value<String?>? fuelType,
  }) {
    return VesselProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      maxWindLimit: maxWindLimit ?? this.maxWindLimit,
      maxWaveLimit: maxWaveLimit ?? this.maxWaveLimit,
      draftDepth: draftDepth ?? this.draftDepth,
      cruisingSpeedKmh: cruisingSpeedKmh ?? this.cruisingSpeedKmh,
      isSelected: isSelected ?? this.isSelected,
      hinCode: hinCode ?? this.hinCode,
      engineManufacturer: engineManufacturer ?? this.engineManufacturer,
      engineModel: engineModel ?? this.engineModel,
      fuelType: fuelType ?? this.fuelType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $VesselProfilesTable.$convertertype.toSql(type.value),
      );
    }
    if (maxWindLimit.present) {
      map['max_wind_limit'] = Variable<double>(maxWindLimit.value);
    }
    if (maxWaveLimit.present) {
      map['max_wave_limit'] = Variable<double>(maxWaveLimit.value);
    }
    if (draftDepth.present) {
      map['draft_depth'] = Variable<double>(draftDepth.value);
    }
    if (cruisingSpeedKmh.present) {
      map['cruising_speed_kmh'] = Variable<double>(cruisingSpeedKmh.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (hinCode.present) {
      map['hin_code'] = Variable<String>(hinCode.value);
    }
    if (engineManufacturer.present) {
      map['engine_manufacturer'] = Variable<String>(engineManufacturer.value);
    }
    if (engineModel.present) {
      map['engine_model'] = Variable<String>(engineModel.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VesselProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('maxWindLimit: $maxWindLimit, ')
          ..write('maxWaveLimit: $maxWaveLimit, ')
          ..write('draftDepth: $draftDepth, ')
          ..write('cruisingSpeedKmh: $cruisingSpeedKmh, ')
          ..write('isSelected: $isSelected, ')
          ..write('hinCode: $hinCode, ')
          ..write('engineManufacturer: $engineManufacturer, ')
          ..write('engineModel: $engineModel, ')
          ..write('fuelType: $fuelType')
          ..write(')'))
        .toString();
  }
}

class $SkipperSettingsTableTable extends SkipperSettingsTable
    with TableInfo<$SkipperSettingsTableTable, SkipperSettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkipperSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isAIEnabledMeta = const VerificationMeta(
    'isAIEnabled',
  );
  @override
  late final GeneratedColumn<bool> isAIEnabled = GeneratedColumn<bool>(
    'is_a_i_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_a_i_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _windYellowMsMeta = const VerificationMeta(
    'windYellowMs',
  );
  @override
  late final GeneratedColumn<double> windYellowMs = GeneratedColumn<double>(
    'wind_yellow_ms',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _windOrangeMsMeta = const VerificationMeta(
    'windOrangeMs',
  );
  @override
  late final GeneratedColumn<double> windOrangeMs = GeneratedColumn<double>(
    'wind_orange_ms',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(14),
  );
  static const VerificationMeta _windRedMsMeta = const VerificationMeta(
    'windRedMs',
  );
  @override
  late final GeneratedColumn<double> windRedMs = GeneratedColumn<double>(
    'wind_red_ms',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(17),
  );
  static const VerificationMeta _waveYellowMMeta = const VerificationMeta(
    'waveYellowM',
  );
  @override
  late final GeneratedColumn<double> waveYellowM = GeneratedColumn<double>(
    'wave_yellow_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _waveOrangeMMeta = const VerificationMeta(
    'waveOrangeM',
  );
  @override
  late final GeneratedColumn<double> waveOrangeM = GeneratedColumn<double>(
    'wave_orange_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.5),
  );
  static const VerificationMeta _waveRedMMeta = const VerificationMeta(
    'waveRedM',
  );
  @override
  late final GeneratedColumn<double> waveRedM = GeneratedColumn<double>(
    'wave_red_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _pressureDropThresholdHpaMeta =
      const VerificationMeta('pressureDropThresholdHpa');
  @override
  late final GeneratedColumn<double> pressureDropThresholdHpa =
      GeneratedColumn<double>(
        'pressure_drop_threshold_hpa',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(2),
      );
  static const VerificationMeta _forecastWindowHoursMeta =
      const VerificationMeta('forecastWindowHours');
  @override
  late final GeneratedColumn<int> forecastWindowHours = GeneratedColumn<int>(
    'forecast_window_hours',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _hasAcknowledgedAISafetyMeta =
      const VerificationMeta('hasAcknowledgedAISafety');
  @override
  late final GeneratedColumn<bool> hasAcknowledgedAISafety =
      GeneratedColumn<bool>(
        'has_acknowledged_a_i_safety',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_acknowledged_a_i_safety" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _aiApiKeyMeta = const VerificationMeta(
    'aiApiKey',
  );
  @override
  late final GeneratedColumn<String> aiApiKey = GeneratedColumn<String>(
    'ai_api_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _aiModelIdMeta = const VerificationMeta(
    'aiModelId',
  );
  @override
  late final GeneratedColumn<String> aiModelId = GeneratedColumn<String>(
    'ai_model_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('meta-llama/llama-3.3-70b-instruct:free'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    isAIEnabled,
    windYellowMs,
    windOrangeMs,
    windRedMs,
    waveYellowM,
    waveOrangeM,
    waveRedM,
    pressureDropThresholdHpa,
    forecastWindowHours,
    hasAcknowledgedAISafety,
    aiApiKey,
    aiModelId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skipper_settings_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkipperSettingsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_a_i_enabled')) {
      context.handle(
        _isAIEnabledMeta,
        isAIEnabled.isAcceptableOrUnknown(
          data['is_a_i_enabled']!,
          _isAIEnabledMeta,
        ),
      );
    }
    if (data.containsKey('wind_yellow_ms')) {
      context.handle(
        _windYellowMsMeta,
        windYellowMs.isAcceptableOrUnknown(
          data['wind_yellow_ms']!,
          _windYellowMsMeta,
        ),
      );
    }
    if (data.containsKey('wind_orange_ms')) {
      context.handle(
        _windOrangeMsMeta,
        windOrangeMs.isAcceptableOrUnknown(
          data['wind_orange_ms']!,
          _windOrangeMsMeta,
        ),
      );
    }
    if (data.containsKey('wind_red_ms')) {
      context.handle(
        _windRedMsMeta,
        windRedMs.isAcceptableOrUnknown(data['wind_red_ms']!, _windRedMsMeta),
      );
    }
    if (data.containsKey('wave_yellow_m')) {
      context.handle(
        _waveYellowMMeta,
        waveYellowM.isAcceptableOrUnknown(
          data['wave_yellow_m']!,
          _waveYellowMMeta,
        ),
      );
    }
    if (data.containsKey('wave_orange_m')) {
      context.handle(
        _waveOrangeMMeta,
        waveOrangeM.isAcceptableOrUnknown(
          data['wave_orange_m']!,
          _waveOrangeMMeta,
        ),
      );
    }
    if (data.containsKey('wave_red_m')) {
      context.handle(
        _waveRedMMeta,
        waveRedM.isAcceptableOrUnknown(data['wave_red_m']!, _waveRedMMeta),
      );
    }
    if (data.containsKey('pressure_drop_threshold_hpa')) {
      context.handle(
        _pressureDropThresholdHpaMeta,
        pressureDropThresholdHpa.isAcceptableOrUnknown(
          data['pressure_drop_threshold_hpa']!,
          _pressureDropThresholdHpaMeta,
        ),
      );
    }
    if (data.containsKey('forecast_window_hours')) {
      context.handle(
        _forecastWindowHoursMeta,
        forecastWindowHours.isAcceptableOrUnknown(
          data['forecast_window_hours']!,
          _forecastWindowHoursMeta,
        ),
      );
    }
    if (data.containsKey('has_acknowledged_a_i_safety')) {
      context.handle(
        _hasAcknowledgedAISafetyMeta,
        hasAcknowledgedAISafety.isAcceptableOrUnknown(
          data['has_acknowledged_a_i_safety']!,
          _hasAcknowledgedAISafetyMeta,
        ),
      );
    }
    if (data.containsKey('ai_api_key')) {
      context.handle(
        _aiApiKeyMeta,
        aiApiKey.isAcceptableOrUnknown(data['ai_api_key']!, _aiApiKeyMeta),
      );
    }
    if (data.containsKey('ai_model_id')) {
      context.handle(
        _aiModelIdMeta,
        aiModelId.isAcceptableOrUnknown(data['ai_model_id']!, _aiModelIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SkipperSettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkipperSettingsEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isAIEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_a_i_enabled'],
      )!,
      windYellowMs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_yellow_ms'],
      )!,
      windOrangeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_orange_ms'],
      )!,
      windRedMs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wind_red_ms'],
      )!,
      waveYellowM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wave_yellow_m'],
      )!,
      waveOrangeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wave_orange_m'],
      )!,
      waveRedM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wave_red_m'],
      )!,
      pressureDropThresholdHpa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure_drop_threshold_hpa'],
      )!,
      forecastWindowHours: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}forecast_window_hours'],
      )!,
      hasAcknowledgedAISafety: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_acknowledged_a_i_safety'],
      )!,
      aiApiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_api_key'],
      ),
      aiModelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ai_model_id'],
      )!,
    );
  }

  @override
  $SkipperSettingsTableTable createAlias(String alias) {
    return $SkipperSettingsTableTable(attachedDatabase, alias);
  }
}

class SkipperSettingsEntry extends DataClass
    implements Insertable<SkipperSettingsEntry> {
  final int id;
  final bool isAIEnabled;
  final double windYellowMs;
  final double windOrangeMs;
  final double windRedMs;
  final double waveYellowM;
  final double waveOrangeM;
  final double waveRedM;
  final double pressureDropThresholdHpa;
  final int forecastWindowHours;
  final bool hasAcknowledgedAISafety;
  final String? aiApiKey;
  final String aiModelId;
  const SkipperSettingsEntry({
    required this.id,
    required this.isAIEnabled,
    required this.windYellowMs,
    required this.windOrangeMs,
    required this.windRedMs,
    required this.waveYellowM,
    required this.waveOrangeM,
    required this.waveRedM,
    required this.pressureDropThresholdHpa,
    required this.forecastWindowHours,
    required this.hasAcknowledgedAISafety,
    this.aiApiKey,
    required this.aiModelId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_a_i_enabled'] = Variable<bool>(isAIEnabled);
    map['wind_yellow_ms'] = Variable<double>(windYellowMs);
    map['wind_orange_ms'] = Variable<double>(windOrangeMs);
    map['wind_red_ms'] = Variable<double>(windRedMs);
    map['wave_yellow_m'] = Variable<double>(waveYellowM);
    map['wave_orange_m'] = Variable<double>(waveOrangeM);
    map['wave_red_m'] = Variable<double>(waveRedM);
    map['pressure_drop_threshold_hpa'] = Variable<double>(
      pressureDropThresholdHpa,
    );
    map['forecast_window_hours'] = Variable<int>(forecastWindowHours);
    map['has_acknowledged_a_i_safety'] = Variable<bool>(
      hasAcknowledgedAISafety,
    );
    if (!nullToAbsent || aiApiKey != null) {
      map['ai_api_key'] = Variable<String>(aiApiKey);
    }
    map['ai_model_id'] = Variable<String>(aiModelId);
    return map;
  }

  SkipperSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SkipperSettingsTableCompanion(
      id: Value(id),
      isAIEnabled: Value(isAIEnabled),
      windYellowMs: Value(windYellowMs),
      windOrangeMs: Value(windOrangeMs),
      windRedMs: Value(windRedMs),
      waveYellowM: Value(waveYellowM),
      waveOrangeM: Value(waveOrangeM),
      waveRedM: Value(waveRedM),
      pressureDropThresholdHpa: Value(pressureDropThresholdHpa),
      forecastWindowHours: Value(forecastWindowHours),
      hasAcknowledgedAISafety: Value(hasAcknowledgedAISafety),
      aiApiKey: aiApiKey == null && nullToAbsent
          ? const Value.absent()
          : Value(aiApiKey),
      aiModelId: Value(aiModelId),
    );
  }

  factory SkipperSettingsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkipperSettingsEntry(
      id: serializer.fromJson<int>(json['id']),
      isAIEnabled: serializer.fromJson<bool>(json['isAIEnabled']),
      windYellowMs: serializer.fromJson<double>(json['windYellowMs']),
      windOrangeMs: serializer.fromJson<double>(json['windOrangeMs']),
      windRedMs: serializer.fromJson<double>(json['windRedMs']),
      waveYellowM: serializer.fromJson<double>(json['waveYellowM']),
      waveOrangeM: serializer.fromJson<double>(json['waveOrangeM']),
      waveRedM: serializer.fromJson<double>(json['waveRedM']),
      pressureDropThresholdHpa: serializer.fromJson<double>(
        json['pressureDropThresholdHpa'],
      ),
      forecastWindowHours: serializer.fromJson<int>(
        json['forecastWindowHours'],
      ),
      hasAcknowledgedAISafety: serializer.fromJson<bool>(
        json['hasAcknowledgedAISafety'],
      ),
      aiApiKey: serializer.fromJson<String?>(json['aiApiKey']),
      aiModelId: serializer.fromJson<String>(json['aiModelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isAIEnabled': serializer.toJson<bool>(isAIEnabled),
      'windYellowMs': serializer.toJson<double>(windYellowMs),
      'windOrangeMs': serializer.toJson<double>(windOrangeMs),
      'windRedMs': serializer.toJson<double>(windRedMs),
      'waveYellowM': serializer.toJson<double>(waveYellowM),
      'waveOrangeM': serializer.toJson<double>(waveOrangeM),
      'waveRedM': serializer.toJson<double>(waveRedM),
      'pressureDropThresholdHpa': serializer.toJson<double>(
        pressureDropThresholdHpa,
      ),
      'forecastWindowHours': serializer.toJson<int>(forecastWindowHours),
      'hasAcknowledgedAISafety': serializer.toJson<bool>(
        hasAcknowledgedAISafety,
      ),
      'aiApiKey': serializer.toJson<String?>(aiApiKey),
      'aiModelId': serializer.toJson<String>(aiModelId),
    };
  }

  SkipperSettingsEntry copyWith({
    int? id,
    bool? isAIEnabled,
    double? windYellowMs,
    double? windOrangeMs,
    double? windRedMs,
    double? waveYellowM,
    double? waveOrangeM,
    double? waveRedM,
    double? pressureDropThresholdHpa,
    int? forecastWindowHours,
    bool? hasAcknowledgedAISafety,
    Value<String?> aiApiKey = const Value.absent(),
    String? aiModelId,
  }) => SkipperSettingsEntry(
    id: id ?? this.id,
    isAIEnabled: isAIEnabled ?? this.isAIEnabled,
    windYellowMs: windYellowMs ?? this.windYellowMs,
    windOrangeMs: windOrangeMs ?? this.windOrangeMs,
    windRedMs: windRedMs ?? this.windRedMs,
    waveYellowM: waveYellowM ?? this.waveYellowM,
    waveOrangeM: waveOrangeM ?? this.waveOrangeM,
    waveRedM: waveRedM ?? this.waveRedM,
    pressureDropThresholdHpa:
        pressureDropThresholdHpa ?? this.pressureDropThresholdHpa,
    forecastWindowHours: forecastWindowHours ?? this.forecastWindowHours,
    hasAcknowledgedAISafety:
        hasAcknowledgedAISafety ?? this.hasAcknowledgedAISafety,
    aiApiKey: aiApiKey.present ? aiApiKey.value : this.aiApiKey,
    aiModelId: aiModelId ?? this.aiModelId,
  );
  SkipperSettingsEntry copyWithCompanion(SkipperSettingsTableCompanion data) {
    return SkipperSettingsEntry(
      id: data.id.present ? data.id.value : this.id,
      isAIEnabled: data.isAIEnabled.present
          ? data.isAIEnabled.value
          : this.isAIEnabled,
      windYellowMs: data.windYellowMs.present
          ? data.windYellowMs.value
          : this.windYellowMs,
      windOrangeMs: data.windOrangeMs.present
          ? data.windOrangeMs.value
          : this.windOrangeMs,
      windRedMs: data.windRedMs.present ? data.windRedMs.value : this.windRedMs,
      waveYellowM: data.waveYellowM.present
          ? data.waveYellowM.value
          : this.waveYellowM,
      waveOrangeM: data.waveOrangeM.present
          ? data.waveOrangeM.value
          : this.waveOrangeM,
      waveRedM: data.waveRedM.present ? data.waveRedM.value : this.waveRedM,
      pressureDropThresholdHpa: data.pressureDropThresholdHpa.present
          ? data.pressureDropThresholdHpa.value
          : this.pressureDropThresholdHpa,
      forecastWindowHours: data.forecastWindowHours.present
          ? data.forecastWindowHours.value
          : this.forecastWindowHours,
      hasAcknowledgedAISafety: data.hasAcknowledgedAISafety.present
          ? data.hasAcknowledgedAISafety.value
          : this.hasAcknowledgedAISafety,
      aiApiKey: data.aiApiKey.present ? data.aiApiKey.value : this.aiApiKey,
      aiModelId: data.aiModelId.present ? data.aiModelId.value : this.aiModelId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkipperSettingsEntry(')
          ..write('id: $id, ')
          ..write('isAIEnabled: $isAIEnabled, ')
          ..write('windYellowMs: $windYellowMs, ')
          ..write('windOrangeMs: $windOrangeMs, ')
          ..write('windRedMs: $windRedMs, ')
          ..write('waveYellowM: $waveYellowM, ')
          ..write('waveOrangeM: $waveOrangeM, ')
          ..write('waveRedM: $waveRedM, ')
          ..write('pressureDropThresholdHpa: $pressureDropThresholdHpa, ')
          ..write('forecastWindowHours: $forecastWindowHours, ')
          ..write('hasAcknowledgedAISafety: $hasAcknowledgedAISafety, ')
          ..write('aiApiKey: $aiApiKey, ')
          ..write('aiModelId: $aiModelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    isAIEnabled,
    windYellowMs,
    windOrangeMs,
    windRedMs,
    waveYellowM,
    waveOrangeM,
    waveRedM,
    pressureDropThresholdHpa,
    forecastWindowHours,
    hasAcknowledgedAISafety,
    aiApiKey,
    aiModelId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkipperSettingsEntry &&
          other.id == this.id &&
          other.isAIEnabled == this.isAIEnabled &&
          other.windYellowMs == this.windYellowMs &&
          other.windOrangeMs == this.windOrangeMs &&
          other.windRedMs == this.windRedMs &&
          other.waveYellowM == this.waveYellowM &&
          other.waveOrangeM == this.waveOrangeM &&
          other.waveRedM == this.waveRedM &&
          other.pressureDropThresholdHpa == this.pressureDropThresholdHpa &&
          other.forecastWindowHours == this.forecastWindowHours &&
          other.hasAcknowledgedAISafety == this.hasAcknowledgedAISafety &&
          other.aiApiKey == this.aiApiKey &&
          other.aiModelId == this.aiModelId);
}

class SkipperSettingsTableCompanion
    extends UpdateCompanion<SkipperSettingsEntry> {
  final Value<int> id;
  final Value<bool> isAIEnabled;
  final Value<double> windYellowMs;
  final Value<double> windOrangeMs;
  final Value<double> windRedMs;
  final Value<double> waveYellowM;
  final Value<double> waveOrangeM;
  final Value<double> waveRedM;
  final Value<double> pressureDropThresholdHpa;
  final Value<int> forecastWindowHours;
  final Value<bool> hasAcknowledgedAISafety;
  final Value<String?> aiApiKey;
  final Value<String> aiModelId;
  const SkipperSettingsTableCompanion({
    this.id = const Value.absent(),
    this.isAIEnabled = const Value.absent(),
    this.windYellowMs = const Value.absent(),
    this.windOrangeMs = const Value.absent(),
    this.windRedMs = const Value.absent(),
    this.waveYellowM = const Value.absent(),
    this.waveOrangeM = const Value.absent(),
    this.waveRedM = const Value.absent(),
    this.pressureDropThresholdHpa = const Value.absent(),
    this.forecastWindowHours = const Value.absent(),
    this.hasAcknowledgedAISafety = const Value.absent(),
    this.aiApiKey = const Value.absent(),
    this.aiModelId = const Value.absent(),
  });
  SkipperSettingsTableCompanion.insert({
    this.id = const Value.absent(),
    this.isAIEnabled = const Value.absent(),
    this.windYellowMs = const Value.absent(),
    this.windOrangeMs = const Value.absent(),
    this.windRedMs = const Value.absent(),
    this.waveYellowM = const Value.absent(),
    this.waveOrangeM = const Value.absent(),
    this.waveRedM = const Value.absent(),
    this.pressureDropThresholdHpa = const Value.absent(),
    this.forecastWindowHours = const Value.absent(),
    this.hasAcknowledgedAISafety = const Value.absent(),
    this.aiApiKey = const Value.absent(),
    this.aiModelId = const Value.absent(),
  });
  static Insertable<SkipperSettingsEntry> custom({
    Expression<int>? id,
    Expression<bool>? isAIEnabled,
    Expression<double>? windYellowMs,
    Expression<double>? windOrangeMs,
    Expression<double>? windRedMs,
    Expression<double>? waveYellowM,
    Expression<double>? waveOrangeM,
    Expression<double>? waveRedM,
    Expression<double>? pressureDropThresholdHpa,
    Expression<int>? forecastWindowHours,
    Expression<bool>? hasAcknowledgedAISafety,
    Expression<String>? aiApiKey,
    Expression<String>? aiModelId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isAIEnabled != null) 'is_a_i_enabled': isAIEnabled,
      if (windYellowMs != null) 'wind_yellow_ms': windYellowMs,
      if (windOrangeMs != null) 'wind_orange_ms': windOrangeMs,
      if (windRedMs != null) 'wind_red_ms': windRedMs,
      if (waveYellowM != null) 'wave_yellow_m': waveYellowM,
      if (waveOrangeM != null) 'wave_orange_m': waveOrangeM,
      if (waveRedM != null) 'wave_red_m': waveRedM,
      if (pressureDropThresholdHpa != null)
        'pressure_drop_threshold_hpa': pressureDropThresholdHpa,
      if (forecastWindowHours != null)
        'forecast_window_hours': forecastWindowHours,
      if (hasAcknowledgedAISafety != null)
        'has_acknowledged_a_i_safety': hasAcknowledgedAISafety,
      if (aiApiKey != null) 'ai_api_key': aiApiKey,
      if (aiModelId != null) 'ai_model_id': aiModelId,
    });
  }

  SkipperSettingsTableCompanion copyWith({
    Value<int>? id,
    Value<bool>? isAIEnabled,
    Value<double>? windYellowMs,
    Value<double>? windOrangeMs,
    Value<double>? windRedMs,
    Value<double>? waveYellowM,
    Value<double>? waveOrangeM,
    Value<double>? waveRedM,
    Value<double>? pressureDropThresholdHpa,
    Value<int>? forecastWindowHours,
    Value<bool>? hasAcknowledgedAISafety,
    Value<String?>? aiApiKey,
    Value<String>? aiModelId,
  }) {
    return SkipperSettingsTableCompanion(
      id: id ?? this.id,
      isAIEnabled: isAIEnabled ?? this.isAIEnabled,
      windYellowMs: windYellowMs ?? this.windYellowMs,
      windOrangeMs: windOrangeMs ?? this.windOrangeMs,
      windRedMs: windRedMs ?? this.windRedMs,
      waveYellowM: waveYellowM ?? this.waveYellowM,
      waveOrangeM: waveOrangeM ?? this.waveOrangeM,
      waveRedM: waveRedM ?? this.waveRedM,
      pressureDropThresholdHpa:
          pressureDropThresholdHpa ?? this.pressureDropThresholdHpa,
      forecastWindowHours: forecastWindowHours ?? this.forecastWindowHours,
      hasAcknowledgedAISafety:
          hasAcknowledgedAISafety ?? this.hasAcknowledgedAISafety,
      aiApiKey: aiApiKey ?? this.aiApiKey,
      aiModelId: aiModelId ?? this.aiModelId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isAIEnabled.present) {
      map['is_a_i_enabled'] = Variable<bool>(isAIEnabled.value);
    }
    if (windYellowMs.present) {
      map['wind_yellow_ms'] = Variable<double>(windYellowMs.value);
    }
    if (windOrangeMs.present) {
      map['wind_orange_ms'] = Variable<double>(windOrangeMs.value);
    }
    if (windRedMs.present) {
      map['wind_red_ms'] = Variable<double>(windRedMs.value);
    }
    if (waveYellowM.present) {
      map['wave_yellow_m'] = Variable<double>(waveYellowM.value);
    }
    if (waveOrangeM.present) {
      map['wave_orange_m'] = Variable<double>(waveOrangeM.value);
    }
    if (waveRedM.present) {
      map['wave_red_m'] = Variable<double>(waveRedM.value);
    }
    if (pressureDropThresholdHpa.present) {
      map['pressure_drop_threshold_hpa'] = Variable<double>(
        pressureDropThresholdHpa.value,
      );
    }
    if (forecastWindowHours.present) {
      map['forecast_window_hours'] = Variable<int>(forecastWindowHours.value);
    }
    if (hasAcknowledgedAISafety.present) {
      map['has_acknowledged_a_i_safety'] = Variable<bool>(
        hasAcknowledgedAISafety.value,
      );
    }
    if (aiApiKey.present) {
      map['ai_api_key'] = Variable<String>(aiApiKey.value);
    }
    if (aiModelId.present) {
      map['ai_model_id'] = Variable<String>(aiModelId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkipperSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('isAIEnabled: $isAIEnabled, ')
          ..write('windYellowMs: $windYellowMs, ')
          ..write('windOrangeMs: $windOrangeMs, ')
          ..write('windRedMs: $windRedMs, ')
          ..write('waveYellowM: $waveYellowM, ')
          ..write('waveOrangeM: $waveOrangeM, ')
          ..write('waveRedM: $waveRedM, ')
          ..write('pressureDropThresholdHpa: $pressureDropThresholdHpa, ')
          ..write('forecastWindowHours: $forecastWindowHours, ')
          ..write('hasAcknowledgedAISafety: $hasAcknowledgedAISafety, ')
          ..write('aiApiKey: $aiApiKey, ')
          ..write('aiModelId: $aiModelId')
          ..write(')'))
        .toString();
  }
}

class $RecordedTracksTable extends RecordedTracks
    with TableInfo<$RecordedTracksTable, RecordedTrack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordedTracksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFishingModeMeta = const VerificationMeta(
    'isFishingMode',
  );
  @override
  late final GeneratedColumn<bool> isFishingMode = GeneratedColumn<bool>(
    'is_fishing_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fishing_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _totalDistanceMetersMeta =
      const VerificationMeta('totalDistanceMeters');
  @override
  late final GeneratedColumn<double> totalDistanceMeters =
      GeneratedColumn<double>(
        'total_distance_meters',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    startTime,
    endTime,
    isFishingMode,
    totalDistanceMeters,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recorded_tracks';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecordedTrack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('is_fishing_mode')) {
      context.handle(
        _isFishingModeMeta,
        isFishingMode.isAcceptableOrUnknown(
          data['is_fishing_mode']!,
          _isFishingModeMeta,
        ),
      );
    }
    if (data.containsKey('total_distance_meters')) {
      context.handle(
        _totalDistanceMetersMeta,
        totalDistanceMeters.isAcceptableOrUnknown(
          data['total_distance_meters']!,
          _totalDistanceMetersMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecordedTrack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordedTrack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      isFishingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fishing_mode'],
      )!,
      totalDistanceMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_distance_meters'],
      )!,
    );
  }

  @override
  $RecordedTracksTable createAlias(String alias) {
    return $RecordedTracksTable(attachedDatabase, alias);
  }
}

class RecordedTrack extends DataClass implements Insertable<RecordedTrack> {
  final int id;
  final String? name;
  final DateTime startTime;
  final DateTime? endTime;
  final bool isFishingMode;
  final double totalDistanceMeters;
  const RecordedTrack({
    required this.id,
    this.name,
    required this.startTime,
    this.endTime,
    required this.isFishingMode,
    required this.totalDistanceMeters,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['is_fishing_mode'] = Variable<bool>(isFishingMode);
    map['total_distance_meters'] = Variable<double>(totalDistanceMeters);
    return map;
  }

  RecordedTracksCompanion toCompanion(bool nullToAbsent) {
    return RecordedTracksCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      isFishingMode: Value(isFishingMode),
      totalDistanceMeters: Value(totalDistanceMeters),
    );
  }

  factory RecordedTrack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordedTrack(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      isFishingMode: serializer.fromJson<bool>(json['isFishingMode']),
      totalDistanceMeters: serializer.fromJson<double>(
        json['totalDistanceMeters'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'isFishingMode': serializer.toJson<bool>(isFishingMode),
      'totalDistanceMeters': serializer.toJson<double>(totalDistanceMeters),
    };
  }

  RecordedTrack copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    bool? isFishingMode,
    double? totalDistanceMeters,
  }) => RecordedTrack(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    isFishingMode: isFishingMode ?? this.isFishingMode,
    totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
  );
  RecordedTrack copyWithCompanion(RecordedTracksCompanion data) {
    return RecordedTrack(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      isFishingMode: data.isFishingMode.present
          ? data.isFishingMode.value
          : this.isFishingMode,
      totalDistanceMeters: data.totalDistanceMeters.present
          ? data.totalDistanceMeters.value
          : this.totalDistanceMeters,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecordedTrack(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('isFishingMode: $isFishingMode, ')
          ..write('totalDistanceMeters: $totalDistanceMeters')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    startTime,
    endTime,
    isFishingMode,
    totalDistanceMeters,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordedTrack &&
          other.id == this.id &&
          other.name == this.name &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.isFishingMode == this.isFishingMode &&
          other.totalDistanceMeters == this.totalDistanceMeters);
}

class RecordedTracksCompanion extends UpdateCompanion<RecordedTrack> {
  final Value<int> id;
  final Value<String?> name;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<bool> isFishingMode;
  final Value<double> totalDistanceMeters;
  const RecordedTracksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.isFishingMode = const Value.absent(),
    this.totalDistanceMeters = const Value.absent(),
  });
  RecordedTracksCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.isFishingMode = const Value.absent(),
    this.totalDistanceMeters = const Value.absent(),
  }) : startTime = Value(startTime);
  static Insertable<RecordedTrack> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<bool>? isFishingMode,
    Expression<double>? totalDistanceMeters,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (isFishingMode != null) 'is_fishing_mode': isFishingMode,
      if (totalDistanceMeters != null)
        'total_distance_meters': totalDistanceMeters,
    });
  }

  RecordedTracksCompanion copyWith({
    Value<int>? id,
    Value<String?>? name,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<bool>? isFishingMode,
    Value<double>? totalDistanceMeters,
  }) {
    return RecordedTracksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isFishingMode: isFishingMode ?? this.isFishingMode,
      totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (isFishingMode.present) {
      map['is_fishing_mode'] = Variable<bool>(isFishingMode.value);
    }
    if (totalDistanceMeters.present) {
      map['total_distance_meters'] = Variable<double>(
        totalDistanceMeters.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordedTracksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('isFishingMode: $isFishingMode, ')
          ..write('totalDistanceMeters: $totalDistanceMeters')
          ..write(')'))
        .toString();
  }
}

class $TrackPointsTable extends TrackPoints
    with TableInfo<$TrackPointsTable, TrackPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<int> trackId = GeneratedColumn<int>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recorded_tracks (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedKmhMeta = const VerificationMeta(
    'speedKmh',
  );
  @override
  late final GeneratedColumn<double> speedKmh = GeneratedColumn<double>(
    'speed_kmh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    trackId,
    latitude,
    longitude,
    speedKmh,
    timestamp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('speed_kmh')) {
      context.handle(
        _speedKmhMeta,
        speedKmh.isAcceptableOrUnknown(data['speed_kmh']!, _speedKmhMeta),
      );
    } else if (isInserting) {
      context.missing(_speedKmhMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackPoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      trackId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      speedKmh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed_kmh'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $TrackPointsTable createAlias(String alias) {
    return $TrackPointsTable(attachedDatabase, alias);
  }
}

class TrackPoint extends DataClass implements Insertable<TrackPoint> {
  final int id;
  final int trackId;
  final double latitude;
  final double longitude;
  final double speedKmh;
  final DateTime timestamp;
  const TrackPoint({
    required this.id,
    required this.trackId,
    required this.latitude,
    required this.longitude,
    required this.speedKmh,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['track_id'] = Variable<int>(trackId);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['speed_kmh'] = Variable<double>(speedKmh);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  TrackPointsCompanion toCompanion(bool nullToAbsent) {
    return TrackPointsCompanion(
      id: Value(id),
      trackId: Value(trackId),
      latitude: Value(latitude),
      longitude: Value(longitude),
      speedKmh: Value(speedKmh),
      timestamp: Value(timestamp),
    );
  }

  factory TrackPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackPoint(
      id: serializer.fromJson<int>(json['id']),
      trackId: serializer.fromJson<int>(json['trackId']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      speedKmh: serializer.fromJson<double>(json['speedKmh']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trackId': serializer.toJson<int>(trackId),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'speedKmh': serializer.toJson<double>(speedKmh),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  TrackPoint copyWith({
    int? id,
    int? trackId,
    double? latitude,
    double? longitude,
    double? speedKmh,
    DateTime? timestamp,
  }) => TrackPoint(
    id: id ?? this.id,
    trackId: trackId ?? this.trackId,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    speedKmh: speedKmh ?? this.speedKmh,
    timestamp: timestamp ?? this.timestamp,
  );
  TrackPoint copyWithCompanion(TrackPointsCompanion data) {
    return TrackPoint(
      id: data.id.present ? data.id.value : this.id,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      speedKmh: data.speedKmh.present ? data.speedKmh.value : this.speedKmh,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackPoint(')
          ..write('id: $id, ')
          ..write('trackId: $trackId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('speedKmh: $speedKmh, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, trackId, latitude, longitude, speedKmh, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackPoint &&
          other.id == this.id &&
          other.trackId == this.trackId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.speedKmh == this.speedKmh &&
          other.timestamp == this.timestamp);
}

class TrackPointsCompanion extends UpdateCompanion<TrackPoint> {
  final Value<int> id;
  final Value<int> trackId;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> speedKmh;
  final Value<DateTime> timestamp;
  const TrackPointsCompanion({
    this.id = const Value.absent(),
    this.trackId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.speedKmh = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  TrackPointsCompanion.insert({
    this.id = const Value.absent(),
    required int trackId,
    required double latitude,
    required double longitude,
    required double speedKmh,
    required DateTime timestamp,
  }) : trackId = Value(trackId),
       latitude = Value(latitude),
       longitude = Value(longitude),
       speedKmh = Value(speedKmh),
       timestamp = Value(timestamp);
  static Insertable<TrackPoint> custom({
    Expression<int>? id,
    Expression<int>? trackId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? speedKmh,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trackId != null) 'track_id': trackId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (speedKmh != null) 'speed_kmh': speedKmh,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  TrackPointsCompanion copyWith({
    Value<int>? id,
    Value<int>? trackId,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double>? speedKmh,
    Value<DateTime>? timestamp,
  }) {
    return TrackPointsCompanion(
      id: id ?? this.id,
      trackId: trackId ?? this.trackId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      speedKmh: speedKmh ?? this.speedKmh,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<int>(trackId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (speedKmh.present) {
      map['speed_kmh'] = Variable<double>(speedKmh.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackPointsCompanion(')
          ..write('id: $id, ')
          ..write('trackId: $trackId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('speedKmh: $speedKmh, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CatchesTable catches = $CatchesTable(this);
  late final $UserContributionsTable userContributions =
      $UserContributionsTable(this);
  late final $CachedFeaturesTable cachedFeatures = $CachedFeaturesTable(this);
  late final $WeatherProvidersTable weatherProviders = $WeatherProvidersTable(
    this,
  );
  late final $WeatherStationsTable weatherStations = $WeatherStationsTable(
    this,
  );
  late final $WeatherObservationsTable weatherObservations =
      $WeatherObservationsTable(this);
  late final $WeatherForecastsTable weatherForecasts = $WeatherForecastsTable(
    this,
  );
  late final $WaveObservationsTable waveObservations = $WaveObservationsTable(
    this,
  );
  late final $SeaLevelReadingsTable seaLevelReadings = $SeaLevelReadingsTable(
    this,
  );
  late final $WeatherAlertsTable weatherAlerts = $WeatherAlertsTable(this);
  late final $LightningStrikesTable lightningStrikes = $LightningStrikesTable(
    this,
  );
  late final $WaterQualityReadingsTable waterQualityReadings =
      $WaterQualityReadingsTable(this);
  late final $AlgaeReportsTable algaeReports = $AlgaeReportsTable(this);
  late final $MarineMapTilesTable marineMapTiles = $MarineMapTilesTable(this);
  late final $OfflineRegionsTable offlineRegions = $OfflineRegionsTable(this);
  late final $RegionTileRefsTable regionTileRefs = $RegionTileRefsTable(this);
  late final $RoutesTable routes = $RoutesTable(this);
  late final $WaypointsTable waypoints = $WaypointsTable(this);
  late final $VesselProfilesTable vesselProfiles = $VesselProfilesTable(this);
  late final $SkipperSettingsTableTable skipperSettingsTable =
      $SkipperSettingsTableTable(this);
  late final $RecordedTracksTable recordedTracks = $RecordedTracksTable(this);
  late final $TrackPointsTable trackPoints = $TrackPointsTable(this);
  late final WeatherDao weatherDao = WeatherDao(this as AppDatabase);
  late final TileDao tileDao = TileDao(this as AppDatabase);
  late final RouteDao routeDao = RouteDao(this as AppDatabase);
  late final VesselDao vesselDao = VesselDao(this as AppDatabase);
  late final SkipperSettingsDao skipperSettingsDao = SkipperSettingsDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    catches,
    userContributions,
    cachedFeatures,
    weatherProviders,
    weatherStations,
    weatherObservations,
    weatherForecasts,
    waveObservations,
    seaLevelReadings,
    weatherAlerts,
    lightningStrikes,
    waterQualityReadings,
    algaeReports,
    marineMapTiles,
    offlineRegions,
    regionTileRefs,
    routes,
    waypoints,
    vesselProfiles,
    skipperSettingsTable,
    recordedTracks,
    trackPoints,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'weather_stations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weather_observations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'weather_stations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('weather_forecasts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'weather_stations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('wave_observations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'weather_stations',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sea_level_readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'offline_regions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('region_tile_refs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'routes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('waypoints', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recorded_tracks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('track_points', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CatchesTableCreateCompanionBuilder =
    CatchesCompanion Function({
      required String id,
      required String species,
      required int timestampMs,
      required double latitude,
      required double longitude,
      Value<int?> weightGrams,
      Value<double?> lengthCm,
      Value<String?> lure,
      Value<String?> method,
      Value<String?> notes,
      Value<double?> weatherTemp,
      Value<double?> weatherWindSpeed,
      Value<double?> weatherWindDir,
      Value<String?> weatherDesc,
      Value<String?> weatherIcon,
      Value<int> rowid,
    });
typedef $$CatchesTableUpdateCompanionBuilder =
    CatchesCompanion Function({
      Value<String> id,
      Value<String> species,
      Value<int> timestampMs,
      Value<double> latitude,
      Value<double> longitude,
      Value<int?> weightGrams,
      Value<double?> lengthCm,
      Value<String?> lure,
      Value<String?> method,
      Value<String?> notes,
      Value<double?> weatherTemp,
      Value<double?> weatherWindSpeed,
      Value<double?> weatherWindDir,
      Value<String?> weatherDesc,
      Value<String?> weatherIcon,
      Value<int> rowid,
    });

class $$CatchesTableFilterComposer
    extends Composer<_$AppDatabase, $CatchesTable> {
  $$CatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lengthCm => $composableBuilder(
    column: $table.lengthCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lure => $composableBuilder(
    column: $table.lure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weatherTemp => $composableBuilder(
    column: $table.weatherTemp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weatherWindSpeed => $composableBuilder(
    column: $table.weatherWindSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weatherWindDir => $composableBuilder(
    column: $table.weatherWindDir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherDesc => $composableBuilder(
    column: $table.weatherDesc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $CatchesTable> {
  $$CatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lengthCm => $composableBuilder(
    column: $table.lengthCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lure => $composableBuilder(
    column: $table.lure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weatherTemp => $composableBuilder(
    column: $table.weatherTemp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weatherWindSpeed => $composableBuilder(
    column: $table.weatherWindSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weatherWindDir => $composableBuilder(
    column: $table.weatherWindDir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherDesc => $composableBuilder(
    column: $table.weatherDesc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CatchesTable> {
  $$CatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<int> get timestampMs => $composableBuilder(
    column: $table.timestampMs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get weightGrams => $composableBuilder(
    column: $table.weightGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lengthCm =>
      $composableBuilder(column: $table.lengthCm, builder: (column) => column);

  GeneratedColumn<String> get lure =>
      $composableBuilder(column: $table.lure, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get weatherTemp => $composableBuilder(
    column: $table.weatherTemp,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weatherWindSpeed => $composableBuilder(
    column: $table.weatherWindSpeed,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weatherWindDir => $composableBuilder(
    column: $table.weatherWindDir,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherDesc => $composableBuilder(
    column: $table.weatherDesc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => column,
  );
}

class $$CatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CatchesTable,
          Catch,
          $$CatchesTableFilterComposer,
          $$CatchesTableOrderingComposer,
          $$CatchesTableAnnotationComposer,
          $$CatchesTableCreateCompanionBuilder,
          $$CatchesTableUpdateCompanionBuilder,
          (Catch, BaseReferences<_$AppDatabase, $CatchesTable, Catch>),
          Catch,
          PrefetchHooks Function()
        > {
  $$CatchesTableTableManager(_$AppDatabase db, $CatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> species = const Value.absent(),
                Value<int> timestampMs = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<int?> weightGrams = const Value.absent(),
                Value<double?> lengthCm = const Value.absent(),
                Value<String?> lure = const Value.absent(),
                Value<String?> method = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> weatherTemp = const Value.absent(),
                Value<double?> weatherWindSpeed = const Value.absent(),
                Value<double?> weatherWindDir = const Value.absent(),
                Value<String?> weatherDesc = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CatchesCompanion(
                id: id,
                species: species,
                timestampMs: timestampMs,
                latitude: latitude,
                longitude: longitude,
                weightGrams: weightGrams,
                lengthCm: lengthCm,
                lure: lure,
                method: method,
                notes: notes,
                weatherTemp: weatherTemp,
                weatherWindSpeed: weatherWindSpeed,
                weatherWindDir: weatherWindDir,
                weatherDesc: weatherDesc,
                weatherIcon: weatherIcon,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String species,
                required int timestampMs,
                required double latitude,
                required double longitude,
                Value<int?> weightGrams = const Value.absent(),
                Value<double?> lengthCm = const Value.absent(),
                Value<String?> lure = const Value.absent(),
                Value<String?> method = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> weatherTemp = const Value.absent(),
                Value<double?> weatherWindSpeed = const Value.absent(),
                Value<double?> weatherWindDir = const Value.absent(),
                Value<String?> weatherDesc = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CatchesCompanion.insert(
                id: id,
                species: species,
                timestampMs: timestampMs,
                latitude: latitude,
                longitude: longitude,
                weightGrams: weightGrams,
                lengthCm: lengthCm,
                lure: lure,
                method: method,
                notes: notes,
                weatherTemp: weatherTemp,
                weatherWindSpeed: weatherWindSpeed,
                weatherWindDir: weatherWindDir,
                weatherDesc: weatherDesc,
                weatherIcon: weatherIcon,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CatchesTable,
      Catch,
      $$CatchesTableFilterComposer,
      $$CatchesTableOrderingComposer,
      $$CatchesTableAnnotationComposer,
      $$CatchesTableCreateCompanionBuilder,
      $$CatchesTableUpdateCompanionBuilder,
      (Catch, BaseReferences<_$AppDatabase, $CatchesTable, Catch>),
      Catch,
      PrefetchHooks Function()
    >;
typedef $$UserContributionsTableCreateCompanionBuilder =
    UserContributionsCompanion Function({
      required String id,
      required ContributionType type,
      required double latitude,
      required double longitude,
      required String value,
      required DateTime createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });
typedef $$UserContributionsTableUpdateCompanionBuilder =
    UserContributionsCompanion Function({
      Value<String> id,
      Value<ContributionType> type,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> value,
      Value<DateTime> createdAt,
      Value<bool> isSynced,
      Value<int> rowid,
    });

class $$UserContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $UserContributionsTable> {
  $$UserContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ContributionType, ContributionType, int>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserContributionsTable> {
  $$UserContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserContributionsTable> {
  $$UserContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ContributionType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);
}

class $$UserContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserContributionsTable,
          UserContributionEntry,
          $$UserContributionsTableFilterComposer,
          $$UserContributionsTableOrderingComposer,
          $$UserContributionsTableAnnotationComposer,
          $$UserContributionsTableCreateCompanionBuilder,
          $$UserContributionsTableUpdateCompanionBuilder,
          (
            UserContributionEntry,
            BaseReferences<
              _$AppDatabase,
              $UserContributionsTable,
              UserContributionEntry
            >,
          ),
          UserContributionEntry,
          PrefetchHooks Function()
        > {
  $$UserContributionsTableTableManager(
    _$AppDatabase db,
    $UserContributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserContributionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserContributionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserContributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<ContributionType> type = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserContributionsCompanion(
                id: id,
                type: type,
                latitude: latitude,
                longitude: longitude,
                value: value,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required ContributionType type,
                required double latitude,
                required double longitude,
                required String value,
                required DateTime createdAt,
                Value<bool> isSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserContributionsCompanion.insert(
                id: id,
                type: type,
                latitude: latitude,
                longitude: longitude,
                value: value,
                createdAt: createdAt,
                isSynced: isSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserContributionsTable,
      UserContributionEntry,
      $$UserContributionsTableFilterComposer,
      $$UserContributionsTableOrderingComposer,
      $$UserContributionsTableAnnotationComposer,
      $$UserContributionsTableCreateCompanionBuilder,
      $$UserContributionsTableUpdateCompanionBuilder,
      (
        UserContributionEntry,
        BaseReferences<
          _$AppDatabase,
          $UserContributionsTable,
          UserContributionEntry
        >,
      ),
      UserContributionEntry,
      PrefetchHooks Function()
    >;
typedef $$CachedFeaturesTableCreateCompanionBuilder =
    CachedFeaturesCompanion Function({
      required String id,
      required String category,
      required DateTime cachedAt,
      required String dataJson,
      Value<int> rowid,
    });
typedef $$CachedFeaturesTableUpdateCompanionBuilder =
    CachedFeaturesCompanion Function({
      Value<String> id,
      Value<String> category,
      Value<DateTime> cachedAt,
      Value<String> dataJson,
      Value<int> rowid,
    });

class $$CachedFeaturesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedFeaturesTable> {
  $$CachedFeaturesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataJson => $composableBuilder(
    column: $table.dataJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedFeaturesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedFeaturesTable> {
  $$CachedFeaturesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataJson => $composableBuilder(
    column: $table.dataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedFeaturesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedFeaturesTable> {
  $$CachedFeaturesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);
}

class $$CachedFeaturesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedFeaturesTable,
          CachedFeature,
          $$CachedFeaturesTableFilterComposer,
          $$CachedFeaturesTableOrderingComposer,
          $$CachedFeaturesTableAnnotationComposer,
          $$CachedFeaturesTableCreateCompanionBuilder,
          $$CachedFeaturesTableUpdateCompanionBuilder,
          (
            CachedFeature,
            BaseReferences<_$AppDatabase, $CachedFeaturesTable, CachedFeature>,
          ),
          CachedFeature,
          PrefetchHooks Function()
        > {
  $$CachedFeaturesTableTableManager(
    _$AppDatabase db,
    $CachedFeaturesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedFeaturesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedFeaturesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedFeaturesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<String> dataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedFeaturesCompanion(
                id: id,
                category: category,
                cachedAt: cachedAt,
                dataJson: dataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String category,
                required DateTime cachedAt,
                required String dataJson,
                Value<int> rowid = const Value.absent(),
              }) => CachedFeaturesCompanion.insert(
                id: id,
                category: category,
                cachedAt: cachedAt,
                dataJson: dataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedFeaturesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedFeaturesTable,
      CachedFeature,
      $$CachedFeaturesTableFilterComposer,
      $$CachedFeaturesTableOrderingComposer,
      $$CachedFeaturesTableAnnotationComposer,
      $$CachedFeaturesTableCreateCompanionBuilder,
      $$CachedFeaturesTableUpdateCompanionBuilder,
      (
        CachedFeature,
        BaseReferences<_$AppDatabase, $CachedFeaturesTable, CachedFeature>,
      ),
      CachedFeature,
      PrefetchHooks Function()
    >;
typedef $$WeatherProvidersTableCreateCompanionBuilder =
    WeatherProvidersCompanion Function({
      Value<int> id,
      required String code,
      required String name,
      Value<int> priority,
      Value<String?> apiVersion,
      Value<bool> isActive,
    });
typedef $$WeatherProvidersTableUpdateCompanionBuilder =
    WeatherProvidersCompanion Function({
      Value<int> id,
      Value<String> code,
      Value<String> name,
      Value<int> priority,
      Value<String?> apiVersion,
      Value<bool> isActive,
    });

final class $$WeatherProvidersTableReferences
    extends
        BaseReferences<_$AppDatabase, $WeatherProvidersTable, WeatherProvider> {
  $$WeatherProvidersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $WeatherObservationsTable,
    List<WeatherObservation>
  >
  _weatherObservationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.weatherObservations,
        aliasName: 'weather_providers__id__weather_observations__provider_id',
      );

  $$WeatherObservationsTableProcessedTableManager get weatherObservationsRefs {
    final manager = $$WeatherObservationsTableTableManager(
      $_db,
      $_db.weatherObservations,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _weatherObservationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeatherForecastsTable, List<WeatherForecast>>
  _weatherForecastsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weatherForecasts,
    aliasName: 'weather_providers__id__weather_forecasts__provider_id',
  );

  $$WeatherForecastsTableProcessedTableManager get weatherForecastsRefs {
    final manager = $$WeatherForecastsTableTableManager(
      $_db,
      $_db.weatherForecasts,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _weatherForecastsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WaveObservationsTable, List<WaveObservation>>
  _waveObservationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.waveObservations,
    aliasName: 'weather_providers__id__wave_observations__provider_id',
  );

  $$WaveObservationsTableProcessedTableManager get waveObservationsRefs {
    final manager = $$WaveObservationsTableTableManager(
      $_db,
      $_db.waveObservations,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _waveObservationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SeaLevelReadingsTable, List<SeaLevelReading>>
  _seaLevelReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.seaLevelReadings,
    aliasName: 'weather_providers__id__sea_level_readings__provider_id',
  );

  $$SeaLevelReadingsTableProcessedTableManager get seaLevelReadingsRefs {
    final manager = $$SeaLevelReadingsTableTableManager(
      $_db,
      $_db.seaLevelReadings,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _seaLevelReadingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeatherAlertsTable, List<WeatherAlert>>
  _weatherAlertsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weatherAlerts,
    aliasName: 'weather_providers__id__weather_alerts__provider_id',
  );

  $$WeatherAlertsTableProcessedTableManager get weatherAlertsRefs {
    final manager = $$WeatherAlertsTableTableManager(
      $_db,
      $_db.weatherAlerts,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_weatherAlertsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LightningStrikesTable, List<LightningStrike>>
  _lightningStrikesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lightningStrikes,
    aliasName: 'weather_providers__id__lightning_strikes__provider_id',
  );

  $$LightningStrikesTableProcessedTableManager get lightningStrikesRefs {
    final manager = $$LightningStrikesTableTableManager(
      $_db,
      $_db.lightningStrikes,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _lightningStrikesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WaterQualityReadingsTable,
    List<WaterQualityReading>
  >
  _waterQualityReadingsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.waterQualityReadings,
        aliasName: 'weather_providers__id__water_quality_readings__provider_id',
      );

  $$WaterQualityReadingsTableProcessedTableManager
  get waterQualityReadingsRefs {
    final manager = $$WaterQualityReadingsTableTableManager(
      $_db,
      $_db.waterQualityReadings,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _waterQualityReadingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AlgaeReportsTable, List<AlgaeReport>>
  _algaeReportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.algaeReports,
    aliasName: 'weather_providers__id__algae_reports__provider_id',
  );

  $$AlgaeReportsTableProcessedTableManager get algaeReportsRefs {
    final manager = $$AlgaeReportsTableTableManager(
      $_db,
      $_db.algaeReports,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_algaeReportsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeatherProvidersTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherProvidersTable> {
  $$WeatherProvidersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get apiVersion => $composableBuilder(
    column: $table.apiVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> weatherObservationsRefs(
    Expression<bool> Function($$WeatherObservationsTableFilterComposer f) f,
  ) {
    final $$WeatherObservationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weatherObservations,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherObservationsTableFilterComposer(
            $db: $db,
            $table: $db.weatherObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weatherForecastsRefs(
    Expression<bool> Function($$WeatherForecastsTableFilterComposer f) f,
  ) {
    final $$WeatherForecastsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weatherForecasts,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherForecastsTableFilterComposer(
            $db: $db,
            $table: $db.weatherForecasts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> waveObservationsRefs(
    Expression<bool> Function($$WaveObservationsTableFilterComposer f) f,
  ) {
    final $$WaveObservationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waveObservations,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaveObservationsTableFilterComposer(
            $db: $db,
            $table: $db.waveObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> seaLevelReadingsRefs(
    Expression<bool> Function($$SeaLevelReadingsTableFilterComposer f) f,
  ) {
    final $$SeaLevelReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seaLevelReadings,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeaLevelReadingsTableFilterComposer(
            $db: $db,
            $table: $db.seaLevelReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weatherAlertsRefs(
    Expression<bool> Function($$WeatherAlertsTableFilterComposer f) f,
  ) {
    final $$WeatherAlertsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weatherAlerts,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherAlertsTableFilterComposer(
            $db: $db,
            $table: $db.weatherAlerts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> lightningStrikesRefs(
    Expression<bool> Function($$LightningStrikesTableFilterComposer f) f,
  ) {
    final $$LightningStrikesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lightningStrikes,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LightningStrikesTableFilterComposer(
            $db: $db,
            $table: $db.lightningStrikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> waterQualityReadingsRefs(
    Expression<bool> Function($$WaterQualityReadingsTableFilterComposer f) f,
  ) {
    final $$WaterQualityReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waterQualityReadings,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaterQualityReadingsTableFilterComposer(
            $db: $db,
            $table: $db.waterQualityReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> algaeReportsRefs(
    Expression<bool> Function($$AlgaeReportsTableFilterComposer f) f,
  ) {
    final $$AlgaeReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.algaeReports,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlgaeReportsTableFilterComposer(
            $db: $db,
            $table: $db.algaeReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeatherProvidersTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherProvidersTable> {
  $$WeatherProvidersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get apiVersion => $composableBuilder(
    column: $table.apiVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeatherProvidersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherProvidersTable> {
  $$WeatherProvidersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get apiVersion => $composableBuilder(
    column: $table.apiVersion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> weatherObservationsRefs<T extends Object>(
    Expression<T> Function($$WeatherObservationsTableAnnotationComposer a) f,
  ) {
    final $$WeatherObservationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.weatherObservations,
          getReferencedColumn: (t) => t.providerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WeatherObservationsTableAnnotationComposer(
                $db: $db,
                $table: $db.weatherObservations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> weatherForecastsRefs<T extends Object>(
    Expression<T> Function($$WeatherForecastsTableAnnotationComposer a) f,
  ) {
    final $$WeatherForecastsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weatherForecasts,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherForecastsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherForecasts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> waveObservationsRefs<T extends Object>(
    Expression<T> Function($$WaveObservationsTableAnnotationComposer a) f,
  ) {
    final $$WaveObservationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waveObservations,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaveObservationsTableAnnotationComposer(
            $db: $db,
            $table: $db.waveObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> seaLevelReadingsRefs<T extends Object>(
    Expression<T> Function($$SeaLevelReadingsTableAnnotationComposer a) f,
  ) {
    final $$SeaLevelReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seaLevelReadings,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeaLevelReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.seaLevelReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weatherAlertsRefs<T extends Object>(
    Expression<T> Function($$WeatherAlertsTableAnnotationComposer a) f,
  ) {
    final $$WeatherAlertsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weatherAlerts,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherAlertsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherAlerts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> lightningStrikesRefs<T extends Object>(
    Expression<T> Function($$LightningStrikesTableAnnotationComposer a) f,
  ) {
    final $$LightningStrikesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lightningStrikes,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LightningStrikesTableAnnotationComposer(
            $db: $db,
            $table: $db.lightningStrikes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> waterQualityReadingsRefs<T extends Object>(
    Expression<T> Function($$WaterQualityReadingsTableAnnotationComposer a) f,
  ) {
    final $$WaterQualityReadingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.waterQualityReadings,
          getReferencedColumn: (t) => t.providerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WaterQualityReadingsTableAnnotationComposer(
                $db: $db,
                $table: $db.waterQualityReadings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> algaeReportsRefs<T extends Object>(
    Expression<T> Function($$AlgaeReportsTableAnnotationComposer a) f,
  ) {
    final $$AlgaeReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.algaeReports,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlgaeReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.algaeReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeatherProvidersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherProvidersTable,
          WeatherProvider,
          $$WeatherProvidersTableFilterComposer,
          $$WeatherProvidersTableOrderingComposer,
          $$WeatherProvidersTableAnnotationComposer,
          $$WeatherProvidersTableCreateCompanionBuilder,
          $$WeatherProvidersTableUpdateCompanionBuilder,
          (WeatherProvider, $$WeatherProvidersTableReferences),
          WeatherProvider,
          PrefetchHooks Function({
            bool weatherObservationsRefs,
            bool weatherForecastsRefs,
            bool waveObservationsRefs,
            bool seaLevelReadingsRefs,
            bool weatherAlertsRefs,
            bool lightningStrikesRefs,
            bool waterQualityReadingsRefs,
            bool algaeReportsRefs,
          })
        > {
  $$WeatherProvidersTableTableManager(
    _$AppDatabase db,
    $WeatherProvidersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeatherProvidersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeatherProvidersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeatherProvidersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String?> apiVersion = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => WeatherProvidersCompanion(
                id: id,
                code: code,
                name: name,
                priority: priority,
                apiVersion: apiVersion,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String code,
                required String name,
                Value<int> priority = const Value.absent(),
                Value<String?> apiVersion = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => WeatherProvidersCompanion.insert(
                id: id,
                code: code,
                name: name,
                priority: priority,
                apiVersion: apiVersion,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeatherProvidersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                weatherObservationsRefs = false,
                weatherForecastsRefs = false,
                waveObservationsRefs = false,
                seaLevelReadingsRefs = false,
                weatherAlertsRefs = false,
                lightningStrikesRefs = false,
                waterQualityReadingsRefs = false,
                algaeReportsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (weatherObservationsRefs) db.weatherObservations,
                    if (weatherForecastsRefs) db.weatherForecasts,
                    if (waveObservationsRefs) db.waveObservations,
                    if (seaLevelReadingsRefs) db.seaLevelReadings,
                    if (weatherAlertsRefs) db.weatherAlerts,
                    if (lightningStrikesRefs) db.lightningStrikes,
                    if (waterQualityReadingsRefs) db.waterQualityReadings,
                    if (algaeReportsRefs) db.algaeReports,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (weatherObservationsRefs)
                        await $_getPrefetchedData<
                          WeatherProvider,
                          $WeatherProvidersTable,
                          WeatherObservation
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherProvidersTableReferences
                              ._weatherObservationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).weatherObservationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (weatherForecastsRefs)
                        await $_getPrefetchedData<
                          WeatherProvider,
                          $WeatherProvidersTable,
                          WeatherForecast
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherProvidersTableReferences
                              ._weatherForecastsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).weatherForecastsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (waveObservationsRefs)
                        await $_getPrefetchedData<
                          WeatherProvider,
                          $WeatherProvidersTable,
                          WaveObservation
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherProvidersTableReferences
                              ._waveObservationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).waveObservationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (seaLevelReadingsRefs)
                        await $_getPrefetchedData<
                          WeatherProvider,
                          $WeatherProvidersTable,
                          SeaLevelReading
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherProvidersTableReferences
                              ._seaLevelReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).seaLevelReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (weatherAlertsRefs)
                        await $_getPrefetchedData<
                          WeatherProvider,
                          $WeatherProvidersTable,
                          WeatherAlert
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherProvidersTableReferences
                              ._weatherAlertsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).weatherAlertsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (lightningStrikesRefs)
                        await $_getPrefetchedData<
                          WeatherProvider,
                          $WeatherProvidersTable,
                          LightningStrike
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherProvidersTableReferences
                              ._lightningStrikesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).lightningStrikesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (waterQualityReadingsRefs)
                        await $_getPrefetchedData<
                          WeatherProvider,
                          $WeatherProvidersTable,
                          WaterQualityReading
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherProvidersTableReferences
                              ._waterQualityReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).waterQualityReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (algaeReportsRefs)
                        await $_getPrefetchedData<
                          WeatherProvider,
                          $WeatherProvidersTable,
                          AlgaeReport
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherProvidersTableReferences
                              ._algaeReportsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherProvidersTableReferences(
                                db,
                                table,
                                p0,
                              ).algaeReportsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WeatherProvidersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherProvidersTable,
      WeatherProvider,
      $$WeatherProvidersTableFilterComposer,
      $$WeatherProvidersTableOrderingComposer,
      $$WeatherProvidersTableAnnotationComposer,
      $$WeatherProvidersTableCreateCompanionBuilder,
      $$WeatherProvidersTableUpdateCompanionBuilder,
      (WeatherProvider, $$WeatherProvidersTableReferences),
      WeatherProvider,
      PrefetchHooks Function({
        bool weatherObservationsRefs,
        bool weatherForecastsRefs,
        bool waveObservationsRefs,
        bool seaLevelReadingsRefs,
        bool weatherAlertsRefs,
        bool lightningStrikesRefs,
        bool waterQualityReadingsRefs,
        bool algaeReportsRefs,
      })
    >;
typedef $$WeatherStationsTableCreateCompanionBuilder =
    WeatherStationsCompanion Function({
      Value<int> id,
      Value<String?> name,
      required double latitude,
      required double longitude,
      required String stationType,
    });
typedef $$WeatherStationsTableUpdateCompanionBuilder =
    WeatherStationsCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> stationType,
    });

final class $$WeatherStationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WeatherStationsTable, WeatherStation> {
  $$WeatherStationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $WeatherObservationsTable,
    List<WeatherObservation>
  >
  _weatherObservationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.weatherObservations,
        aliasName: 'weather_stations__id__weather_observations__station_id',
      );

  $$WeatherObservationsTableProcessedTableManager get weatherObservationsRefs {
    final manager = $$WeatherObservationsTableTableManager(
      $_db,
      $_db.weatherObservations,
    ).filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _weatherObservationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeatherForecastsTable, List<WeatherForecast>>
  _weatherForecastsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weatherForecasts,
    aliasName: 'weather_stations__id__weather_forecasts__station_id',
  );

  $$WeatherForecastsTableProcessedTableManager get weatherForecastsRefs {
    final manager = $$WeatherForecastsTableTableManager(
      $_db,
      $_db.weatherForecasts,
    ).filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _weatherForecastsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WaveObservationsTable, List<WaveObservation>>
  _waveObservationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.waveObservations,
    aliasName: 'weather_stations__id__wave_observations__station_id',
  );

  $$WaveObservationsTableProcessedTableManager get waveObservationsRefs {
    final manager = $$WaveObservationsTableTableManager(
      $_db,
      $_db.waveObservations,
    ).filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _waveObservationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SeaLevelReadingsTable, List<SeaLevelReading>>
  _seaLevelReadingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.seaLevelReadings,
    aliasName: 'weather_stations__id__sea_level_readings__station_id',
  );

  $$SeaLevelReadingsTableProcessedTableManager get seaLevelReadingsRefs {
    final manager = $$SeaLevelReadingsTableTableManager(
      $_db,
      $_db.seaLevelReadings,
    ).filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _seaLevelReadingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WaterQualityReadingsTable,
    List<WaterQualityReading>
  >
  _waterQualityReadingsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.waterQualityReadings,
        aliasName: 'weather_stations__id__water_quality_readings__station_id',
      );

  $$WaterQualityReadingsTableProcessedTableManager
  get waterQualityReadingsRefs {
    final manager = $$WaterQualityReadingsTableTableManager(
      $_db,
      $_db.waterQualityReadings,
    ).filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _waterQualityReadingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AlgaeReportsTable, List<AlgaeReport>>
  _algaeReportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.algaeReports,
    aliasName: 'weather_stations__id__algae_reports__station_id',
  );

  $$AlgaeReportsTableProcessedTableManager get algaeReportsRefs {
    final manager = $$AlgaeReportsTableTableManager(
      $_db,
      $_db.algaeReports,
    ).filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_algaeReportsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeatherStationsTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherStationsTable> {
  $$WeatherStationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stationType => $composableBuilder(
    column: $table.stationType,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> weatherObservationsRefs(
    Expression<bool> Function($$WeatherObservationsTableFilterComposer f) f,
  ) {
    final $$WeatherObservationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weatherObservations,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherObservationsTableFilterComposer(
            $db: $db,
            $table: $db.weatherObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weatherForecastsRefs(
    Expression<bool> Function($$WeatherForecastsTableFilterComposer f) f,
  ) {
    final $$WeatherForecastsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weatherForecasts,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherForecastsTableFilterComposer(
            $db: $db,
            $table: $db.weatherForecasts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> waveObservationsRefs(
    Expression<bool> Function($$WaveObservationsTableFilterComposer f) f,
  ) {
    final $$WaveObservationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waveObservations,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaveObservationsTableFilterComposer(
            $db: $db,
            $table: $db.waveObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> seaLevelReadingsRefs(
    Expression<bool> Function($$SeaLevelReadingsTableFilterComposer f) f,
  ) {
    final $$SeaLevelReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seaLevelReadings,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeaLevelReadingsTableFilterComposer(
            $db: $db,
            $table: $db.seaLevelReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> waterQualityReadingsRefs(
    Expression<bool> Function($$WaterQualityReadingsTableFilterComposer f) f,
  ) {
    final $$WaterQualityReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waterQualityReadings,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaterQualityReadingsTableFilterComposer(
            $db: $db,
            $table: $db.waterQualityReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> algaeReportsRefs(
    Expression<bool> Function($$AlgaeReportsTableFilterComposer f) f,
  ) {
    final $$AlgaeReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.algaeReports,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlgaeReportsTableFilterComposer(
            $db: $db,
            $table: $db.algaeReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeatherStationsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherStationsTable> {
  $$WeatherStationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stationType => $composableBuilder(
    column: $table.stationType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeatherStationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherStationsTable> {
  $$WeatherStationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get stationType => $composableBuilder(
    column: $table.stationType,
    builder: (column) => column,
  );

  Expression<T> weatherObservationsRefs<T extends Object>(
    Expression<T> Function($$WeatherObservationsTableAnnotationComposer a) f,
  ) {
    final $$WeatherObservationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.weatherObservations,
          getReferencedColumn: (t) => t.stationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WeatherObservationsTableAnnotationComposer(
                $db: $db,
                $table: $db.weatherObservations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> weatherForecastsRefs<T extends Object>(
    Expression<T> Function($$WeatherForecastsTableAnnotationComposer a) f,
  ) {
    final $$WeatherForecastsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.weatherForecasts,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherForecastsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherForecasts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> waveObservationsRefs<T extends Object>(
    Expression<T> Function($$WaveObservationsTableAnnotationComposer a) f,
  ) {
    final $$WaveObservationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waveObservations,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaveObservationsTableAnnotationComposer(
            $db: $db,
            $table: $db.waveObservations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> seaLevelReadingsRefs<T extends Object>(
    Expression<T> Function($$SeaLevelReadingsTableAnnotationComposer a) f,
  ) {
    final $$SeaLevelReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seaLevelReadings,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SeaLevelReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.seaLevelReadings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> waterQualityReadingsRefs<T extends Object>(
    Expression<T> Function($$WaterQualityReadingsTableAnnotationComposer a) f,
  ) {
    final $$WaterQualityReadingsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.waterQualityReadings,
          getReferencedColumn: (t) => t.stationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WaterQualityReadingsTableAnnotationComposer(
                $db: $db,
                $table: $db.waterQualityReadings,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> algaeReportsRefs<T extends Object>(
    Expression<T> Function($$AlgaeReportsTableAnnotationComposer a) f,
  ) {
    final $$AlgaeReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.algaeReports,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AlgaeReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.algaeReports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeatherStationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherStationsTable,
          WeatherStation,
          $$WeatherStationsTableFilterComposer,
          $$WeatherStationsTableOrderingComposer,
          $$WeatherStationsTableAnnotationComposer,
          $$WeatherStationsTableCreateCompanionBuilder,
          $$WeatherStationsTableUpdateCompanionBuilder,
          (WeatherStation, $$WeatherStationsTableReferences),
          WeatherStation,
          PrefetchHooks Function({
            bool weatherObservationsRefs,
            bool weatherForecastsRefs,
            bool waveObservationsRefs,
            bool seaLevelReadingsRefs,
            bool waterQualityReadingsRefs,
            bool algaeReportsRefs,
          })
        > {
  $$WeatherStationsTableTableManager(
    _$AppDatabase db,
    $WeatherStationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeatherStationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeatherStationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeatherStationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> stationType = const Value.absent(),
              }) => WeatherStationsCompanion(
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
                stationType: stationType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                required double latitude,
                required double longitude,
                required String stationType,
              }) => WeatherStationsCompanion.insert(
                id: id,
                name: name,
                latitude: latitude,
                longitude: longitude,
                stationType: stationType,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeatherStationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                weatherObservationsRefs = false,
                weatherForecastsRefs = false,
                waveObservationsRefs = false,
                seaLevelReadingsRefs = false,
                waterQualityReadingsRefs = false,
                algaeReportsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (weatherObservationsRefs) db.weatherObservations,
                    if (weatherForecastsRefs) db.weatherForecasts,
                    if (waveObservationsRefs) db.waveObservations,
                    if (seaLevelReadingsRefs) db.seaLevelReadings,
                    if (waterQualityReadingsRefs) db.waterQualityReadings,
                    if (algaeReportsRefs) db.algaeReports,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (weatherObservationsRefs)
                        await $_getPrefetchedData<
                          WeatherStation,
                          $WeatherStationsTable,
                          WeatherObservation
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherStationsTableReferences
                              ._weatherObservationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherStationsTableReferences(
                                db,
                                table,
                                p0,
                              ).weatherObservationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.stationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (weatherForecastsRefs)
                        await $_getPrefetchedData<
                          WeatherStation,
                          $WeatherStationsTable,
                          WeatherForecast
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherStationsTableReferences
                              ._weatherForecastsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherStationsTableReferences(
                                db,
                                table,
                                p0,
                              ).weatherForecastsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.stationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (waveObservationsRefs)
                        await $_getPrefetchedData<
                          WeatherStation,
                          $WeatherStationsTable,
                          WaveObservation
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherStationsTableReferences
                              ._waveObservationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherStationsTableReferences(
                                db,
                                table,
                                p0,
                              ).waveObservationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.stationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (seaLevelReadingsRefs)
                        await $_getPrefetchedData<
                          WeatherStation,
                          $WeatherStationsTable,
                          SeaLevelReading
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherStationsTableReferences
                              ._seaLevelReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherStationsTableReferences(
                                db,
                                table,
                                p0,
                              ).seaLevelReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.stationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (waterQualityReadingsRefs)
                        await $_getPrefetchedData<
                          WeatherStation,
                          $WeatherStationsTable,
                          WaterQualityReading
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherStationsTableReferences
                              ._waterQualityReadingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherStationsTableReferences(
                                db,
                                table,
                                p0,
                              ).waterQualityReadingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.stationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (algaeReportsRefs)
                        await $_getPrefetchedData<
                          WeatherStation,
                          $WeatherStationsTable,
                          AlgaeReport
                        >(
                          currentTable: table,
                          referencedTable: $$WeatherStationsTableReferences
                              ._algaeReportsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeatherStationsTableReferences(
                                db,
                                table,
                                p0,
                              ).algaeReportsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.stationId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WeatherStationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherStationsTable,
      WeatherStation,
      $$WeatherStationsTableFilterComposer,
      $$WeatherStationsTableOrderingComposer,
      $$WeatherStationsTableAnnotationComposer,
      $$WeatherStationsTableCreateCompanionBuilder,
      $$WeatherStationsTableUpdateCompanionBuilder,
      (WeatherStation, $$WeatherStationsTableReferences),
      WeatherStation,
      PrefetchHooks Function({
        bool weatherObservationsRefs,
        bool weatherForecastsRefs,
        bool waveObservationsRefs,
        bool seaLevelReadingsRefs,
        bool waterQualityReadingsRefs,
        bool algaeReportsRefs,
      })
    >;
typedef $$WeatherObservationsTableCreateCompanionBuilder =
    WeatherObservationsCompanion Function({
      Value<int> id,
      required int stationId,
      required int providerId,
      required DateTime timestamp,
      required DateTime fetchedAt,
      Value<double?> temperature,
      Value<double?> windSpeed,
      Value<double?> windGust,
      Value<double?> windDirection,
      Value<double?> pressure,
      Value<double?> humidity,
      Value<double?> precipitation,
      Value<double?> cloudCover,
      Value<double?> feelsLike,
      Value<double?> dewPoint,
      Value<double?> visibility,
      Value<double?> uvIndex,
      Value<double?> snowfall,
      Value<int?> weatherCode,
      Value<String?> weatherIcon,
      Value<String?> weatherDescription,
      Value<DateTime?> sunrise,
      Value<DateTime?> sunset,
    });
typedef $$WeatherObservationsTableUpdateCompanionBuilder =
    WeatherObservationsCompanion Function({
      Value<int> id,
      Value<int> stationId,
      Value<int> providerId,
      Value<DateTime> timestamp,
      Value<DateTime> fetchedAt,
      Value<double?> temperature,
      Value<double?> windSpeed,
      Value<double?> windGust,
      Value<double?> windDirection,
      Value<double?> pressure,
      Value<double?> humidity,
      Value<double?> precipitation,
      Value<double?> cloudCover,
      Value<double?> feelsLike,
      Value<double?> dewPoint,
      Value<double?> visibility,
      Value<double?> uvIndex,
      Value<double?> snowfall,
      Value<int?> weatherCode,
      Value<String?> weatherIcon,
      Value<String?> weatherDescription,
      Value<DateTime?> sunrise,
      Value<DateTime?> sunset,
    });

final class $$WeatherObservationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WeatherObservationsTable,
          WeatherObservation
        > {
  $$WeatherObservationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeatherStationsTable _stationIdTable(_$AppDatabase db) => db
      .weatherStations
      .createAlias('weather_observations__station_id__weather_stations__id');

  $$WeatherStationsTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$WeatherStationsTableTableManager(
      $_db,
      $_db.weatherStations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WeatherProvidersTable _providerIdTable(_$AppDatabase db) => db
      .weatherProviders
      .createAlias('weather_observations__provider_id__weather_providers__id');

  $$WeatherProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$WeatherProvidersTableTableManager(
      $_db,
      $_db.weatherProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeatherObservationsTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherObservationsTable> {
  $$WeatherObservationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windSpeed => $composableBuilder(
    column: $table.windSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windGust => $composableBuilder(
    column: $table.windGust,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressure => $composableBuilder(
    column: $table.pressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precipitation => $composableBuilder(
    column: $table.precipitation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cloudCover => $composableBuilder(
    column: $table.cloudCover,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get feelsLike => $composableBuilder(
    column: $table.feelsLike,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dewPoint => $composableBuilder(
    column: $table.dewPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get uvIndex => $composableBuilder(
    column: $table.uvIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get snowfall => $composableBuilder(
    column: $table.snowfall,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weatherCode => $composableBuilder(
    column: $table.weatherCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sunrise => $composableBuilder(
    column: $table.sunrise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sunset => $composableBuilder(
    column: $table.sunset,
    builder: (column) => ColumnFilters(column),
  );

  $$WeatherStationsTableFilterComposer get stationId {
    final $$WeatherStationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableFilterComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableFilterComposer get providerId {
    final $$WeatherProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableFilterComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherObservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherObservationsTable> {
  $$WeatherObservationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windSpeed => $composableBuilder(
    column: $table.windSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windGust => $composableBuilder(
    column: $table.windGust,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressure => $composableBuilder(
    column: $table.pressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precipitation => $composableBuilder(
    column: $table.precipitation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cloudCover => $composableBuilder(
    column: $table.cloudCover,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get feelsLike => $composableBuilder(
    column: $table.feelsLike,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dewPoint => $composableBuilder(
    column: $table.dewPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get uvIndex => $composableBuilder(
    column: $table.uvIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get snowfall => $composableBuilder(
    column: $table.snowfall,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weatherCode => $composableBuilder(
    column: $table.weatherCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sunrise => $composableBuilder(
    column: $table.sunrise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sunset => $composableBuilder(
    column: $table.sunset,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeatherStationsTableOrderingComposer get stationId {
    final $$WeatherStationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableOrderingComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableOrderingComposer get providerId {
    final $$WeatherProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherObservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherObservationsTable> {
  $$WeatherObservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get windSpeed =>
      $composableBuilder(column: $table.windSpeed, builder: (column) => column);

  GeneratedColumn<double> get windGust =>
      $composableBuilder(column: $table.windGust, builder: (column) => column);

  GeneratedColumn<double> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pressure =>
      $composableBuilder(column: $table.pressure, builder: (column) => column);

  GeneratedColumn<double> get humidity =>
      $composableBuilder(column: $table.humidity, builder: (column) => column);

  GeneratedColumn<double> get precipitation => $composableBuilder(
    column: $table.precipitation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cloudCover => $composableBuilder(
    column: $table.cloudCover,
    builder: (column) => column,
  );

  GeneratedColumn<double> get feelsLike =>
      $composableBuilder(column: $table.feelsLike, builder: (column) => column);

  GeneratedColumn<double> get dewPoint =>
      $composableBuilder(column: $table.dewPoint, builder: (column) => column);

  GeneratedColumn<double> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => column,
  );

  GeneratedColumn<double> get uvIndex =>
      $composableBuilder(column: $table.uvIndex, builder: (column) => column);

  GeneratedColumn<double> get snowfall =>
      $composableBuilder(column: $table.snowfall, builder: (column) => column);

  GeneratedColumn<int> get weatherCode => $composableBuilder(
    column: $table.weatherCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sunrise =>
      $composableBuilder(column: $table.sunrise, builder: (column) => column);

  GeneratedColumn<DateTime> get sunset =>
      $composableBuilder(column: $table.sunset, builder: (column) => column);

  $$WeatherStationsTableAnnotationComposer get stationId {
    final $$WeatherStationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableAnnotationComposer get providerId {
    final $$WeatherProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherObservationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherObservationsTable,
          WeatherObservation,
          $$WeatherObservationsTableFilterComposer,
          $$WeatherObservationsTableOrderingComposer,
          $$WeatherObservationsTableAnnotationComposer,
          $$WeatherObservationsTableCreateCompanionBuilder,
          $$WeatherObservationsTableUpdateCompanionBuilder,
          (WeatherObservation, $$WeatherObservationsTableReferences),
          WeatherObservation,
          PrefetchHooks Function({bool stationId, bool providerId})
        > {
  $$WeatherObservationsTableTableManager(
    _$AppDatabase db,
    $WeatherObservationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeatherObservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeatherObservationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WeatherObservationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stationId = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> windSpeed = const Value.absent(),
                Value<double?> windGust = const Value.absent(),
                Value<double?> windDirection = const Value.absent(),
                Value<double?> pressure = const Value.absent(),
                Value<double?> humidity = const Value.absent(),
                Value<double?> precipitation = const Value.absent(),
                Value<double?> cloudCover = const Value.absent(),
                Value<double?> feelsLike = const Value.absent(),
                Value<double?> dewPoint = const Value.absent(),
                Value<double?> visibility = const Value.absent(),
                Value<double?> uvIndex = const Value.absent(),
                Value<double?> snowfall = const Value.absent(),
                Value<int?> weatherCode = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<String?> weatherDescription = const Value.absent(),
                Value<DateTime?> sunrise = const Value.absent(),
                Value<DateTime?> sunset = const Value.absent(),
              }) => WeatherObservationsCompanion(
                id: id,
                stationId: stationId,
                providerId: providerId,
                timestamp: timestamp,
                fetchedAt: fetchedAt,
                temperature: temperature,
                windSpeed: windSpeed,
                windGust: windGust,
                windDirection: windDirection,
                pressure: pressure,
                humidity: humidity,
                precipitation: precipitation,
                cloudCover: cloudCover,
                feelsLike: feelsLike,
                dewPoint: dewPoint,
                visibility: visibility,
                uvIndex: uvIndex,
                snowfall: snowfall,
                weatherCode: weatherCode,
                weatherIcon: weatherIcon,
                weatherDescription: weatherDescription,
                sunrise: sunrise,
                sunset: sunset,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int stationId,
                required int providerId,
                required DateTime timestamp,
                required DateTime fetchedAt,
                Value<double?> temperature = const Value.absent(),
                Value<double?> windSpeed = const Value.absent(),
                Value<double?> windGust = const Value.absent(),
                Value<double?> windDirection = const Value.absent(),
                Value<double?> pressure = const Value.absent(),
                Value<double?> humidity = const Value.absent(),
                Value<double?> precipitation = const Value.absent(),
                Value<double?> cloudCover = const Value.absent(),
                Value<double?> feelsLike = const Value.absent(),
                Value<double?> dewPoint = const Value.absent(),
                Value<double?> visibility = const Value.absent(),
                Value<double?> uvIndex = const Value.absent(),
                Value<double?> snowfall = const Value.absent(),
                Value<int?> weatherCode = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<String?> weatherDescription = const Value.absent(),
                Value<DateTime?> sunrise = const Value.absent(),
                Value<DateTime?> sunset = const Value.absent(),
              }) => WeatherObservationsCompanion.insert(
                id: id,
                stationId: stationId,
                providerId: providerId,
                timestamp: timestamp,
                fetchedAt: fetchedAt,
                temperature: temperature,
                windSpeed: windSpeed,
                windGust: windGust,
                windDirection: windDirection,
                pressure: pressure,
                humidity: humidity,
                precipitation: precipitation,
                cloudCover: cloudCover,
                feelsLike: feelsLike,
                dewPoint: dewPoint,
                visibility: visibility,
                uvIndex: uvIndex,
                snowfall: snowfall,
                weatherCode: weatherCode,
                weatherIcon: weatherIcon,
                weatherDescription: weatherDescription,
                sunrise: sunrise,
                sunset: sunset,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeatherObservationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stationId = false, providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (stationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.stationId,
                                referencedTable:
                                    $$WeatherObservationsTableReferences
                                        ._stationIdTable(db),
                                referencedColumn:
                                    $$WeatherObservationsTableReferences
                                        ._stationIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable:
                                    $$WeatherObservationsTableReferences
                                        ._providerIdTable(db),
                                referencedColumn:
                                    $$WeatherObservationsTableReferences
                                        ._providerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeatherObservationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherObservationsTable,
      WeatherObservation,
      $$WeatherObservationsTableFilterComposer,
      $$WeatherObservationsTableOrderingComposer,
      $$WeatherObservationsTableAnnotationComposer,
      $$WeatherObservationsTableCreateCompanionBuilder,
      $$WeatherObservationsTableUpdateCompanionBuilder,
      (WeatherObservation, $$WeatherObservationsTableReferences),
      WeatherObservation,
      PrefetchHooks Function({bool stationId, bool providerId})
    >;
typedef $$WeatherForecastsTableCreateCompanionBuilder =
    WeatherForecastsCompanion Function({
      Value<int> id,
      required int stationId,
      required int providerId,
      required DateTime forecastTime,
      required DateTime issuedAt,
      required DateTime fetchedAt,
      Value<double?> temperature,
      Value<double?> temperatureMin,
      Value<double?> temperatureMax,
      Value<double?> feelsLike,
      Value<double?> windSpeed,
      Value<double?> windGust,
      Value<double?> windDirection,
      Value<double?> pressure,
      Value<double?> humidity,
      Value<double?> dewPoint,
      Value<double?> precipitation,
      Value<double?> precipitationProbability,
      Value<double?> cloudCover,
      Value<double?> uvIndex,
      Value<String?> weatherIcon,
      Value<String?> weatherDescription,
    });
typedef $$WeatherForecastsTableUpdateCompanionBuilder =
    WeatherForecastsCompanion Function({
      Value<int> id,
      Value<int> stationId,
      Value<int> providerId,
      Value<DateTime> forecastTime,
      Value<DateTime> issuedAt,
      Value<DateTime> fetchedAt,
      Value<double?> temperature,
      Value<double?> temperatureMin,
      Value<double?> temperatureMax,
      Value<double?> feelsLike,
      Value<double?> windSpeed,
      Value<double?> windGust,
      Value<double?> windDirection,
      Value<double?> pressure,
      Value<double?> humidity,
      Value<double?> dewPoint,
      Value<double?> precipitation,
      Value<double?> precipitationProbability,
      Value<double?> cloudCover,
      Value<double?> uvIndex,
      Value<String?> weatherIcon,
      Value<String?> weatherDescription,
    });

final class $$WeatherForecastsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WeatherForecastsTable, WeatherForecast> {
  $$WeatherForecastsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeatherStationsTable _stationIdTable(_$AppDatabase db) => db
      .weatherStations
      .createAlias('weather_forecasts__station_id__weather_stations__id');

  $$WeatherStationsTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$WeatherStationsTableTableManager(
      $_db,
      $_db.weatherStations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WeatherProvidersTable _providerIdTable(_$AppDatabase db) => db
      .weatherProviders
      .createAlias('weather_forecasts__provider_id__weather_providers__id');

  $$WeatherProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$WeatherProvidersTableTableManager(
      $_db,
      $_db.weatherProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeatherForecastsTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherForecastsTable> {
  $$WeatherForecastsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get forecastTime => $composableBuilder(
    column: $table.forecastTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperatureMin => $composableBuilder(
    column: $table.temperatureMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperatureMax => $composableBuilder(
    column: $table.temperatureMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get feelsLike => $composableBuilder(
    column: $table.feelsLike,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windSpeed => $composableBuilder(
    column: $table.windSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windGust => $composableBuilder(
    column: $table.windGust,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressure => $composableBuilder(
    column: $table.pressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dewPoint => $composableBuilder(
    column: $table.dewPoint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precipitation => $composableBuilder(
    column: $table.precipitation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precipitationProbability => $composableBuilder(
    column: $table.precipitationProbability,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cloudCover => $composableBuilder(
    column: $table.cloudCover,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get uvIndex => $composableBuilder(
    column: $table.uvIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => ColumnFilters(column),
  );

  $$WeatherStationsTableFilterComposer get stationId {
    final $$WeatherStationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableFilterComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableFilterComposer get providerId {
    final $$WeatherProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableFilterComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherForecastsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherForecastsTable> {
  $$WeatherForecastsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get forecastTime => $composableBuilder(
    column: $table.forecastTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperatureMin => $composableBuilder(
    column: $table.temperatureMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperatureMax => $composableBuilder(
    column: $table.temperatureMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get feelsLike => $composableBuilder(
    column: $table.feelsLike,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windSpeed => $composableBuilder(
    column: $table.windSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windGust => $composableBuilder(
    column: $table.windGust,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressure => $composableBuilder(
    column: $table.pressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dewPoint => $composableBuilder(
    column: $table.dewPoint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precipitation => $composableBuilder(
    column: $table.precipitation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precipitationProbability => $composableBuilder(
    column: $table.precipitationProbability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cloudCover => $composableBuilder(
    column: $table.cloudCover,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get uvIndex => $composableBuilder(
    column: $table.uvIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeatherStationsTableOrderingComposer get stationId {
    final $$WeatherStationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableOrderingComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableOrderingComposer get providerId {
    final $$WeatherProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherForecastsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherForecastsTable> {
  $$WeatherForecastsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get forecastTime => $composableBuilder(
    column: $table.forecastTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<double> get temperatureMin => $composableBuilder(
    column: $table.temperatureMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get temperatureMax => $composableBuilder(
    column: $table.temperatureMax,
    builder: (column) => column,
  );

  GeneratedColumn<double> get feelsLike =>
      $composableBuilder(column: $table.feelsLike, builder: (column) => column);

  GeneratedColumn<double> get windSpeed =>
      $composableBuilder(column: $table.windSpeed, builder: (column) => column);

  GeneratedColumn<double> get windGust =>
      $composableBuilder(column: $table.windGust, builder: (column) => column);

  GeneratedColumn<double> get windDirection => $composableBuilder(
    column: $table.windDirection,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pressure =>
      $composableBuilder(column: $table.pressure, builder: (column) => column);

  GeneratedColumn<double> get humidity =>
      $composableBuilder(column: $table.humidity, builder: (column) => column);

  GeneratedColumn<double> get dewPoint =>
      $composableBuilder(column: $table.dewPoint, builder: (column) => column);

  GeneratedColumn<double> get precipitation => $composableBuilder(
    column: $table.precipitation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precipitationProbability => $composableBuilder(
    column: $table.precipitationProbability,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cloudCover => $composableBuilder(
    column: $table.cloudCover,
    builder: (column) => column,
  );

  GeneratedColumn<double> get uvIndex =>
      $composableBuilder(column: $table.uvIndex, builder: (column) => column);

  GeneratedColumn<String> get weatherIcon => $composableBuilder(
    column: $table.weatherIcon,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weatherDescription => $composableBuilder(
    column: $table.weatherDescription,
    builder: (column) => column,
  );

  $$WeatherStationsTableAnnotationComposer get stationId {
    final $$WeatherStationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableAnnotationComposer get providerId {
    final $$WeatherProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherForecastsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherForecastsTable,
          WeatherForecast,
          $$WeatherForecastsTableFilterComposer,
          $$WeatherForecastsTableOrderingComposer,
          $$WeatherForecastsTableAnnotationComposer,
          $$WeatherForecastsTableCreateCompanionBuilder,
          $$WeatherForecastsTableUpdateCompanionBuilder,
          (WeatherForecast, $$WeatherForecastsTableReferences),
          WeatherForecast,
          PrefetchHooks Function({bool stationId, bool providerId})
        > {
  $$WeatherForecastsTableTableManager(
    _$AppDatabase db,
    $WeatherForecastsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeatherForecastsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeatherForecastsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeatherForecastsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stationId = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<DateTime> forecastTime = const Value.absent(),
                Value<DateTime> issuedAt = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<double?> temperature = const Value.absent(),
                Value<double?> temperatureMin = const Value.absent(),
                Value<double?> temperatureMax = const Value.absent(),
                Value<double?> feelsLike = const Value.absent(),
                Value<double?> windSpeed = const Value.absent(),
                Value<double?> windGust = const Value.absent(),
                Value<double?> windDirection = const Value.absent(),
                Value<double?> pressure = const Value.absent(),
                Value<double?> humidity = const Value.absent(),
                Value<double?> dewPoint = const Value.absent(),
                Value<double?> precipitation = const Value.absent(),
                Value<double?> precipitationProbability = const Value.absent(),
                Value<double?> cloudCover = const Value.absent(),
                Value<double?> uvIndex = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<String?> weatherDescription = const Value.absent(),
              }) => WeatherForecastsCompanion(
                id: id,
                stationId: stationId,
                providerId: providerId,
                forecastTime: forecastTime,
                issuedAt: issuedAt,
                fetchedAt: fetchedAt,
                temperature: temperature,
                temperatureMin: temperatureMin,
                temperatureMax: temperatureMax,
                feelsLike: feelsLike,
                windSpeed: windSpeed,
                windGust: windGust,
                windDirection: windDirection,
                pressure: pressure,
                humidity: humidity,
                dewPoint: dewPoint,
                precipitation: precipitation,
                precipitationProbability: precipitationProbability,
                cloudCover: cloudCover,
                uvIndex: uvIndex,
                weatherIcon: weatherIcon,
                weatherDescription: weatherDescription,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int stationId,
                required int providerId,
                required DateTime forecastTime,
                required DateTime issuedAt,
                required DateTime fetchedAt,
                Value<double?> temperature = const Value.absent(),
                Value<double?> temperatureMin = const Value.absent(),
                Value<double?> temperatureMax = const Value.absent(),
                Value<double?> feelsLike = const Value.absent(),
                Value<double?> windSpeed = const Value.absent(),
                Value<double?> windGust = const Value.absent(),
                Value<double?> windDirection = const Value.absent(),
                Value<double?> pressure = const Value.absent(),
                Value<double?> humidity = const Value.absent(),
                Value<double?> dewPoint = const Value.absent(),
                Value<double?> precipitation = const Value.absent(),
                Value<double?> precipitationProbability = const Value.absent(),
                Value<double?> cloudCover = const Value.absent(),
                Value<double?> uvIndex = const Value.absent(),
                Value<String?> weatherIcon = const Value.absent(),
                Value<String?> weatherDescription = const Value.absent(),
              }) => WeatherForecastsCompanion.insert(
                id: id,
                stationId: stationId,
                providerId: providerId,
                forecastTime: forecastTime,
                issuedAt: issuedAt,
                fetchedAt: fetchedAt,
                temperature: temperature,
                temperatureMin: temperatureMin,
                temperatureMax: temperatureMax,
                feelsLike: feelsLike,
                windSpeed: windSpeed,
                windGust: windGust,
                windDirection: windDirection,
                pressure: pressure,
                humidity: humidity,
                dewPoint: dewPoint,
                precipitation: precipitation,
                precipitationProbability: precipitationProbability,
                cloudCover: cloudCover,
                uvIndex: uvIndex,
                weatherIcon: weatherIcon,
                weatherDescription: weatherDescription,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeatherForecastsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stationId = false, providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (stationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.stationId,
                                referencedTable:
                                    $$WeatherForecastsTableReferences
                                        ._stationIdTable(db),
                                referencedColumn:
                                    $$WeatherForecastsTableReferences
                                        ._stationIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable:
                                    $$WeatherForecastsTableReferences
                                        ._providerIdTable(db),
                                referencedColumn:
                                    $$WeatherForecastsTableReferences
                                        ._providerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeatherForecastsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherForecastsTable,
      WeatherForecast,
      $$WeatherForecastsTableFilterComposer,
      $$WeatherForecastsTableOrderingComposer,
      $$WeatherForecastsTableAnnotationComposer,
      $$WeatherForecastsTableCreateCompanionBuilder,
      $$WeatherForecastsTableUpdateCompanionBuilder,
      (WeatherForecast, $$WeatherForecastsTableReferences),
      WeatherForecast,
      PrefetchHooks Function({bool stationId, bool providerId})
    >;
typedef $$WaveObservationsTableCreateCompanionBuilder =
    WaveObservationsCompanion Function({
      Value<int> id,
      required int stationId,
      required int providerId,
      required DateTime timestamp,
      required DateTime fetchedAt,
      Value<double?> waveHeight,
      Value<double?> wavePeriod,
      Value<double?> waveDirection,
      Value<double?> waterTemperature,
    });
typedef $$WaveObservationsTableUpdateCompanionBuilder =
    WaveObservationsCompanion Function({
      Value<int> id,
      Value<int> stationId,
      Value<int> providerId,
      Value<DateTime> timestamp,
      Value<DateTime> fetchedAt,
      Value<double?> waveHeight,
      Value<double?> wavePeriod,
      Value<double?> waveDirection,
      Value<double?> waterTemperature,
    });

final class $$WaveObservationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WaveObservationsTable, WaveObservation> {
  $$WaveObservationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeatherStationsTable _stationIdTable(_$AppDatabase db) => db
      .weatherStations
      .createAlias('wave_observations__station_id__weather_stations__id');

  $$WeatherStationsTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$WeatherStationsTableTableManager(
      $_db,
      $_db.weatherStations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WeatherProvidersTable _providerIdTable(_$AppDatabase db) => db
      .weatherProviders
      .createAlias('wave_observations__provider_id__weather_providers__id');

  $$WeatherProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$WeatherProvidersTableTableManager(
      $_db,
      $_db.weatherProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WaveObservationsTableFilterComposer
    extends Composer<_$AppDatabase, $WaveObservationsTable> {
  $$WaveObservationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waveHeight => $composableBuilder(
    column: $table.waveHeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wavePeriod => $composableBuilder(
    column: $table.wavePeriod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waveDirection => $composableBuilder(
    column: $table.waveDirection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterTemperature => $composableBuilder(
    column: $table.waterTemperature,
    builder: (column) => ColumnFilters(column),
  );

  $$WeatherStationsTableFilterComposer get stationId {
    final $$WeatherStationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableFilterComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableFilterComposer get providerId {
    final $$WeatherProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableFilterComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaveObservationsTableOrderingComposer
    extends Composer<_$AppDatabase, $WaveObservationsTable> {
  $$WaveObservationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waveHeight => $composableBuilder(
    column: $table.waveHeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wavePeriod => $composableBuilder(
    column: $table.wavePeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waveDirection => $composableBuilder(
    column: $table.waveDirection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterTemperature => $composableBuilder(
    column: $table.waterTemperature,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeatherStationsTableOrderingComposer get stationId {
    final $$WeatherStationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableOrderingComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableOrderingComposer get providerId {
    final $$WeatherProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaveObservationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaveObservationsTable> {
  $$WaveObservationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<double> get waveHeight => $composableBuilder(
    column: $table.waveHeight,
    builder: (column) => column,
  );

  GeneratedColumn<double> get wavePeriod => $composableBuilder(
    column: $table.wavePeriod,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waveDirection => $composableBuilder(
    column: $table.waveDirection,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waterTemperature => $composableBuilder(
    column: $table.waterTemperature,
    builder: (column) => column,
  );

  $$WeatherStationsTableAnnotationComposer get stationId {
    final $$WeatherStationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableAnnotationComposer get providerId {
    final $$WeatherProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaveObservationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaveObservationsTable,
          WaveObservation,
          $$WaveObservationsTableFilterComposer,
          $$WaveObservationsTableOrderingComposer,
          $$WaveObservationsTableAnnotationComposer,
          $$WaveObservationsTableCreateCompanionBuilder,
          $$WaveObservationsTableUpdateCompanionBuilder,
          (WaveObservation, $$WaveObservationsTableReferences),
          WaveObservation,
          PrefetchHooks Function({bool stationId, bool providerId})
        > {
  $$WaveObservationsTableTableManager(
    _$AppDatabase db,
    $WaveObservationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaveObservationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaveObservationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaveObservationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stationId = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<double?> waveHeight = const Value.absent(),
                Value<double?> wavePeriod = const Value.absent(),
                Value<double?> waveDirection = const Value.absent(),
                Value<double?> waterTemperature = const Value.absent(),
              }) => WaveObservationsCompanion(
                id: id,
                stationId: stationId,
                providerId: providerId,
                timestamp: timestamp,
                fetchedAt: fetchedAt,
                waveHeight: waveHeight,
                wavePeriod: wavePeriod,
                waveDirection: waveDirection,
                waterTemperature: waterTemperature,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int stationId,
                required int providerId,
                required DateTime timestamp,
                required DateTime fetchedAt,
                Value<double?> waveHeight = const Value.absent(),
                Value<double?> wavePeriod = const Value.absent(),
                Value<double?> waveDirection = const Value.absent(),
                Value<double?> waterTemperature = const Value.absent(),
              }) => WaveObservationsCompanion.insert(
                id: id,
                stationId: stationId,
                providerId: providerId,
                timestamp: timestamp,
                fetchedAt: fetchedAt,
                waveHeight: waveHeight,
                wavePeriod: wavePeriod,
                waveDirection: waveDirection,
                waterTemperature: waterTemperature,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WaveObservationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stationId = false, providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (stationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.stationId,
                                referencedTable:
                                    $$WaveObservationsTableReferences
                                        ._stationIdTable(db),
                                referencedColumn:
                                    $$WaveObservationsTableReferences
                                        ._stationIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable:
                                    $$WaveObservationsTableReferences
                                        ._providerIdTable(db),
                                referencedColumn:
                                    $$WaveObservationsTableReferences
                                        ._providerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WaveObservationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaveObservationsTable,
      WaveObservation,
      $$WaveObservationsTableFilterComposer,
      $$WaveObservationsTableOrderingComposer,
      $$WaveObservationsTableAnnotationComposer,
      $$WaveObservationsTableCreateCompanionBuilder,
      $$WaveObservationsTableUpdateCompanionBuilder,
      (WaveObservation, $$WaveObservationsTableReferences),
      WaveObservation,
      PrefetchHooks Function({bool stationId, bool providerId})
    >;
typedef $$SeaLevelReadingsTableCreateCompanionBuilder =
    SeaLevelReadingsCompanion Function({
      Value<int> id,
      required int stationId,
      required int providerId,
      required DateTime timestamp,
      required DateTime fetchedAt,
      Value<double?> seaLevelMm,
    });
typedef $$SeaLevelReadingsTableUpdateCompanionBuilder =
    SeaLevelReadingsCompanion Function({
      Value<int> id,
      Value<int> stationId,
      Value<int> providerId,
      Value<DateTime> timestamp,
      Value<DateTime> fetchedAt,
      Value<double?> seaLevelMm,
    });

final class $$SeaLevelReadingsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SeaLevelReadingsTable, SeaLevelReading> {
  $$SeaLevelReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeatherStationsTable _stationIdTable(_$AppDatabase db) => db
      .weatherStations
      .createAlias('sea_level_readings__station_id__weather_stations__id');

  $$WeatherStationsTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$WeatherStationsTableTableManager(
      $_db,
      $_db.weatherStations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WeatherProvidersTable _providerIdTable(_$AppDatabase db) => db
      .weatherProviders
      .createAlias('sea_level_readings__provider_id__weather_providers__id');

  $$WeatherProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$WeatherProvidersTableTableManager(
      $_db,
      $_db.weatherProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SeaLevelReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $SeaLevelReadingsTable> {
  $$SeaLevelReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get seaLevelMm => $composableBuilder(
    column: $table.seaLevelMm,
    builder: (column) => ColumnFilters(column),
  );

  $$WeatherStationsTableFilterComposer get stationId {
    final $$WeatherStationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableFilterComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableFilterComposer get providerId {
    final $$WeatherProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableFilterComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeaLevelReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SeaLevelReadingsTable> {
  $$SeaLevelReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get seaLevelMm => $composableBuilder(
    column: $table.seaLevelMm,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeatherStationsTableOrderingComposer get stationId {
    final $$WeatherStationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableOrderingComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableOrderingComposer get providerId {
    final $$WeatherProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeaLevelReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeaLevelReadingsTable> {
  $$SeaLevelReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<double> get seaLevelMm => $composableBuilder(
    column: $table.seaLevelMm,
    builder: (column) => column,
  );

  $$WeatherStationsTableAnnotationComposer get stationId {
    final $$WeatherStationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableAnnotationComposer get providerId {
    final $$WeatherProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SeaLevelReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SeaLevelReadingsTable,
          SeaLevelReading,
          $$SeaLevelReadingsTableFilterComposer,
          $$SeaLevelReadingsTableOrderingComposer,
          $$SeaLevelReadingsTableAnnotationComposer,
          $$SeaLevelReadingsTableCreateCompanionBuilder,
          $$SeaLevelReadingsTableUpdateCompanionBuilder,
          (SeaLevelReading, $$SeaLevelReadingsTableReferences),
          SeaLevelReading,
          PrefetchHooks Function({bool stationId, bool providerId})
        > {
  $$SeaLevelReadingsTableTableManager(
    _$AppDatabase db,
    $SeaLevelReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeaLevelReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeaLevelReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeaLevelReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stationId = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<double?> seaLevelMm = const Value.absent(),
              }) => SeaLevelReadingsCompanion(
                id: id,
                stationId: stationId,
                providerId: providerId,
                timestamp: timestamp,
                fetchedAt: fetchedAt,
                seaLevelMm: seaLevelMm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int stationId,
                required int providerId,
                required DateTime timestamp,
                required DateTime fetchedAt,
                Value<double?> seaLevelMm = const Value.absent(),
              }) => SeaLevelReadingsCompanion.insert(
                id: id,
                stationId: stationId,
                providerId: providerId,
                timestamp: timestamp,
                fetchedAt: fetchedAt,
                seaLevelMm: seaLevelMm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SeaLevelReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stationId = false, providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (stationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.stationId,
                                referencedTable:
                                    $$SeaLevelReadingsTableReferences
                                        ._stationIdTable(db),
                                referencedColumn:
                                    $$SeaLevelReadingsTableReferences
                                        ._stationIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable:
                                    $$SeaLevelReadingsTableReferences
                                        ._providerIdTable(db),
                                referencedColumn:
                                    $$SeaLevelReadingsTableReferences
                                        ._providerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SeaLevelReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SeaLevelReadingsTable,
      SeaLevelReading,
      $$SeaLevelReadingsTableFilterComposer,
      $$SeaLevelReadingsTableOrderingComposer,
      $$SeaLevelReadingsTableAnnotationComposer,
      $$SeaLevelReadingsTableCreateCompanionBuilder,
      $$SeaLevelReadingsTableUpdateCompanionBuilder,
      (SeaLevelReading, $$SeaLevelReadingsTableReferences),
      SeaLevelReading,
      PrefetchHooks Function({bool stationId, bool providerId})
    >;
typedef $$WeatherAlertsTableCreateCompanionBuilder =
    WeatherAlertsCompanion Function({
      Value<int> id,
      required String externalId,
      required int providerId,
      required String event,
      required String description,
      required String severity,
      required DateTime onset,
      required DateTime expires,
      required DateTime fetchedAt,
      required String polygonJson,
      required String areaDescription,
      Value<String?> source,
    });
typedef $$WeatherAlertsTableUpdateCompanionBuilder =
    WeatherAlertsCompanion Function({
      Value<int> id,
      Value<String> externalId,
      Value<int> providerId,
      Value<String> event,
      Value<String> description,
      Value<String> severity,
      Value<DateTime> onset,
      Value<DateTime> expires,
      Value<DateTime> fetchedAt,
      Value<String> polygonJson,
      Value<String> areaDescription,
      Value<String?> source,
    });

final class $$WeatherAlertsTableReferences
    extends BaseReferences<_$AppDatabase, $WeatherAlertsTable, WeatherAlert> {
  $$WeatherAlertsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeatherProvidersTable _providerIdTable(_$AppDatabase db) => db
      .weatherProviders
      .createAlias('weather_alerts__provider_id__weather_providers__id');

  $$WeatherProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$WeatherProvidersTableTableManager(
      $_db,
      $_db.weatherProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeatherAlertsTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherAlertsTable> {
  $$WeatherAlertsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get onset => $composableBuilder(
    column: $table.onset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expires => $composableBuilder(
    column: $table.expires,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get polygonJson => $composableBuilder(
    column: $table.polygonJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get areaDescription => $composableBuilder(
    column: $table.areaDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  $$WeatherProvidersTableFilterComposer get providerId {
    final $$WeatherProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableFilterComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherAlertsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherAlertsTable> {
  $$WeatherAlertsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get onset => $composableBuilder(
    column: $table.onset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expires => $composableBuilder(
    column: $table.expires,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get polygonJson => $composableBuilder(
    column: $table.polygonJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get areaDescription => $composableBuilder(
    column: $table.areaDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeatherProvidersTableOrderingComposer get providerId {
    final $$WeatherProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherAlertsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherAlertsTable> {
  $$WeatherAlertsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
    column: $table.externalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get event =>
      $composableBuilder(column: $table.event, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<DateTime> get onset =>
      $composableBuilder(column: $table.onset, builder: (column) => column);

  GeneratedColumn<DateTime> get expires =>
      $composableBuilder(column: $table.expires, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<String> get polygonJson => $composableBuilder(
    column: $table.polygonJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get areaDescription => $composableBuilder(
    column: $table.areaDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$WeatherProvidersTableAnnotationComposer get providerId {
    final $$WeatherProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeatherAlertsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherAlertsTable,
          WeatherAlert,
          $$WeatherAlertsTableFilterComposer,
          $$WeatherAlertsTableOrderingComposer,
          $$WeatherAlertsTableAnnotationComposer,
          $$WeatherAlertsTableCreateCompanionBuilder,
          $$WeatherAlertsTableUpdateCompanionBuilder,
          (WeatherAlert, $$WeatherAlertsTableReferences),
          WeatherAlert,
          PrefetchHooks Function({bool providerId})
        > {
  $$WeatherAlertsTableTableManager(_$AppDatabase db, $WeatherAlertsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeatherAlertsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeatherAlertsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeatherAlertsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> externalId = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<String> event = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<DateTime> onset = const Value.absent(),
                Value<DateTime> expires = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<String> polygonJson = const Value.absent(),
                Value<String> areaDescription = const Value.absent(),
                Value<String?> source = const Value.absent(),
              }) => WeatherAlertsCompanion(
                id: id,
                externalId: externalId,
                providerId: providerId,
                event: event,
                description: description,
                severity: severity,
                onset: onset,
                expires: expires,
                fetchedAt: fetchedAt,
                polygonJson: polygonJson,
                areaDescription: areaDescription,
                source: source,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String externalId,
                required int providerId,
                required String event,
                required String description,
                required String severity,
                required DateTime onset,
                required DateTime expires,
                required DateTime fetchedAt,
                required String polygonJson,
                required String areaDescription,
                Value<String?> source = const Value.absent(),
              }) => WeatherAlertsCompanion.insert(
                id: id,
                externalId: externalId,
                providerId: providerId,
                event: event,
                description: description,
                severity: severity,
                onset: onset,
                expires: expires,
                fetchedAt: fetchedAt,
                polygonJson: polygonJson,
                areaDescription: areaDescription,
                source: source,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeatherAlertsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable: $$WeatherAlertsTableReferences
                                    ._providerIdTable(db),
                                referencedColumn: $$WeatherAlertsTableReferences
                                    ._providerIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeatherAlertsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherAlertsTable,
      WeatherAlert,
      $$WeatherAlertsTableFilterComposer,
      $$WeatherAlertsTableOrderingComposer,
      $$WeatherAlertsTableAnnotationComposer,
      $$WeatherAlertsTableCreateCompanionBuilder,
      $$WeatherAlertsTableUpdateCompanionBuilder,
      (WeatherAlert, $$WeatherAlertsTableReferences),
      WeatherAlert,
      PrefetchHooks Function({bool providerId})
    >;
typedef $$LightningStrikesTableCreateCompanionBuilder =
    LightningStrikesCompanion Function({
      Value<int> id,
      required int providerId,
      required DateTime strikeTime,
      required DateTime fetchedAt,
      required double latitude,
      required double longitude,
      required double peakCurrentKa,
      required int multiplicity,
      Value<bool?> cloudToGround,
    });
typedef $$LightningStrikesTableUpdateCompanionBuilder =
    LightningStrikesCompanion Function({
      Value<int> id,
      Value<int> providerId,
      Value<DateTime> strikeTime,
      Value<DateTime> fetchedAt,
      Value<double> latitude,
      Value<double> longitude,
      Value<double> peakCurrentKa,
      Value<int> multiplicity,
      Value<bool?> cloudToGround,
    });

final class $$LightningStrikesTableReferences
    extends
        BaseReferences<_$AppDatabase, $LightningStrikesTable, LightningStrike> {
  $$LightningStrikesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeatherProvidersTable _providerIdTable(_$AppDatabase db) => db
      .weatherProviders
      .createAlias('lightning_strikes__provider_id__weather_providers__id');

  $$WeatherProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$WeatherProvidersTableTableManager(
      $_db,
      $_db.weatherProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LightningStrikesTableFilterComposer
    extends Composer<_$AppDatabase, $LightningStrikesTable> {
  $$LightningStrikesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get strikeTime => $composableBuilder(
    column: $table.strikeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get peakCurrentKa => $composableBuilder(
    column: $table.peakCurrentKa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get multiplicity => $composableBuilder(
    column: $table.multiplicity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cloudToGround => $composableBuilder(
    column: $table.cloudToGround,
    builder: (column) => ColumnFilters(column),
  );

  $$WeatherProvidersTableFilterComposer get providerId {
    final $$WeatherProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableFilterComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LightningStrikesTableOrderingComposer
    extends Composer<_$AppDatabase, $LightningStrikesTable> {
  $$LightningStrikesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get strikeTime => $composableBuilder(
    column: $table.strikeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get peakCurrentKa => $composableBuilder(
    column: $table.peakCurrentKa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get multiplicity => $composableBuilder(
    column: $table.multiplicity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cloudToGround => $composableBuilder(
    column: $table.cloudToGround,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeatherProvidersTableOrderingComposer get providerId {
    final $$WeatherProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LightningStrikesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LightningStrikesTable> {
  $$LightningStrikesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get strikeTime => $composableBuilder(
    column: $table.strikeTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get peakCurrentKa => $composableBuilder(
    column: $table.peakCurrentKa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get multiplicity => $composableBuilder(
    column: $table.multiplicity,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cloudToGround => $composableBuilder(
    column: $table.cloudToGround,
    builder: (column) => column,
  );

  $$WeatherProvidersTableAnnotationComposer get providerId {
    final $$WeatherProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LightningStrikesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LightningStrikesTable,
          LightningStrike,
          $$LightningStrikesTableFilterComposer,
          $$LightningStrikesTableOrderingComposer,
          $$LightningStrikesTableAnnotationComposer,
          $$LightningStrikesTableCreateCompanionBuilder,
          $$LightningStrikesTableUpdateCompanionBuilder,
          (LightningStrike, $$LightningStrikesTableReferences),
          LightningStrike,
          PrefetchHooks Function({bool providerId})
        > {
  $$LightningStrikesTableTableManager(
    _$AppDatabase db,
    $LightningStrikesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LightningStrikesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LightningStrikesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LightningStrikesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<DateTime> strikeTime = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> peakCurrentKa = const Value.absent(),
                Value<int> multiplicity = const Value.absent(),
                Value<bool?> cloudToGround = const Value.absent(),
              }) => LightningStrikesCompanion(
                id: id,
                providerId: providerId,
                strikeTime: strikeTime,
                fetchedAt: fetchedAt,
                latitude: latitude,
                longitude: longitude,
                peakCurrentKa: peakCurrentKa,
                multiplicity: multiplicity,
                cloudToGround: cloudToGround,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int providerId,
                required DateTime strikeTime,
                required DateTime fetchedAt,
                required double latitude,
                required double longitude,
                required double peakCurrentKa,
                required int multiplicity,
                Value<bool?> cloudToGround = const Value.absent(),
              }) => LightningStrikesCompanion.insert(
                id: id,
                providerId: providerId,
                strikeTime: strikeTime,
                fetchedAt: fetchedAt,
                latitude: latitude,
                longitude: longitude,
                peakCurrentKa: peakCurrentKa,
                multiplicity: multiplicity,
                cloudToGround: cloudToGround,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LightningStrikesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable:
                                    $$LightningStrikesTableReferences
                                        ._providerIdTable(db),
                                referencedColumn:
                                    $$LightningStrikesTableReferences
                                        ._providerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LightningStrikesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LightningStrikesTable,
      LightningStrike,
      $$LightningStrikesTableFilterComposer,
      $$LightningStrikesTableOrderingComposer,
      $$LightningStrikesTableAnnotationComposer,
      $$LightningStrikesTableCreateCompanionBuilder,
      $$LightningStrikesTableUpdateCompanionBuilder,
      (LightningStrike, $$LightningStrikesTableReferences),
      LightningStrike,
      PrefetchHooks Function({bool providerId})
    >;
typedef $$WaterQualityReadingsTableCreateCompanionBuilder =
    WaterQualityReadingsCompanion Function({
      Value<int> id,
      required int stationId,
      required DateTime sampleTime,
      required DateTime fetchedAt,
      required int providerId,
      Value<double?> dissolvedOxygen,
      Value<double?> pH,
      Value<double?> chlorophyllA,
      Value<double?> turbidity,
      Value<double?> sampleDepth,
      Value<String?> lab,
    });
typedef $$WaterQualityReadingsTableUpdateCompanionBuilder =
    WaterQualityReadingsCompanion Function({
      Value<int> id,
      Value<int> stationId,
      Value<DateTime> sampleTime,
      Value<DateTime> fetchedAt,
      Value<int> providerId,
      Value<double?> dissolvedOxygen,
      Value<double?> pH,
      Value<double?> chlorophyllA,
      Value<double?> turbidity,
      Value<double?> sampleDepth,
      Value<String?> lab,
    });

final class $$WaterQualityReadingsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WaterQualityReadingsTable,
          WaterQualityReading
        > {
  $$WaterQualityReadingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeatherStationsTable _stationIdTable(_$AppDatabase db) => db
      .weatherStations
      .createAlias('water_quality_readings__station_id__weather_stations__id');

  $$WeatherStationsTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$WeatherStationsTableTableManager(
      $_db,
      $_db.weatherStations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WeatherProvidersTable _providerIdTable(_$AppDatabase db) =>
      db.weatherProviders.createAlias(
        'water_quality_readings__provider_id__weather_providers__id',
      );

  $$WeatherProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$WeatherProvidersTableTableManager(
      $_db,
      $_db.weatherProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WaterQualityReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $WaterQualityReadingsTable> {
  $$WaterQualityReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sampleTime => $composableBuilder(
    column: $table.sampleTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dissolvedOxygen => $composableBuilder(
    column: $table.dissolvedOxygen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pH => $composableBuilder(
    column: $table.pH,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chlorophyllA => $composableBuilder(
    column: $table.chlorophyllA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get turbidity => $composableBuilder(
    column: $table.turbidity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sampleDepth => $composableBuilder(
    column: $table.sampleDepth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lab => $composableBuilder(
    column: $table.lab,
    builder: (column) => ColumnFilters(column),
  );

  $$WeatherStationsTableFilterComposer get stationId {
    final $$WeatherStationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableFilterComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableFilterComposer get providerId {
    final $$WeatherProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableFilterComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterQualityReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterQualityReadingsTable> {
  $$WaterQualityReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sampleTime => $composableBuilder(
    column: $table.sampleTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dissolvedOxygen => $composableBuilder(
    column: $table.dissolvedOxygen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pH => $composableBuilder(
    column: $table.pH,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chlorophyllA => $composableBuilder(
    column: $table.chlorophyllA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get turbidity => $composableBuilder(
    column: $table.turbidity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sampleDepth => $composableBuilder(
    column: $table.sampleDepth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lab => $composableBuilder(
    column: $table.lab,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeatherStationsTableOrderingComposer get stationId {
    final $$WeatherStationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableOrderingComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableOrderingComposer get providerId {
    final $$WeatherProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterQualityReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterQualityReadingsTable> {
  $$WaterQualityReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get sampleTime => $composableBuilder(
    column: $table.sampleTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<double> get dissolvedOxygen => $composableBuilder(
    column: $table.dissolvedOxygen,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pH =>
      $composableBuilder(column: $table.pH, builder: (column) => column);

  GeneratedColumn<double> get chlorophyllA => $composableBuilder(
    column: $table.chlorophyllA,
    builder: (column) => column,
  );

  GeneratedColumn<double> get turbidity =>
      $composableBuilder(column: $table.turbidity, builder: (column) => column);

  GeneratedColumn<double> get sampleDepth => $composableBuilder(
    column: $table.sampleDepth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lab =>
      $composableBuilder(column: $table.lab, builder: (column) => column);

  $$WeatherStationsTableAnnotationComposer get stationId {
    final $$WeatherStationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableAnnotationComposer get providerId {
    final $$WeatherProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaterQualityReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaterQualityReadingsTable,
          WaterQualityReading,
          $$WaterQualityReadingsTableFilterComposer,
          $$WaterQualityReadingsTableOrderingComposer,
          $$WaterQualityReadingsTableAnnotationComposer,
          $$WaterQualityReadingsTableCreateCompanionBuilder,
          $$WaterQualityReadingsTableUpdateCompanionBuilder,
          (WaterQualityReading, $$WaterQualityReadingsTableReferences),
          WaterQualityReading,
          PrefetchHooks Function({bool stationId, bool providerId})
        > {
  $$WaterQualityReadingsTableTableManager(
    _$AppDatabase db,
    $WaterQualityReadingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaterQualityReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaterQualityReadingsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WaterQualityReadingsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stationId = const Value.absent(),
                Value<DateTime> sampleTime = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<double?> dissolvedOxygen = const Value.absent(),
                Value<double?> pH = const Value.absent(),
                Value<double?> chlorophyllA = const Value.absent(),
                Value<double?> turbidity = const Value.absent(),
                Value<double?> sampleDepth = const Value.absent(),
                Value<String?> lab = const Value.absent(),
              }) => WaterQualityReadingsCompanion(
                id: id,
                stationId: stationId,
                sampleTime: sampleTime,
                fetchedAt: fetchedAt,
                providerId: providerId,
                dissolvedOxygen: dissolvedOxygen,
                pH: pH,
                chlorophyllA: chlorophyllA,
                turbidity: turbidity,
                sampleDepth: sampleDepth,
                lab: lab,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int stationId,
                required DateTime sampleTime,
                required DateTime fetchedAt,
                required int providerId,
                Value<double?> dissolvedOxygen = const Value.absent(),
                Value<double?> pH = const Value.absent(),
                Value<double?> chlorophyllA = const Value.absent(),
                Value<double?> turbidity = const Value.absent(),
                Value<double?> sampleDepth = const Value.absent(),
                Value<String?> lab = const Value.absent(),
              }) => WaterQualityReadingsCompanion.insert(
                id: id,
                stationId: stationId,
                sampleTime: sampleTime,
                fetchedAt: fetchedAt,
                providerId: providerId,
                dissolvedOxygen: dissolvedOxygen,
                pH: pH,
                chlorophyllA: chlorophyllA,
                turbidity: turbidity,
                sampleDepth: sampleDepth,
                lab: lab,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WaterQualityReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stationId = false, providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (stationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.stationId,
                                referencedTable:
                                    $$WaterQualityReadingsTableReferences
                                        ._stationIdTable(db),
                                referencedColumn:
                                    $$WaterQualityReadingsTableReferences
                                        ._stationIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable:
                                    $$WaterQualityReadingsTableReferences
                                        ._providerIdTable(db),
                                referencedColumn:
                                    $$WaterQualityReadingsTableReferences
                                        ._providerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WaterQualityReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaterQualityReadingsTable,
      WaterQualityReading,
      $$WaterQualityReadingsTableFilterComposer,
      $$WaterQualityReadingsTableOrderingComposer,
      $$WaterQualityReadingsTableAnnotationComposer,
      $$WaterQualityReadingsTableCreateCompanionBuilder,
      $$WaterQualityReadingsTableUpdateCompanionBuilder,
      (WaterQualityReading, $$WaterQualityReadingsTableReferences),
      WaterQualityReading,
      PrefetchHooks Function({bool stationId, bool providerId})
    >;
typedef $$AlgaeReportsTableCreateCompanionBuilder =
    AlgaeReportsCompanion Function({
      Value<int> id,
      required int stationId,
      required int providerId,
      required DateTime observationTime,
      required DateTime fetchedAt,
      Value<String?> speciesName,
      Value<double?> biomass,
      Value<int?> cellCount,
      Value<String?> dominantSpecies,
      Value<int?> riskLevel,
    });
typedef $$AlgaeReportsTableUpdateCompanionBuilder =
    AlgaeReportsCompanion Function({
      Value<int> id,
      Value<int> stationId,
      Value<int> providerId,
      Value<DateTime> observationTime,
      Value<DateTime> fetchedAt,
      Value<String?> speciesName,
      Value<double?> biomass,
      Value<int?> cellCount,
      Value<String?> dominantSpecies,
      Value<int?> riskLevel,
    });

final class $$AlgaeReportsTableReferences
    extends BaseReferences<_$AppDatabase, $AlgaeReportsTable, AlgaeReport> {
  $$AlgaeReportsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeatherStationsTable _stationIdTable(_$AppDatabase db) => db
      .weatherStations
      .createAlias('algae_reports__station_id__weather_stations__id');

  $$WeatherStationsTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$WeatherStationsTableTableManager(
      $_db,
      $_db.weatherStations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WeatherProvidersTable _providerIdTable(_$AppDatabase db) => db
      .weatherProviders
      .createAlias('algae_reports__provider_id__weather_providers__id');

  $$WeatherProvidersTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$WeatherProvidersTableTableManager(
      $_db,
      $_db.weatherProviders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AlgaeReportsTableFilterComposer
    extends Composer<_$AppDatabase, $AlgaeReportsTable> {
  $$AlgaeReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get observationTime => $composableBuilder(
    column: $table.observationTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get speciesName => $composableBuilder(
    column: $table.speciesName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get biomass => $composableBuilder(
    column: $table.biomass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cellCount => $composableBuilder(
    column: $table.cellCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dominantSpecies => $composableBuilder(
    column: $table.dominantSpecies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get riskLevel => $composableBuilder(
    column: $table.riskLevel,
    builder: (column) => ColumnFilters(column),
  );

  $$WeatherStationsTableFilterComposer get stationId {
    final $$WeatherStationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableFilterComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableFilterComposer get providerId {
    final $$WeatherProvidersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableFilterComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlgaeReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlgaeReportsTable> {
  $$AlgaeReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get observationTime => $composableBuilder(
    column: $table.observationTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get speciesName => $composableBuilder(
    column: $table.speciesName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get biomass => $composableBuilder(
    column: $table.biomass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cellCount => $composableBuilder(
    column: $table.cellCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dominantSpecies => $composableBuilder(
    column: $table.dominantSpecies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get riskLevel => $composableBuilder(
    column: $table.riskLevel,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeatherStationsTableOrderingComposer get stationId {
    final $$WeatherStationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableOrderingComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableOrderingComposer get providerId {
    final $$WeatherProvidersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableOrderingComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlgaeReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlgaeReportsTable> {
  $$AlgaeReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get observationTime => $composableBuilder(
    column: $table.observationTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<String> get speciesName => $composableBuilder(
    column: $table.speciesName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get biomass =>
      $composableBuilder(column: $table.biomass, builder: (column) => column);

  GeneratedColumn<int> get cellCount =>
      $composableBuilder(column: $table.cellCount, builder: (column) => column);

  GeneratedColumn<String> get dominantSpecies => $composableBuilder(
    column: $table.dominantSpecies,
    builder: (column) => column,
  );

  GeneratedColumn<int> get riskLevel =>
      $composableBuilder(column: $table.riskLevel, builder: (column) => column);

  $$WeatherStationsTableAnnotationComposer get stationId {
    final $$WeatherStationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.weatherStations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherStationsTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherStations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WeatherProvidersTableAnnotationComposer get providerId {
    final $$WeatherProvidersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.providerId,
      referencedTable: $db.weatherProviders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeatherProvidersTableAnnotationComposer(
            $db: $db,
            $table: $db.weatherProviders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AlgaeReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AlgaeReportsTable,
          AlgaeReport,
          $$AlgaeReportsTableFilterComposer,
          $$AlgaeReportsTableOrderingComposer,
          $$AlgaeReportsTableAnnotationComposer,
          $$AlgaeReportsTableCreateCompanionBuilder,
          $$AlgaeReportsTableUpdateCompanionBuilder,
          (AlgaeReport, $$AlgaeReportsTableReferences),
          AlgaeReport,
          PrefetchHooks Function({bool stationId, bool providerId})
        > {
  $$AlgaeReportsTableTableManager(_$AppDatabase db, $AlgaeReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlgaeReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlgaeReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlgaeReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stationId = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<DateTime> observationTime = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<String?> speciesName = const Value.absent(),
                Value<double?> biomass = const Value.absent(),
                Value<int?> cellCount = const Value.absent(),
                Value<String?> dominantSpecies = const Value.absent(),
                Value<int?> riskLevel = const Value.absent(),
              }) => AlgaeReportsCompanion(
                id: id,
                stationId: stationId,
                providerId: providerId,
                observationTime: observationTime,
                fetchedAt: fetchedAt,
                speciesName: speciesName,
                biomass: biomass,
                cellCount: cellCount,
                dominantSpecies: dominantSpecies,
                riskLevel: riskLevel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int stationId,
                required int providerId,
                required DateTime observationTime,
                required DateTime fetchedAt,
                Value<String?> speciesName = const Value.absent(),
                Value<double?> biomass = const Value.absent(),
                Value<int?> cellCount = const Value.absent(),
                Value<String?> dominantSpecies = const Value.absent(),
                Value<int?> riskLevel = const Value.absent(),
              }) => AlgaeReportsCompanion.insert(
                id: id,
                stationId: stationId,
                providerId: providerId,
                observationTime: observationTime,
                fetchedAt: fetchedAt,
                speciesName: speciesName,
                biomass: biomass,
                cellCount: cellCount,
                dominantSpecies: dominantSpecies,
                riskLevel: riskLevel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AlgaeReportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stationId = false, providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (stationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.stationId,
                                referencedTable: $$AlgaeReportsTableReferences
                                    ._stationIdTable(db),
                                referencedColumn: $$AlgaeReportsTableReferences
                                    ._stationIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable: $$AlgaeReportsTableReferences
                                    ._providerIdTable(db),
                                referencedColumn: $$AlgaeReportsTableReferences
                                    ._providerIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AlgaeReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AlgaeReportsTable,
      AlgaeReport,
      $$AlgaeReportsTableFilterComposer,
      $$AlgaeReportsTableOrderingComposer,
      $$AlgaeReportsTableAnnotationComposer,
      $$AlgaeReportsTableCreateCompanionBuilder,
      $$AlgaeReportsTableUpdateCompanionBuilder,
      (AlgaeReport, $$AlgaeReportsTableReferences),
      AlgaeReport,
      PrefetchHooks Function({bool stationId, bool providerId})
    >;
typedef $$MarineMapTilesTableCreateCompanionBuilder =
    MarineMapTilesCompanion Function({
      required int zoom,
      required int x,
      required int y,
      required Uint8List tileData,
      Value<int> refCount,
      Value<DateTime> lastAccessed,
      required String sourceId,
      Value<String?> md5Hash,
      Value<int> rowid,
    });
typedef $$MarineMapTilesTableUpdateCompanionBuilder =
    MarineMapTilesCompanion Function({
      Value<int> zoom,
      Value<int> x,
      Value<int> y,
      Value<Uint8List> tileData,
      Value<int> refCount,
      Value<DateTime> lastAccessed,
      Value<String> sourceId,
      Value<String?> md5Hash,
      Value<int> rowid,
    });

class $$MarineMapTilesTableFilterComposer
    extends Composer<_$AppDatabase, $MarineMapTilesTable> {
  $$MarineMapTilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get zoom => $composableBuilder(
    column: $table.zoom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get tileData => $composableBuilder(
    column: $table.tileData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get refCount => $composableBuilder(
    column: $table.refCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get md5Hash => $composableBuilder(
    column: $table.md5Hash,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MarineMapTilesTableOrderingComposer
    extends Composer<_$AppDatabase, $MarineMapTilesTable> {
  $$MarineMapTilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get zoom => $composableBuilder(
    column: $table.zoom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get tileData => $composableBuilder(
    column: $table.tileData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get refCount => $composableBuilder(
    column: $table.refCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get md5Hash => $composableBuilder(
    column: $table.md5Hash,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MarineMapTilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MarineMapTilesTable> {
  $$MarineMapTilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get zoom =>
      $composableBuilder(column: $table.zoom, builder: (column) => column);

  GeneratedColumn<int> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<int> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<Uint8List> get tileData =>
      $composableBuilder(column: $table.tileData, builder: (column) => column);

  GeneratedColumn<int> get refCount =>
      $composableBuilder(column: $table.refCount, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAccessed => $composableBuilder(
    column: $table.lastAccessed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get md5Hash =>
      $composableBuilder(column: $table.md5Hash, builder: (column) => column);
}

class $$MarineMapTilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MarineMapTilesTable,
          MarineMapTile,
          $$MarineMapTilesTableFilterComposer,
          $$MarineMapTilesTableOrderingComposer,
          $$MarineMapTilesTableAnnotationComposer,
          $$MarineMapTilesTableCreateCompanionBuilder,
          $$MarineMapTilesTableUpdateCompanionBuilder,
          (
            MarineMapTile,
            BaseReferences<_$AppDatabase, $MarineMapTilesTable, MarineMapTile>,
          ),
          MarineMapTile,
          PrefetchHooks Function()
        > {
  $$MarineMapTilesTableTableManager(
    _$AppDatabase db,
    $MarineMapTilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MarineMapTilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MarineMapTilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MarineMapTilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> zoom = const Value.absent(),
                Value<int> x = const Value.absent(),
                Value<int> y = const Value.absent(),
                Value<Uint8List> tileData = const Value.absent(),
                Value<int> refCount = const Value.absent(),
                Value<DateTime> lastAccessed = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<String?> md5Hash = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MarineMapTilesCompanion(
                zoom: zoom,
                x: x,
                y: y,
                tileData: tileData,
                refCount: refCount,
                lastAccessed: lastAccessed,
                sourceId: sourceId,
                md5Hash: md5Hash,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int zoom,
                required int x,
                required int y,
                required Uint8List tileData,
                Value<int> refCount = const Value.absent(),
                Value<DateTime> lastAccessed = const Value.absent(),
                required String sourceId,
                Value<String?> md5Hash = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MarineMapTilesCompanion.insert(
                zoom: zoom,
                x: x,
                y: y,
                tileData: tileData,
                refCount: refCount,
                lastAccessed: lastAccessed,
                sourceId: sourceId,
                md5Hash: md5Hash,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MarineMapTilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MarineMapTilesTable,
      MarineMapTile,
      $$MarineMapTilesTableFilterComposer,
      $$MarineMapTilesTableOrderingComposer,
      $$MarineMapTilesTableAnnotationComposer,
      $$MarineMapTilesTableCreateCompanionBuilder,
      $$MarineMapTilesTableUpdateCompanionBuilder,
      (
        MarineMapTile,
        BaseReferences<_$AppDatabase, $MarineMapTilesTable, MarineMapTile>,
      ),
      MarineMapTile,
      PrefetchHooks Function()
    >;
typedef $$OfflineRegionsTableCreateCompanionBuilder =
    OfflineRegionsCompanion Function({
      Value<int> id,
      required String name,
      required double minLat,
      required double maxLat,
      required double minLon,
      required double maxLon,
      required int totalTiles,
      Value<int> estimatedSizeBytes,
      Value<int> downloadStatus,
      Value<DateTime> createdAt,
    });
typedef $$OfflineRegionsTableUpdateCompanionBuilder =
    OfflineRegionsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> minLat,
      Value<double> maxLat,
      Value<double> minLon,
      Value<double> maxLon,
      Value<int> totalTiles,
      Value<int> estimatedSizeBytes,
      Value<int> downloadStatus,
      Value<DateTime> createdAt,
    });

final class $$OfflineRegionsTableReferences
    extends BaseReferences<_$AppDatabase, $OfflineRegionsTable, OfflineRegion> {
  $$OfflineRegionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$RegionTileRefsTable, List<RegionTileRef>>
  _regionTileRefsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.regionTileRefs,
    aliasName: 'offline_regions__id__region_tile_refs__region_id',
  );

  $$RegionTileRefsTableProcessedTableManager get regionTileRefsRefs {
    final manager = $$RegionTileRefsTableTableManager(
      $_db,
      $_db.regionTileRefs,
    ).filter((f) => f.regionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_regionTileRefsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OfflineRegionsTableFilterComposer
    extends Composer<_$AppDatabase, $OfflineRegionsTable> {
  $$OfflineRegionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minLat => $composableBuilder(
    column: $table.minLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxLat => $composableBuilder(
    column: $table.maxLat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minLon => $composableBuilder(
    column: $table.minLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxLon => $composableBuilder(
    column: $table.maxLon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTiles => $composableBuilder(
    column: $table.totalTiles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedSizeBytes => $composableBuilder(
    column: $table.estimatedSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get downloadStatus => $composableBuilder(
    column: $table.downloadStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> regionTileRefsRefs(
    Expression<bool> Function($$RegionTileRefsTableFilterComposer f) f,
  ) {
    final $$RegionTileRefsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.regionTileRefs,
      getReferencedColumn: (t) => t.regionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegionTileRefsTableFilterComposer(
            $db: $db,
            $table: $db.regionTileRefs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OfflineRegionsTableOrderingComposer
    extends Composer<_$AppDatabase, $OfflineRegionsTable> {
  $$OfflineRegionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minLat => $composableBuilder(
    column: $table.minLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxLat => $composableBuilder(
    column: $table.maxLat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minLon => $composableBuilder(
    column: $table.minLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxLon => $composableBuilder(
    column: $table.maxLon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTiles => $composableBuilder(
    column: $table.totalTiles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedSizeBytes => $composableBuilder(
    column: $table.estimatedSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get downloadStatus => $composableBuilder(
    column: $table.downloadStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OfflineRegionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfflineRegionsTable> {
  $$OfflineRegionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get minLat =>
      $composableBuilder(column: $table.minLat, builder: (column) => column);

  GeneratedColumn<double> get maxLat =>
      $composableBuilder(column: $table.maxLat, builder: (column) => column);

  GeneratedColumn<double> get minLon =>
      $composableBuilder(column: $table.minLon, builder: (column) => column);

  GeneratedColumn<double> get maxLon =>
      $composableBuilder(column: $table.maxLon, builder: (column) => column);

  GeneratedColumn<int> get totalTiles => $composableBuilder(
    column: $table.totalTiles,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedSizeBytes => $composableBuilder(
    column: $table.estimatedSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get downloadStatus => $composableBuilder(
    column: $table.downloadStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> regionTileRefsRefs<T extends Object>(
    Expression<T> Function($$RegionTileRefsTableAnnotationComposer a) f,
  ) {
    final $$RegionTileRefsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.regionTileRefs,
      getReferencedColumn: (t) => t.regionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegionTileRefsTableAnnotationComposer(
            $db: $db,
            $table: $db.regionTileRefs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OfflineRegionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OfflineRegionsTable,
          OfflineRegion,
          $$OfflineRegionsTableFilterComposer,
          $$OfflineRegionsTableOrderingComposer,
          $$OfflineRegionsTableAnnotationComposer,
          $$OfflineRegionsTableCreateCompanionBuilder,
          $$OfflineRegionsTableUpdateCompanionBuilder,
          (OfflineRegion, $$OfflineRegionsTableReferences),
          OfflineRegion,
          PrefetchHooks Function({bool regionTileRefsRefs})
        > {
  $$OfflineRegionsTableTableManager(
    _$AppDatabase db,
    $OfflineRegionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfflineRegionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfflineRegionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfflineRegionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> minLat = const Value.absent(),
                Value<double> maxLat = const Value.absent(),
                Value<double> minLon = const Value.absent(),
                Value<double> maxLon = const Value.absent(),
                Value<int> totalTiles = const Value.absent(),
                Value<int> estimatedSizeBytes = const Value.absent(),
                Value<int> downloadStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OfflineRegionsCompanion(
                id: id,
                name: name,
                minLat: minLat,
                maxLat: maxLat,
                minLon: minLon,
                maxLon: maxLon,
                totalTiles: totalTiles,
                estimatedSizeBytes: estimatedSizeBytes,
                downloadStatus: downloadStatus,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double minLat,
                required double maxLat,
                required double minLon,
                required double maxLon,
                required int totalTiles,
                Value<int> estimatedSizeBytes = const Value.absent(),
                Value<int> downloadStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OfflineRegionsCompanion.insert(
                id: id,
                name: name,
                minLat: minLat,
                maxLat: maxLat,
                minLon: minLon,
                maxLon: maxLon,
                totalTiles: totalTiles,
                estimatedSizeBytes: estimatedSizeBytes,
                downloadStatus: downloadStatus,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OfflineRegionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({regionTileRefsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (regionTileRefsRefs) db.regionTileRefs,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (regionTileRefsRefs)
                    await $_getPrefetchedData<
                      OfflineRegion,
                      $OfflineRegionsTable,
                      RegionTileRef
                    >(
                      currentTable: table,
                      referencedTable: $$OfflineRegionsTableReferences
                          ._regionTileRefsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$OfflineRegionsTableReferences(
                            db,
                            table,
                            p0,
                          ).regionTileRefsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.regionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$OfflineRegionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OfflineRegionsTable,
      OfflineRegion,
      $$OfflineRegionsTableFilterComposer,
      $$OfflineRegionsTableOrderingComposer,
      $$OfflineRegionsTableAnnotationComposer,
      $$OfflineRegionsTableCreateCompanionBuilder,
      $$OfflineRegionsTableUpdateCompanionBuilder,
      (OfflineRegion, $$OfflineRegionsTableReferences),
      OfflineRegion,
      PrefetchHooks Function({bool regionTileRefsRefs})
    >;
typedef $$RegionTileRefsTableCreateCompanionBuilder =
    RegionTileRefsCompanion Function({
      required int regionId,
      required int zoom,
      required int x,
      required int y,
      required String sourceId,
      Value<int> rowid,
    });
typedef $$RegionTileRefsTableUpdateCompanionBuilder =
    RegionTileRefsCompanion Function({
      Value<int> regionId,
      Value<int> zoom,
      Value<int> x,
      Value<int> y,
      Value<String> sourceId,
      Value<int> rowid,
    });

final class $$RegionTileRefsTableReferences
    extends BaseReferences<_$AppDatabase, $RegionTileRefsTable, RegionTileRef> {
  $$RegionTileRefsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $OfflineRegionsTable _regionIdTable(_$AppDatabase db) => db
      .offlineRegions
      .createAlias('region_tile_refs__region_id__offline_regions__id');

  $$OfflineRegionsTableProcessedTableManager get regionId {
    final $_column = $_itemColumn<int>('region_id')!;

    final manager = $$OfflineRegionsTableTableManager(
      $_db,
      $_db.offlineRegions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_regionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RegionTileRefsTableFilterComposer
    extends Composer<_$AppDatabase, $RegionTileRefsTable> {
  $$RegionTileRefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get zoom => $composableBuilder(
    column: $table.zoom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  $$OfflineRegionsTableFilterComposer get regionId {
    final $$OfflineRegionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.offlineRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OfflineRegionsTableFilterComposer(
            $db: $db,
            $table: $db.offlineRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegionTileRefsTableOrderingComposer
    extends Composer<_$AppDatabase, $RegionTileRefsTable> {
  $$RegionTileRefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get zoom => $composableBuilder(
    column: $table.zoom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  $$OfflineRegionsTableOrderingComposer get regionId {
    final $$OfflineRegionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.offlineRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OfflineRegionsTableOrderingComposer(
            $db: $db,
            $table: $db.offlineRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegionTileRefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegionTileRefsTable> {
  $$RegionTileRefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get zoom =>
      $composableBuilder(column: $table.zoom, builder: (column) => column);

  GeneratedColumn<int> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<int> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  $$OfflineRegionsTableAnnotationComposer get regionId {
    final $$OfflineRegionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.offlineRegions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OfflineRegionsTableAnnotationComposer(
            $db: $db,
            $table: $db.offlineRegions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegionTileRefsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegionTileRefsTable,
          RegionTileRef,
          $$RegionTileRefsTableFilterComposer,
          $$RegionTileRefsTableOrderingComposer,
          $$RegionTileRefsTableAnnotationComposer,
          $$RegionTileRefsTableCreateCompanionBuilder,
          $$RegionTileRefsTableUpdateCompanionBuilder,
          (RegionTileRef, $$RegionTileRefsTableReferences),
          RegionTileRef,
          PrefetchHooks Function({bool regionId})
        > {
  $$RegionTileRefsTableTableManager(
    _$AppDatabase db,
    $RegionTileRefsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegionTileRefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegionTileRefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegionTileRefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> regionId = const Value.absent(),
                Value<int> zoom = const Value.absent(),
                Value<int> x = const Value.absent(),
                Value<int> y = const Value.absent(),
                Value<String> sourceId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RegionTileRefsCompanion(
                regionId: regionId,
                zoom: zoom,
                x: x,
                y: y,
                sourceId: sourceId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int regionId,
                required int zoom,
                required int x,
                required int y,
                required String sourceId,
                Value<int> rowid = const Value.absent(),
              }) => RegionTileRefsCompanion.insert(
                regionId: regionId,
                zoom: zoom,
                x: x,
                y: y,
                sourceId: sourceId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RegionTileRefsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({regionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (regionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.regionId,
                                referencedTable: $$RegionTileRefsTableReferences
                                    ._regionIdTable(db),
                                referencedColumn:
                                    $$RegionTileRefsTableReferences
                                        ._regionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RegionTileRefsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegionTileRefsTable,
      RegionTileRef,
      $$RegionTileRefsTableFilterComposer,
      $$RegionTileRefsTableOrderingComposer,
      $$RegionTileRefsTableAnnotationComposer,
      $$RegionTileRefsTableCreateCompanionBuilder,
      $$RegionTileRefsTableUpdateCompanionBuilder,
      (RegionTileRef, $$RegionTileRefsTableReferences),
      RegionTileRef,
      PrefetchHooks Function({bool regionId})
    >;
typedef $$RoutesTableCreateCompanionBuilder =
    RoutesCompanion Function({
      Value<int> id,
      required String name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isActive,
      Value<double> totalDistanceMeters,
    });
typedef $$RoutesTableUpdateCompanionBuilder =
    RoutesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> isActive,
      Value<double> totalDistanceMeters,
    });

final class $$RoutesTableReferences
    extends BaseReferences<_$AppDatabase, $RoutesTable, DbRoute> {
  $$RoutesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WaypointsTable, List<Waypoint>>
  _waypointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.waypoints,
    aliasName: 'routes__id__waypoints__route_id',
  );

  $$WaypointsTableProcessedTableManager get waypointsRefs {
    final manager = $$WaypointsTableTableManager(
      $_db,
      $_db.waypoints,
    ).filter((f) => f.routeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_waypointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoutesTableFilterComposer
    extends Composer<_$AppDatabase, $RoutesTable> {
  $$RoutesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalDistanceMeters => $composableBuilder(
    column: $table.totalDistanceMeters,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> waypointsRefs(
    Expression<bool> Function($$WaypointsTableFilterComposer f) f,
  ) {
    final $$WaypointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waypoints,
      getReferencedColumn: (t) => t.routeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaypointsTableFilterComposer(
            $db: $db,
            $table: $db.waypoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoutesTable> {
  $$RoutesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalDistanceMeters => $composableBuilder(
    column: $table.totalDistanceMeters,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RoutesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoutesTable> {
  $$RoutesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<double> get totalDistanceMeters => $composableBuilder(
    column: $table.totalDistanceMeters,
    builder: (column) => column,
  );

  Expression<T> waypointsRefs<T extends Object>(
    Expression<T> Function($$WaypointsTableAnnotationComposer a) f,
  ) {
    final $$WaypointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.waypoints,
      getReferencedColumn: (t) => t.routeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WaypointsTableAnnotationComposer(
            $db: $db,
            $table: $db.waypoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoutesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoutesTable,
          DbRoute,
          $$RoutesTableFilterComposer,
          $$RoutesTableOrderingComposer,
          $$RoutesTableAnnotationComposer,
          $$RoutesTableCreateCompanionBuilder,
          $$RoutesTableUpdateCompanionBuilder,
          (DbRoute, $$RoutesTableReferences),
          DbRoute,
          PrefetchHooks Function({bool waypointsRefs})
        > {
  $$RoutesTableTableManager(_$AppDatabase db, $RoutesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoutesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoutesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoutesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<double> totalDistanceMeters = const Value.absent(),
              }) => RoutesCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isActive: isActive,
                totalDistanceMeters: totalDistanceMeters,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<double> totalDistanceMeters = const Value.absent(),
              }) => RoutesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isActive: isActive,
                totalDistanceMeters: totalDistanceMeters,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RoutesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({waypointsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (waypointsRefs) db.waypoints],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (waypointsRefs)
                    await $_getPrefetchedData<DbRoute, $RoutesTable, Waypoint>(
                      currentTable: table,
                      referencedTable: $$RoutesTableReferences
                          ._waypointsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RoutesTableReferences(db, table, p0).waypointsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.routeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RoutesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoutesTable,
      DbRoute,
      $$RoutesTableFilterComposer,
      $$RoutesTableOrderingComposer,
      $$RoutesTableAnnotationComposer,
      $$RoutesTableCreateCompanionBuilder,
      $$RoutesTableUpdateCompanionBuilder,
      (DbRoute, $$RoutesTableReferences),
      DbRoute,
      PrefetchHooks Function({bool waypointsRefs})
    >;
typedef $$WaypointsTableCreateCompanionBuilder =
    WaypointsCompanion Function({
      Value<int> id,
      required int routeId,
      required double lat,
      required double lon,
      required int orderIndex,
      Value<String?> label,
    });
typedef $$WaypointsTableUpdateCompanionBuilder =
    WaypointsCompanion Function({
      Value<int> id,
      Value<int> routeId,
      Value<double> lat,
      Value<double> lon,
      Value<int> orderIndex,
      Value<String?> label,
    });

final class $$WaypointsTableReferences
    extends BaseReferences<_$AppDatabase, $WaypointsTable, Waypoint> {
  $$WaypointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RoutesTable _routeIdTable(_$AppDatabase db) =>
      db.routes.createAlias('waypoints__route_id__routes__id');

  $$RoutesTableProcessedTableManager get routeId {
    final $_column = $_itemColumn<int>('route_id')!;

    final manager = $$RoutesTableTableManager(
      $_db,
      $_db.routes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_routeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WaypointsTableFilterComposer
    extends Composer<_$AppDatabase, $WaypointsTable> {
  $$WaypointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  $$RoutesTableFilterComposer get routeId {
    final $$RoutesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routeId,
      referencedTable: $db.routes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutesTableFilterComposer(
            $db: $db,
            $table: $db.routes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaypointsTableOrderingComposer
    extends Composer<_$AppDatabase, $WaypointsTable> {
  $$WaypointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  $$RoutesTableOrderingComposer get routeId {
    final $$RoutesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routeId,
      referencedTable: $db.routes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutesTableOrderingComposer(
            $db: $db,
            $table: $db.routes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaypointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaypointsTable> {
  $$WaypointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  $$RoutesTableAnnotationComposer get routeId {
    final $$RoutesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.routeId,
      referencedTable: $db.routes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoutesTableAnnotationComposer(
            $db: $db,
            $table: $db.routes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaypointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaypointsTable,
          Waypoint,
          $$WaypointsTableFilterComposer,
          $$WaypointsTableOrderingComposer,
          $$WaypointsTableAnnotationComposer,
          $$WaypointsTableCreateCompanionBuilder,
          $$WaypointsTableUpdateCompanionBuilder,
          (Waypoint, $$WaypointsTableReferences),
          Waypoint,
          PrefetchHooks Function({bool routeId})
        > {
  $$WaypointsTableTableManager(_$AppDatabase db, $WaypointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaypointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaypointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaypointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> routeId = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String?> label = const Value.absent(),
              }) => WaypointsCompanion(
                id: id,
                routeId: routeId,
                lat: lat,
                lon: lon,
                orderIndex: orderIndex,
                label: label,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int routeId,
                required double lat,
                required double lon,
                required int orderIndex,
                Value<String?> label = const Value.absent(),
              }) => WaypointsCompanion.insert(
                id: id,
                routeId: routeId,
                lat: lat,
                lon: lon,
                orderIndex: orderIndex,
                label: label,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WaypointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({routeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (routeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.routeId,
                                referencedTable: $$WaypointsTableReferences
                                    ._routeIdTable(db),
                                referencedColumn: $$WaypointsTableReferences
                                    ._routeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WaypointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaypointsTable,
      Waypoint,
      $$WaypointsTableFilterComposer,
      $$WaypointsTableOrderingComposer,
      $$WaypointsTableAnnotationComposer,
      $$WaypointsTableCreateCompanionBuilder,
      $$WaypointsTableUpdateCompanionBuilder,
      (Waypoint, $$WaypointsTableReferences),
      Waypoint,
      PrefetchHooks Function({bool routeId})
    >;
typedef $$VesselProfilesTableCreateCompanionBuilder =
    VesselProfilesCompanion Function({
      Value<int> id,
      required String name,
      required VesselType type,
      required double maxWindLimit,
      required double maxWaveLimit,
      Value<double?> draftDepth,
      Value<double> cruisingSpeedKmh,
      Value<bool> isSelected,
      Value<String?> hinCode,
      Value<String?> engineManufacturer,
      Value<String?> engineModel,
      Value<String?> fuelType,
    });
typedef $$VesselProfilesTableUpdateCompanionBuilder =
    VesselProfilesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<VesselType> type,
      Value<double> maxWindLimit,
      Value<double> maxWaveLimit,
      Value<double?> draftDepth,
      Value<double> cruisingSpeedKmh,
      Value<bool> isSelected,
      Value<String?> hinCode,
      Value<String?> engineManufacturer,
      Value<String?> engineModel,
      Value<String?> fuelType,
    });

class $$VesselProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $VesselProfilesTable> {
  $$VesselProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VesselType, VesselType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get maxWindLimit => $composableBuilder(
    column: $table.maxWindLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxWaveLimit => $composableBuilder(
    column: $table.maxWaveLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get draftDepth => $composableBuilder(
    column: $table.draftDepth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cruisingSpeedKmh => $composableBuilder(
    column: $table.cruisingSpeedKmh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hinCode => $composableBuilder(
    column: $table.hinCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engineManufacturer => $composableBuilder(
    column: $table.engineManufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engineModel => $composableBuilder(
    column: $table.engineModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VesselProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $VesselProfilesTable> {
  $$VesselProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxWindLimit => $composableBuilder(
    column: $table.maxWindLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxWaveLimit => $composableBuilder(
    column: $table.maxWaveLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get draftDepth => $composableBuilder(
    column: $table.draftDepth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cruisingSpeedKmh => $composableBuilder(
    column: $table.cruisingSpeedKmh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hinCode => $composableBuilder(
    column: $table.hinCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engineManufacturer => $composableBuilder(
    column: $table.engineManufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engineModel => $composableBuilder(
    column: $table.engineModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VesselProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VesselProfilesTable> {
  $$VesselProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<VesselType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get maxWindLimit => $composableBuilder(
    column: $table.maxWindLimit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxWaveLimit => $composableBuilder(
    column: $table.maxWaveLimit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get draftDepth => $composableBuilder(
    column: $table.draftDepth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cruisingSpeedKmh => $composableBuilder(
    column: $table.cruisingSpeedKmh,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hinCode =>
      $composableBuilder(column: $table.hinCode, builder: (column) => column);

  GeneratedColumn<String> get engineManufacturer => $composableBuilder(
    column: $table.engineManufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get engineModel => $composableBuilder(
    column: $table.engineModel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);
}

class $$VesselProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VesselProfilesTable,
          VesselProfile,
          $$VesselProfilesTableFilterComposer,
          $$VesselProfilesTableOrderingComposer,
          $$VesselProfilesTableAnnotationComposer,
          $$VesselProfilesTableCreateCompanionBuilder,
          $$VesselProfilesTableUpdateCompanionBuilder,
          (
            VesselProfile,
            BaseReferences<_$AppDatabase, $VesselProfilesTable, VesselProfile>,
          ),
          VesselProfile,
          PrefetchHooks Function()
        > {
  $$VesselProfilesTableTableManager(
    _$AppDatabase db,
    $VesselProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VesselProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VesselProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VesselProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<VesselType> type = const Value.absent(),
                Value<double> maxWindLimit = const Value.absent(),
                Value<double> maxWaveLimit = const Value.absent(),
                Value<double?> draftDepth = const Value.absent(),
                Value<double> cruisingSpeedKmh = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
                Value<String?> hinCode = const Value.absent(),
                Value<String?> engineManufacturer = const Value.absent(),
                Value<String?> engineModel = const Value.absent(),
                Value<String?> fuelType = const Value.absent(),
              }) => VesselProfilesCompanion(
                id: id,
                name: name,
                type: type,
                maxWindLimit: maxWindLimit,
                maxWaveLimit: maxWaveLimit,
                draftDepth: draftDepth,
                cruisingSpeedKmh: cruisingSpeedKmh,
                isSelected: isSelected,
                hinCode: hinCode,
                engineManufacturer: engineManufacturer,
                engineModel: engineModel,
                fuelType: fuelType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required VesselType type,
                required double maxWindLimit,
                required double maxWaveLimit,
                Value<double?> draftDepth = const Value.absent(),
                Value<double> cruisingSpeedKmh = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
                Value<String?> hinCode = const Value.absent(),
                Value<String?> engineManufacturer = const Value.absent(),
                Value<String?> engineModel = const Value.absent(),
                Value<String?> fuelType = const Value.absent(),
              }) => VesselProfilesCompanion.insert(
                id: id,
                name: name,
                type: type,
                maxWindLimit: maxWindLimit,
                maxWaveLimit: maxWaveLimit,
                draftDepth: draftDepth,
                cruisingSpeedKmh: cruisingSpeedKmh,
                isSelected: isSelected,
                hinCode: hinCode,
                engineManufacturer: engineManufacturer,
                engineModel: engineModel,
                fuelType: fuelType,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VesselProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VesselProfilesTable,
      VesselProfile,
      $$VesselProfilesTableFilterComposer,
      $$VesselProfilesTableOrderingComposer,
      $$VesselProfilesTableAnnotationComposer,
      $$VesselProfilesTableCreateCompanionBuilder,
      $$VesselProfilesTableUpdateCompanionBuilder,
      (
        VesselProfile,
        BaseReferences<_$AppDatabase, $VesselProfilesTable, VesselProfile>,
      ),
      VesselProfile,
      PrefetchHooks Function()
    >;
typedef $$SkipperSettingsTableTableCreateCompanionBuilder =
    SkipperSettingsTableCompanion Function({
      Value<int> id,
      Value<bool> isAIEnabled,
      Value<double> windYellowMs,
      Value<double> windOrangeMs,
      Value<double> windRedMs,
      Value<double> waveYellowM,
      Value<double> waveOrangeM,
      Value<double> waveRedM,
      Value<double> pressureDropThresholdHpa,
      Value<int> forecastWindowHours,
      Value<bool> hasAcknowledgedAISafety,
      Value<String?> aiApiKey,
      Value<String> aiModelId,
    });
typedef $$SkipperSettingsTableTableUpdateCompanionBuilder =
    SkipperSettingsTableCompanion Function({
      Value<int> id,
      Value<bool> isAIEnabled,
      Value<double> windYellowMs,
      Value<double> windOrangeMs,
      Value<double> windRedMs,
      Value<double> waveYellowM,
      Value<double> waveOrangeM,
      Value<double> waveRedM,
      Value<double> pressureDropThresholdHpa,
      Value<int> forecastWindowHours,
      Value<bool> hasAcknowledgedAISafety,
      Value<String?> aiApiKey,
      Value<String> aiModelId,
    });

class $$SkipperSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SkipperSettingsTableTable> {
  $$SkipperSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAIEnabled => $composableBuilder(
    column: $table.isAIEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windYellowMs => $composableBuilder(
    column: $table.windYellowMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windOrangeMs => $composableBuilder(
    column: $table.windOrangeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get windRedMs => $composableBuilder(
    column: $table.windRedMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waveYellowM => $composableBuilder(
    column: $table.waveYellowM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waveOrangeM => $composableBuilder(
    column: $table.waveOrangeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waveRedM => $composableBuilder(
    column: $table.waveRedM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressureDropThresholdHpa => $composableBuilder(
    column: $table.pressureDropThresholdHpa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get forecastWindowHours => $composableBuilder(
    column: $table.forecastWindowHours,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasAcknowledgedAISafety => $composableBuilder(
    column: $table.hasAcknowledgedAISafety,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiApiKey => $composableBuilder(
    column: $table.aiApiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aiModelId => $composableBuilder(
    column: $table.aiModelId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkipperSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SkipperSettingsTableTable> {
  $$SkipperSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAIEnabled => $composableBuilder(
    column: $table.isAIEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windYellowMs => $composableBuilder(
    column: $table.windYellowMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windOrangeMs => $composableBuilder(
    column: $table.windOrangeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get windRedMs => $composableBuilder(
    column: $table.windRedMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waveYellowM => $composableBuilder(
    column: $table.waveYellowM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waveOrangeM => $composableBuilder(
    column: $table.waveOrangeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waveRedM => $composableBuilder(
    column: $table.waveRedM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressureDropThresholdHpa => $composableBuilder(
    column: $table.pressureDropThresholdHpa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get forecastWindowHours => $composableBuilder(
    column: $table.forecastWindowHours,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasAcknowledgedAISafety => $composableBuilder(
    column: $table.hasAcknowledgedAISafety,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiApiKey => $composableBuilder(
    column: $table.aiApiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aiModelId => $composableBuilder(
    column: $table.aiModelId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkipperSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkipperSettingsTableTable> {
  $$SkipperSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isAIEnabled => $composableBuilder(
    column: $table.isAIEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<double> get windYellowMs => $composableBuilder(
    column: $table.windYellowMs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get windOrangeMs => $composableBuilder(
    column: $table.windOrangeMs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get windRedMs =>
      $composableBuilder(column: $table.windRedMs, builder: (column) => column);

  GeneratedColumn<double> get waveYellowM => $composableBuilder(
    column: $table.waveYellowM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waveOrangeM => $composableBuilder(
    column: $table.waveOrangeM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waveRedM =>
      $composableBuilder(column: $table.waveRedM, builder: (column) => column);

  GeneratedColumn<double> get pressureDropThresholdHpa => $composableBuilder(
    column: $table.pressureDropThresholdHpa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get forecastWindowHours => $composableBuilder(
    column: $table.forecastWindowHours,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasAcknowledgedAISafety => $composableBuilder(
    column: $table.hasAcknowledgedAISafety,
    builder: (column) => column,
  );

  GeneratedColumn<String> get aiApiKey =>
      $composableBuilder(column: $table.aiApiKey, builder: (column) => column);

  GeneratedColumn<String> get aiModelId =>
      $composableBuilder(column: $table.aiModelId, builder: (column) => column);
}

class $$SkipperSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkipperSettingsTableTable,
          SkipperSettingsEntry,
          $$SkipperSettingsTableTableFilterComposer,
          $$SkipperSettingsTableTableOrderingComposer,
          $$SkipperSettingsTableTableAnnotationComposer,
          $$SkipperSettingsTableTableCreateCompanionBuilder,
          $$SkipperSettingsTableTableUpdateCompanionBuilder,
          (
            SkipperSettingsEntry,
            BaseReferences<
              _$AppDatabase,
              $SkipperSettingsTableTable,
              SkipperSettingsEntry
            >,
          ),
          SkipperSettingsEntry,
          PrefetchHooks Function()
        > {
  $$SkipperSettingsTableTableTableManager(
    _$AppDatabase db,
    $SkipperSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkipperSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkipperSettingsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SkipperSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isAIEnabled = const Value.absent(),
                Value<double> windYellowMs = const Value.absent(),
                Value<double> windOrangeMs = const Value.absent(),
                Value<double> windRedMs = const Value.absent(),
                Value<double> waveYellowM = const Value.absent(),
                Value<double> waveOrangeM = const Value.absent(),
                Value<double> waveRedM = const Value.absent(),
                Value<double> pressureDropThresholdHpa = const Value.absent(),
                Value<int> forecastWindowHours = const Value.absent(),
                Value<bool> hasAcknowledgedAISafety = const Value.absent(),
                Value<String?> aiApiKey = const Value.absent(),
                Value<String> aiModelId = const Value.absent(),
              }) => SkipperSettingsTableCompanion(
                id: id,
                isAIEnabled: isAIEnabled,
                windYellowMs: windYellowMs,
                windOrangeMs: windOrangeMs,
                windRedMs: windRedMs,
                waveYellowM: waveYellowM,
                waveOrangeM: waveOrangeM,
                waveRedM: waveRedM,
                pressureDropThresholdHpa: pressureDropThresholdHpa,
                forecastWindowHours: forecastWindowHours,
                hasAcknowledgedAISafety: hasAcknowledgedAISafety,
                aiApiKey: aiApiKey,
                aiModelId: aiModelId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isAIEnabled = const Value.absent(),
                Value<double> windYellowMs = const Value.absent(),
                Value<double> windOrangeMs = const Value.absent(),
                Value<double> windRedMs = const Value.absent(),
                Value<double> waveYellowM = const Value.absent(),
                Value<double> waveOrangeM = const Value.absent(),
                Value<double> waveRedM = const Value.absent(),
                Value<double> pressureDropThresholdHpa = const Value.absent(),
                Value<int> forecastWindowHours = const Value.absent(),
                Value<bool> hasAcknowledgedAISafety = const Value.absent(),
                Value<String?> aiApiKey = const Value.absent(),
                Value<String> aiModelId = const Value.absent(),
              }) => SkipperSettingsTableCompanion.insert(
                id: id,
                isAIEnabled: isAIEnabled,
                windYellowMs: windYellowMs,
                windOrangeMs: windOrangeMs,
                windRedMs: windRedMs,
                waveYellowM: waveYellowM,
                waveOrangeM: waveOrangeM,
                waveRedM: waveRedM,
                pressureDropThresholdHpa: pressureDropThresholdHpa,
                forecastWindowHours: forecastWindowHours,
                hasAcknowledgedAISafety: hasAcknowledgedAISafety,
                aiApiKey: aiApiKey,
                aiModelId: aiModelId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkipperSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkipperSettingsTableTable,
      SkipperSettingsEntry,
      $$SkipperSettingsTableTableFilterComposer,
      $$SkipperSettingsTableTableOrderingComposer,
      $$SkipperSettingsTableTableAnnotationComposer,
      $$SkipperSettingsTableTableCreateCompanionBuilder,
      $$SkipperSettingsTableTableUpdateCompanionBuilder,
      (
        SkipperSettingsEntry,
        BaseReferences<
          _$AppDatabase,
          $SkipperSettingsTableTable,
          SkipperSettingsEntry
        >,
      ),
      SkipperSettingsEntry,
      PrefetchHooks Function()
    >;
typedef $$RecordedTracksTableCreateCompanionBuilder =
    RecordedTracksCompanion Function({
      Value<int> id,
      Value<String?> name,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<bool> isFishingMode,
      Value<double> totalDistanceMeters,
    });
typedef $$RecordedTracksTableUpdateCompanionBuilder =
    RecordedTracksCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<bool> isFishingMode,
      Value<double> totalDistanceMeters,
    });

final class $$RecordedTracksTableReferences
    extends BaseReferences<_$AppDatabase, $RecordedTracksTable, RecordedTrack> {
  $$RecordedTracksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TrackPointsTable, List<TrackPoint>>
  _trackPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trackPoints,
    aliasName: 'recorded_tracks__id__track_points__track_id',
  );

  $$TrackPointsTableProcessedTableManager get trackPointsRefs {
    final manager = $$TrackPointsTableTableManager(
      $_db,
      $_db.trackPoints,
    ).filter((f) => f.trackId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trackPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecordedTracksTableFilterComposer
    extends Composer<_$AppDatabase, $RecordedTracksTable> {
  $$RecordedTracksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFishingMode => $composableBuilder(
    column: $table.isFishingMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalDistanceMeters => $composableBuilder(
    column: $table.totalDistanceMeters,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> trackPointsRefs(
    Expression<bool> Function($$TrackPointsTableFilterComposer f) f,
  ) {
    final $$TrackPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackPoints,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackPointsTableFilterComposer(
            $db: $db,
            $table: $db.trackPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecordedTracksTableOrderingComposer
    extends Composer<_$AppDatabase, $RecordedTracksTable> {
  $$RecordedTracksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFishingMode => $composableBuilder(
    column: $table.isFishingMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalDistanceMeters => $composableBuilder(
    column: $table.totalDistanceMeters,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecordedTracksTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecordedTracksTable> {
  $$RecordedTracksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<bool> get isFishingMode => $composableBuilder(
    column: $table.isFishingMode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalDistanceMeters => $composableBuilder(
    column: $table.totalDistanceMeters,
    builder: (column) => column,
  );

  Expression<T> trackPointsRefs<T extends Object>(
    Expression<T> Function($$TrackPointsTableAnnotationComposer a) f,
  ) {
    final $$TrackPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackPoints,
      getReferencedColumn: (t) => t.trackId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.trackPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecordedTracksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecordedTracksTable,
          RecordedTrack,
          $$RecordedTracksTableFilterComposer,
          $$RecordedTracksTableOrderingComposer,
          $$RecordedTracksTableAnnotationComposer,
          $$RecordedTracksTableCreateCompanionBuilder,
          $$RecordedTracksTableUpdateCompanionBuilder,
          (RecordedTrack, $$RecordedTracksTableReferences),
          RecordedTrack,
          PrefetchHooks Function({bool trackPointsRefs})
        > {
  $$RecordedTracksTableTableManager(
    _$AppDatabase db,
    $RecordedTracksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecordedTracksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecordedTracksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecordedTracksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<bool> isFishingMode = const Value.absent(),
                Value<double> totalDistanceMeters = const Value.absent(),
              }) => RecordedTracksCompanion(
                id: id,
                name: name,
                startTime: startTime,
                endTime: endTime,
                isFishingMode: isFishingMode,
                totalDistanceMeters: totalDistanceMeters,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<bool> isFishingMode = const Value.absent(),
                Value<double> totalDistanceMeters = const Value.absent(),
              }) => RecordedTracksCompanion.insert(
                id: id,
                name: name,
                startTime: startTime,
                endTime: endTime,
                isFishingMode: isFishingMode,
                totalDistanceMeters: totalDistanceMeters,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecordedTracksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackPointsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (trackPointsRefs) db.trackPoints],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackPointsRefs)
                    await $_getPrefetchedData<
                      RecordedTrack,
                      $RecordedTracksTable,
                      TrackPoint
                    >(
                      currentTable: table,
                      referencedTable: $$RecordedTracksTableReferences
                          ._trackPointsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RecordedTracksTableReferences(
                            db,
                            table,
                            p0,
                          ).trackPointsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.trackId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RecordedTracksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecordedTracksTable,
      RecordedTrack,
      $$RecordedTracksTableFilterComposer,
      $$RecordedTracksTableOrderingComposer,
      $$RecordedTracksTableAnnotationComposer,
      $$RecordedTracksTableCreateCompanionBuilder,
      $$RecordedTracksTableUpdateCompanionBuilder,
      (RecordedTrack, $$RecordedTracksTableReferences),
      RecordedTrack,
      PrefetchHooks Function({bool trackPointsRefs})
    >;
typedef $$TrackPointsTableCreateCompanionBuilder =
    TrackPointsCompanion Function({
      Value<int> id,
      required int trackId,
      required double latitude,
      required double longitude,
      required double speedKmh,
      required DateTime timestamp,
    });
typedef $$TrackPointsTableUpdateCompanionBuilder =
    TrackPointsCompanion Function({
      Value<int> id,
      Value<int> trackId,
      Value<double> latitude,
      Value<double> longitude,
      Value<double> speedKmh,
      Value<DateTime> timestamp,
    });

final class $$TrackPointsTableReferences
    extends BaseReferences<_$AppDatabase, $TrackPointsTable, TrackPoint> {
  $$TrackPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecordedTracksTable _trackIdTable(_$AppDatabase db) => db
      .recordedTracks
      .createAlias('track_points__track_id__recorded_tracks__id');

  $$RecordedTracksTableProcessedTableManager get trackId {
    final $_column = $_itemColumn<int>('track_id')!;

    final manager = $$RecordedTracksTableTableManager(
      $_db,
      $_db.recordedTracks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trackIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrackPointsTableFilterComposer
    extends Composer<_$AppDatabase, $TrackPointsTable> {
  $$TrackPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speedKmh => $composableBuilder(
    column: $table.speedKmh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  $$RecordedTracksTableFilterComposer get trackId {
    final $$RecordedTracksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.recordedTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordedTracksTableFilterComposer(
            $db: $db,
            $table: $db.recordedTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackPointsTable> {
  $$TrackPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speedKmh => $composableBuilder(
    column: $table.speedKmh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecordedTracksTableOrderingComposer get trackId {
    final $$RecordedTracksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.recordedTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordedTracksTableOrderingComposer(
            $db: $db,
            $table: $db.recordedTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackPointsTable> {
  $$TrackPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get speedKmh =>
      $composableBuilder(column: $table.speedKmh, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  $$RecordedTracksTableAnnotationComposer get trackId {
    final $$RecordedTracksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trackId,
      referencedTable: $db.recordedTracks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecordedTracksTableAnnotationComposer(
            $db: $db,
            $table: $db.recordedTracks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackPointsTable,
          TrackPoint,
          $$TrackPointsTableFilterComposer,
          $$TrackPointsTableOrderingComposer,
          $$TrackPointsTableAnnotationComposer,
          $$TrackPointsTableCreateCompanionBuilder,
          $$TrackPointsTableUpdateCompanionBuilder,
          (TrackPoint, $$TrackPointsTableReferences),
          TrackPoint,
          PrefetchHooks Function({bool trackId})
        > {
  $$TrackPointsTableTableManager(_$AppDatabase db, $TrackPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> trackId = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> speedKmh = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
              }) => TrackPointsCompanion(
                id: id,
                trackId: trackId,
                latitude: latitude,
                longitude: longitude,
                speedKmh: speedKmh,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int trackId,
                required double latitude,
                required double longitude,
                required double speedKmh,
                required DateTime timestamp,
              }) => TrackPointsCompanion.insert(
                id: id,
                trackId: trackId,
                latitude: latitude,
                longitude: longitude,
                speedKmh: speedKmh,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrackPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({trackId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (trackId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.trackId,
                                referencedTable: $$TrackPointsTableReferences
                                    ._trackIdTable(db),
                                referencedColumn: $$TrackPointsTableReferences
                                    ._trackIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrackPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackPointsTable,
      TrackPoint,
      $$TrackPointsTableFilterComposer,
      $$TrackPointsTableOrderingComposer,
      $$TrackPointsTableAnnotationComposer,
      $$TrackPointsTableCreateCompanionBuilder,
      $$TrackPointsTableUpdateCompanionBuilder,
      (TrackPoint, $$TrackPointsTableReferences),
      TrackPoint,
      PrefetchHooks Function({bool trackId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CatchesTableTableManager get catches =>
      $$CatchesTableTableManager(_db, _db.catches);
  $$UserContributionsTableTableManager get userContributions =>
      $$UserContributionsTableTableManager(_db, _db.userContributions);
  $$CachedFeaturesTableTableManager get cachedFeatures =>
      $$CachedFeaturesTableTableManager(_db, _db.cachedFeatures);
  $$WeatherProvidersTableTableManager get weatherProviders =>
      $$WeatherProvidersTableTableManager(_db, _db.weatherProviders);
  $$WeatherStationsTableTableManager get weatherStations =>
      $$WeatherStationsTableTableManager(_db, _db.weatherStations);
  $$WeatherObservationsTableTableManager get weatherObservations =>
      $$WeatherObservationsTableTableManager(_db, _db.weatherObservations);
  $$WeatherForecastsTableTableManager get weatherForecasts =>
      $$WeatherForecastsTableTableManager(_db, _db.weatherForecasts);
  $$WaveObservationsTableTableManager get waveObservations =>
      $$WaveObservationsTableTableManager(_db, _db.waveObservations);
  $$SeaLevelReadingsTableTableManager get seaLevelReadings =>
      $$SeaLevelReadingsTableTableManager(_db, _db.seaLevelReadings);
  $$WeatherAlertsTableTableManager get weatherAlerts =>
      $$WeatherAlertsTableTableManager(_db, _db.weatherAlerts);
  $$LightningStrikesTableTableManager get lightningStrikes =>
      $$LightningStrikesTableTableManager(_db, _db.lightningStrikes);
  $$WaterQualityReadingsTableTableManager get waterQualityReadings =>
      $$WaterQualityReadingsTableTableManager(_db, _db.waterQualityReadings);
  $$AlgaeReportsTableTableManager get algaeReports =>
      $$AlgaeReportsTableTableManager(_db, _db.algaeReports);
  $$MarineMapTilesTableTableManager get marineMapTiles =>
      $$MarineMapTilesTableTableManager(_db, _db.marineMapTiles);
  $$OfflineRegionsTableTableManager get offlineRegions =>
      $$OfflineRegionsTableTableManager(_db, _db.offlineRegions);
  $$RegionTileRefsTableTableManager get regionTileRefs =>
      $$RegionTileRefsTableTableManager(_db, _db.regionTileRefs);
  $$RoutesTableTableManager get routes =>
      $$RoutesTableTableManager(_db, _db.routes);
  $$WaypointsTableTableManager get waypoints =>
      $$WaypointsTableTableManager(_db, _db.waypoints);
  $$VesselProfilesTableTableManager get vesselProfiles =>
      $$VesselProfilesTableTableManager(_db, _db.vesselProfiles);
  $$SkipperSettingsTableTableTableManager get skipperSettingsTable =>
      $$SkipperSettingsTableTableTableManager(_db, _db.skipperSettingsTable);
  $$RecordedTracksTableTableManager get recordedTracks =>
      $$RecordedTracksTableTableManager(_db, _db.recordedTracks);
  $$TrackPointsTableTableManager get trackPoints =>
      $$TrackPointsTableTableManager(_db, _db.trackPoints);
}
