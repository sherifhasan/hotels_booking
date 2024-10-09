import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/data/storage/hotel_database_model.dart';

extension HotelHiveModelMapper on HotelHiveModel {
  HotelEntity toEntity() {
    return HotelEntity(
      hotelId: hotelId,
      name: name,
      destination: destination,
      imageUrl: imageUrl,
      ratingScore: ratingScore,
      scoreDescription: scoreDescription,
      days: days,
      nights: nights,
      roomName: roomName,
      boarding: boarding,
      adultCount: adultCount,
      childrenCount: childrenCount,
      flightIncluded: flightIncluded,
      totalPrice: totalPrice,
      pricePerPerson: pricePerPerson,
    );
  }
}
