import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/infrastructure/dto_models/hotel_dto.dart';

extension HotelDTOMapper on HotelDTO {
  HotelEntity toEntity() {
    return HotelEntity(
      hotelId: hotelId,
      name: name,
      destination: destination,
      imageUrl: images.isNotEmpty ? images.first.large : '',
      ratingScore: ratingInfo?.score ?? 0.0,
      scoreDescription: ratingInfo?.scoreDescription ?? '',
      days: bestOffer?.travelDate.days ?? 0,
      nights: bestOffer?.travelDate.nights ?? 0,
      roomName: bestOffer?.rooms.overall.name ?? '',
      boarding: bestOffer?.rooms.overall.boarding ?? '',
      adultCount: bestOffer?.rooms.overall.adultCount ?? 0,
      childrenCount: bestOffer?.rooms.overall.childrenCount ?? 0,
      flightIncluded: bestOffer?.flightIncluded ?? false,
      totalPrice: bestOffer?.total ?? 0,
      pricePerPerson: bestOffer?.simplePricePerPerson ?? 0,
    );
  }
}
