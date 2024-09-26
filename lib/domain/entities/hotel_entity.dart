import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotels_booking/infrastructure/dto_models/hotel_dto.dart';

part 'hotel_entity.freezed.dart';

@freezed
class HotelEntity with _$HotelEntity {
  const factory HotelEntity({
    required String hotelId,
    required String name,
    required String destination,
    required String imageUrl,
    required double ratingScore,
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

  // Factory method to convert a HotelDTO into a HotelEntity (for presentation)
  factory HotelEntity.fromDTO(HotelDTO dto) {
    return HotelEntity(
      hotelId: dto.hotelId,
      name: dto.name,
      destination: dto.destination,
      imageUrl: dto.images.isNotEmpty ? dto.images.first.large : '',
      ratingScore: dto.ratingInfo?.score ?? 0.0,
      days: dto.bestOffer?.travelDate.days ?? 0,
      nights: dto.bestOffer?.travelDate.nights ?? 0,
      roomName: dto.bestOffer?.rooms.overall.name ?? '',
      boarding: dto.bestOffer?.rooms.overall.boarding ?? '',
      adultCount: dto.bestOffer?.rooms.overall.adultCount ?? 0,
      childrenCount: dto.bestOffer?.rooms.overall.childrenCount ?? 0,
      flightIncluded: dto.bestOffer?.flightIncluded ?? false,
      totalPrice: dto.bestOffer?.total ?? 0,
      pricePerPerson: dto.bestOffer?.simplePricePerPerson ?? 0,
    );
  }
}
