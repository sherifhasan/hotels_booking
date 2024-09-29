import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/failure.dart';

class GetFavouritesUseCase {
  final AppRepository repository;

  GetFavouritesUseCase(this.repository);

  Either<Failure, List<HotelEntity>> call() {
    return repository.getFavourites();
  }
}
