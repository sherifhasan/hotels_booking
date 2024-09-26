import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

import 'failure.dart';

abstract class AppRepository {
  Future<Either<Failure, List<HotelEntity>>> fetchHotels();
}
