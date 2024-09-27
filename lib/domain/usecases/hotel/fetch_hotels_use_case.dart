import 'package:dartz/dartz.dart';
import 'package:hotels_booking/domain/app_repository.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/failure.dart';

class FetchHotelsUseCase {
  final AppRepository repository;

  FetchHotelsUseCase(this.repository);

  Future<Either<Failure, List<HotelEntity>>> call() async {
    return await repository.fetchHotels();
  }
}
