import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

class GetFavouritesUseCase {
  final AppRepository repository;

  GetFavouritesUseCase(this.repository);

  Either<Exception, List<HotelEntity>> call() {
    return repository.getFavourites();
  }
}
