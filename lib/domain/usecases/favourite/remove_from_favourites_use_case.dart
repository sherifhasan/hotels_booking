import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';

class RemoveFromFavouritesUseCase {
  final AppRepository repository;

  RemoveFromFavouritesUseCase(this.repository);

  Future<Either<Exception, void>> call(String hotelId) {
    return repository.removeFromFavourites(hotelId);
  }
}
