import 'package:dio/dio.dart';
import 'package:hotels_booking/domain/failure.dart';

class DioErrorHandler {
  // Handle Dio errors and return appropriate Failure
  static Failure handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Connection timed out, please try again.');

      case DioExceptionType.badResponse:
        return ServerFailure(
            'Received invalid status code: ${e.response?.statusCode}');

      case DioExceptionType.connectionError:
        return NetworkFailure(
            'Please check your internet connection and try again.');

      default:
        return UnexpectedFailure('Unexpected error occurred: ${e.message}');
    }
  }

  // Handle generic errors that are not Dio-specific
  static Failure handleGenericError(dynamic e) {
    return UnexpectedFailure('Failed to fetch data: $e');
  }
}
