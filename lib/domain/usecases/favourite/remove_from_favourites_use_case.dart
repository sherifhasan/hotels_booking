import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';
import 'package:hotels_booking/domain/failure.dart';

class RemoveFromFavouritesUseCase {
  final AppRepository repository;

  RemoveFromFavouritesUseCase(this.repository);

  Future<Either<Failure, void>> call(String hotelId) {
    return repository.removeFromFavourites(hotelId);
  }
}
