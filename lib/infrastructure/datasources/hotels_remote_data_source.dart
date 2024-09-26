import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hotels_booking/domain/failure.dart';
import 'package:hotels_booking/infrastructure/dto_models/hotel_dto.dart';
import 'package:hotels_booking/infrastructure/error_handlers/dio_error_handler.dart';

class HotelRemoteDataSource {
  final Dio dio;

  HotelRemoteDataSource(this.dio);

  Future<Either<Failure, List<HotelDTO>>> getHotels() async {
    try {
      final response =
          await dio.get('https://dkndmolrswy7b.cloudfront.net/hotels.json');

      if (response.statusCode == 200) {
        final List data = response.data;
        final hotels = data.map((json) => HotelDTO.fromJson(json)).toList();
        return Right(hotels); // Return the success (Right) with hotel data
      } else {
        return Left(ServerFailure('Invalid response: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      // Use DioErrorHandler to map DioException to Failure and return Left
      return Left(DioErrorHandler.handleDioError(e));
    } catch (e) {
      // Return a generic failure in case of any other errors
      return Left(DioErrorHandler.handleGenericError(e));
    }
  }
}
