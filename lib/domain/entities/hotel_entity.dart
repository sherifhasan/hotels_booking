import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotels_booking/infrastructure/dto_models/hotel_dto.dart';

part 'hotel_entity.freezed.dart';

@freezed
class HotelEntity with _$HotelEntity {
  const factory HotelEntity({
    required String id,
    required String destination,
    required int starRating,
    required String imageUrl,
    required String roomType,
    required double travelPrice,
    required int durationNights,
    required int adults,
    required int children,
    required bool flightIncluded,
  }) = _HotelEntity;

  // Factory method to convert a HotelDTO into a HotelEntity (for presentation)
  factory HotelEntity.fromDTO(HotelDTO dto) {
    return HotelEntity(
      id: dto.hotelId,
      destination: dto.destination,
      starRating: dto.category,
      // Take the first image as the main image
      imageUrl: dto.images.first.large,
      roomType: dto.bestOffer.rooms.name,
      travelPrice: dto.bestOffer.travelPrice,
      durationNights: dto.bestOffer.travelDate.nights,
      adults: dto.bestOffer.rooms.adultCount,
      children: dto.bestOffer.rooms.childrenCount,
      flightIncluded: dto.bestOffer.flightIncluded,
    );
  }
}
