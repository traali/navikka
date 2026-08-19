import 'package:flutter_map/flutter_map.dart';
import 'package:sakkoja/features/navigation_aids/data/models/fairway_area_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_aid_dto.dart';
import 'package:sakkoja/features/navigation_aids/data/models/navigation_line_dto.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/fairway_area.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_aid_type.dart';
import 'package:sakkoja/features/navigation_aids/domain/entities/navigation_line.dart';

extension FairwayAreaDtoX on FairwayAreaDto {
  FairwayArea toEntity() {
    LatLngBounds? bounds;
    if (rings.isNotEmpty && rings.first.isNotEmpty) {
      bounds = LatLngBounds.fromPoints(rings.first);
    }

    return FairwayArea(
      id: id,
      name: name,
      navigationDepth: navigationDepth,
      sweptDepth: sweptDepth,
      qualityClass: qualityClass,
      fairwayType: fairwayType,
      status: status,
      buoyageSystem: buoyageSystem,
      rings: rings,
      bounds: bounds,
    );
  }
}

extension NavigationAidDtoX on NavigationAidDto {
  NavigationAid toEntity() {
    return NavigationAid(
      id: id,
      type: NavigationAidType.values.firstWhere(
        (t) => t.name == type.name,
        orElse: () => NavigationAidType.safetyEquipment,
      ),
      name: name,
      position: position,
      mounting: mounting != null
          ? (() {
              for (final m in NavigationAidMounting.values) {
                if (m.name == mounting!.name) return m;
              }
              return null;
            })()
          : null,
      ialaCode: ialaCode,
      lightCharacteristics: lightCharacteristics,
      lightRangeNm: lightRangeNm,
      signTypeCode: signTypeCode,
      signTypeDescription: signTypeDescription,
      restrictionValue: restrictionValue,
      owner: owner,
    );
  }
}

extension NavigationLineDtoX on NavigationLineDto {
  NavigationLine toEntity() {
    return NavigationLine(
      id: id,
      name: name,
      points: points,
      bounds: points.isEmpty ? null : LatLngBounds.fromPoints(points),
      navigationDepth: navigationDepth,
      sweptDepth: sweptDepth,
      fairwayClass: fairwayClass,
      isBoatingRoute: isBoatingRoute,
    );
  }
}
