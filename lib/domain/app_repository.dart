import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

import 'failure.dart';

abstract class AppRepository {
  Future<Either<Failure, List<HotelEntity>>> fetchHotels();

  // Favourites
  Either<Failure, List<HotelEntity>> getFavourites();

  Future<Either<Failure, void>> addToFavourites(HotelEntity hotel);

  Future<Either<Failure, void>> removeFromFavourites(String hotelId);
}
