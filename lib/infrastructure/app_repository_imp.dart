import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/failure.dart';
import 'package:hotels_booking/infrastructure/datasources/favourite_local_data_source.dart';
import 'package:hotels_booking/infrastructure/datasources/hotels_remote_data_source.dart';
import 'package:hotels_booking/infrastructure/mappers/mappers.dart';
import 'package:hotels_booking/infrastructure/storage/hotel_database_model.dart';

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
        final hotels = hotelDTOs.map((dto) => dto.toEntity()).toList();
        return Right(hotels); // Return success with HotelEntities
      },
    );
  }

  @override
  Either<Failure, List<HotelEntity>> getFavourites() {
    final favourites = favouriteLocalDataSource.getFavourites();
    return favourites.fold((failure) => Left(DatabaseFailure(failure.message)),
        (savedHotels) {
      return Right(savedHotels.map((hotel) => hotel.toEntity()).toList());
    });
  }

  @override
  Future<Either<Failure, void>> addToFavourites(HotelEntity hotel) async {
    final result =
        await favouriteLocalDataSource.addToFavourites(hotel.toHiveModel());
    return result.fold(
      (failure) => Left(DatabaseFailure(failure.message)), // Handle failure
      (success) => const Right(null), // Pass success as Right
    );
  }

  @override
  Future<Either<Failure, void>> removeFromFavourites(String hotelId) async {
    final result = await favouriteLocalDataSource.removeFromFavourites(hotelId);
    return result.fold(
      (failure) => Left(DatabaseFailure(failure.message)), // Handle failure
      (success) => const Right(null), // Pass success as Right
    );
  }
}
