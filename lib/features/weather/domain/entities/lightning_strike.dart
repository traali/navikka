import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'lightning_strike.freezed.dart';

@freezed
abstract class LightningStrike with _$LightningStrike {
  const factory LightningStrike({
    required DateTime time,
    required LatLng location,
    required double peakCurrent, // in kA
    @Default(0) int multiplicity,
  }) = _LightningStrike;
}

extension LightningStrikeX on LightningStrike {
  int get ageMinutes => DateTime.now().difference(time).inMinutes;
}
