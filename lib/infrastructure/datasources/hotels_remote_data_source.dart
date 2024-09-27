import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hotels_booking/domain/failure.dart';
import 'package:hotels_booking/infrastructure/dto_models/hotel_dto.dart';
import 'package:hotels_booking/infrastructure/error_handlers/dio_error_handler.dart';

class HotelRemoteDataSource {
  final String apiUrl = 'https://dkndmolrswy7b.cloudfront.net/hotels.json';
  final Dio dio;

  HotelRemoteDataSource(this.dio);

  Future<Either<Failure, List<HotelDTO>>> getHotels() async {
    try {
      final response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Check if the response matches the expected structure
        if (data is Map<String, dynamic> && data.containsKey('hotels')) {
          final responseDTO = ResponseDTO.fromJson(
              data); // Parse the response using ResponseDTO
          return Right(responseDTO.hotels); // Return the list of hotels
        } else {
          return Left(ServerFailure('Unexpected response structure.'));
        }
      } else {
        return Left(ServerFailure('Invalid response: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      // Handle Dio exceptions using a custom error handler
      return Left(DioErrorHandler.handleDioError(e));
    } catch (e) {
      // Handle generic errors
      return Left(DioErrorHandler.handleGenericError(e));
    }
  }
}
