import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_entity.freezed.dart';

@freezed
class HotelEntity with _$HotelEntity {
  const factory HotelEntity({
    required String hotelId,
    required String name,
    required String destination,
    required String imageUrl,
    required double ratingScore,
    required String scoreDescription,
    required int days,
    required int nights,
    required String roomName,
    required String boarding,
    required int adultCount,
    required int childrenCount,
    required bool flightIncluded,
    required int totalPrice,
    required int pricePerPerson,
  }) = _HotelEntity;
}
