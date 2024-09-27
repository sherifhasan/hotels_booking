import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

import 'failure.dart';

abstract class AppRepository {
  Future<Either<Failure, List<HotelEntity>>> fetchHotels();

  // Favourites
  Either<Exception, List<HotelEntity>> getFavourites();

  Future<Either<Exception, void>> addToFavourites(HotelEntity hotel);

  Future<Either<Exception, void>> removeFromFavourites(String hotelId);
}
