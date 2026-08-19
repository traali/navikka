import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'wave_data.freezed.dart';

@freezed
abstract class WaveData with _$WaveData {
  const factory WaveData({
    required DateTime timestamp,
    required LatLng location,
    required String? stationName,
    required double? waveHeight,
    required double? wavePeriod,
    required double? waveDirection,
    required double? waterTemperature,
  }) = _WaveData;
}
