import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/failure.dart';

import 'datasources/hotels_remote_data_source.dart';

class AppRepositoryImp implements AppRepository {
  final HotelRemoteDataSource remoteDataSource;

  AppRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, List<HotelEntity>>> fetchHotels() async {
    final result = await remoteDataSource.getHotels();

    return result.fold(
      (failure) => Left(failure), // Propagate the failure
      (hotelDTOs) {
        final hotels =
            hotelDTOs.map((dto) => HotelEntity.fromDTO(dto)).toList();
        return Right(hotels); // Return success with HotelEntities
      },
    );
  }
}
