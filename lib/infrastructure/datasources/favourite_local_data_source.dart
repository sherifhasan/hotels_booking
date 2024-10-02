import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:hotels_booking/infrastructure/storage/hotel_database_model.dart';
import 'package:hotels_booking/domain/failure.dart';

class FavouriteLocalDataSource {
  static const favouritesBox = 'favourites';
  final Box<HotelHiveModel> _box;

  FavouriteLocalDataSource(this._box);

  Either<Failure, List<HotelHiveModel>> getFavourites() {
    try {
      return Right(_box.values.toList());
    } catch (e) {
      // Return a Failure with the error message
      return Left(DatabaseFailure('Error getting favourites: $e'));
    }
  }

  Future<Either<Failure, void>> addToFavourites(HotelHiveModel hotel) async {
    try {
      await _box.put(hotel.hotelId, hotel);
      return const Right(null);
    } catch (e) {
      // Return a Failure with the error message
      return Left(DatabaseFailure('Error adding to favourites: $e'));
    }
  }

  Future<Either<Failure, void>> removeFromFavourites(String hotelId) async {
    try {
      await _box.delete(hotelId);
      return const Right(null);
    } catch (e) {
      // Return a Failure with the error message
      return Left(DatabaseFailure('Error removing from favourites: $e'));
    }
  }
}
