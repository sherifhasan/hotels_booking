import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/failure.dart';

class AddToFavouritesUseCase {
  final AppRepository repository;

  AddToFavouritesUseCase(this.repository);

  Future<Either<Failure, void>> call(HotelEntity hotel) {
    return repository.addToFavourites(hotel);
  }
}
