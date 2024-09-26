import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hotels_booking/infrastructure/dto_models/hotel_dto.dart';

class HotelRemoteDataSource {
  final Dio dio;
  final String apiUrl = 'https://dkndmolrswy7b.cloudfront.net/hotels.json';

  HotelRemoteDataSource(this.dio);

  Future<List<HotelDTO>> getHotels() async {
    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200) {
        final List data = await compute(parseHotelsJson, response.data);
        return data.map((json) => HotelDTO.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Server returned status code: ${response.statusCode}',
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timed out, please try again.');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception(
            'Received invalid status code: ${e.response?.statusCode}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Please check your internet connection and try again.');
      }
      throw Exception('Unexpected error occurred: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load hotels: $e');
    }
  }
}

List parseHotelsJson(dynamic responseBody) {
  return jsonDecode(responseBody) as List;
}
