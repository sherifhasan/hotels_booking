import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:hotels_booking/infrastructure/storage/hotel_database_model.dart';
import 'package:hotels_booking/domain/failure.dart';
import 'package:hotels_booking/setup.dart';

class FavouriteLocalDataSource {
  static const favouritesBox = 'favourites';
  final box = getIt<Box<HotelHiveModel>>();

  Either<Failure, List<HotelHiveModel>> getFavourites() {
    try {
      return Right(box.values.toList());
    } catch (e) {
      // Return a Failure with the error message
      return Left(DatabaseFailure('Error getting favourites: $e'));
    }
  }

  Future<Either<Failure, void>> addToFavourites(HotelHiveModel hotel) async {
    try {
      await box.put(hotel.hotelId, hotel);
      return const Right(null);
    } catch (e) {
      // Return a Failure with the error message
      return Left(DatabaseFailure('Error adding to favourites: $e'));
    }
  }

  Future<Either<Failure, void>> removeFromFavourites(String hotelId) async {
    try {
      await box.delete(hotelId);
      return const Right(null);
    } catch (e) {
      // Return a Failure with the error message
      return Left(DatabaseFailure('Error removing from favourites: $e'));
    }
  }
}
