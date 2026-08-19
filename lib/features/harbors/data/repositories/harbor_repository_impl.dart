import 'package:fpdart/fpdart.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/errors/failure.dart';
import 'package:sakkoja/features/harbors/data/datasources/lipas_remote_data_source.dart';
import 'package:sakkoja/features/harbors/domain/entities/harbor.dart';
import 'package:sakkoja/features/harbors/domain/repositories/harbor_repository.dart';

class HarborRepositoryImpl implements HarborRepository {
  HarborRepositoryImpl({required this.remoteDataSource});

  final LipasRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<Harbor>>> getHarbors() async {
    try {
      final dtos = await remoteDataSource.fetchHarbors();
      final entities = dtos.map((dto) {
        HarborType type;
        if (dto.typeCode == 5120) {
          type = HarborType.excursionDock;
        } else if (dto.typeCode == 5130) {
          type = HarborType.boatRamp;
        } else if (dto.typeCode == 5110) {
          type = HarborType.guestHarbor;
        } else {
          type = HarborType.smallBoatHarbor;
        }

        return Harbor(
          id: dto.sportsPlaceId.toString(),
          name: dto.name,
          type: type,
          position: LatLng(dto.latitude, dto.longitude),
          municipality: dto.municipalityName,
          hasSauna: dto.hasSauna,
          hasCampfire: dto.hasCampfire,
          hasWater: dto.hasWater,
          hasElectricity: dto.hasElectricity,
          hasSepticPumpout: dto.hasSeptic,
          berthCount: dto.berths,
          depthMeters: dto.depthMeters,
        );
      }).toList();

      return right(entities);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
