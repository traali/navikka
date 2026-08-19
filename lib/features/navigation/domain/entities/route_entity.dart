import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_entity.freezed.dart';

@freezed
abstract class RouteEntity with _$RouteEntity {
  const factory RouteEntity({
    required int id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isActive,
    required double totalDistanceMeters,
  }) = _RouteEntity;
}
