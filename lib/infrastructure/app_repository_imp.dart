import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/failure.dart';
import 'package:hotels_booking/infrastructure/datasources/favourite_local_data_source.dart';
import 'package:hotels_booking/infrastructure/storage/hotel_database_model.dart';

import 'datasources/hotels_remote_data_source.dart';

class AppRepositoryImp implements AppRepository {
  final HotelRemoteDataSource remoteDataSource;
  final FavouriteLocalDataSource favouriteLocalDataSource;

  AppRepositoryImp(this.remoteDataSource, this.favouriteLocalDataSource);

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

  @override
  Either<Exception, List<HotelEntity>> getFavourites() {
    try {
      final favourites = favouriteLocalDataSource.getFavourites();
      return Right(favourites.map((hotel) => hotel.toEntity()).toList());
    } catch (e) {
      return Left(Exception('Failed to load favourites'));
    }
  }

  @override
  Future<Either<Exception, void>> addToFavourites(HotelEntity hotel) async {
    try {
      await favouriteLocalDataSource.addToFavourites(hotel.toHiveModel());
      return Right(null);
    } catch (e) {
      return Left(Exception('Failed to add to favourites'));
    }
  }

  @override
  Future<Either<Exception, void>> removeFromFavourites(String hotelId) async {
    try {
      await favouriteLocalDataSource.removeFromFavourites(hotelId);
      return Right(null);
    } catch (e) {
      return Left(Exception('Failed to remove from favourites'));
    }
  }
}
