import 'package:hive/hive.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

part 'hotel_database_model.g.dart';

@HiveType(typeId: 0)
class HotelHiveModel extends HiveObject {
  @HiveField(0)
  final String hotelId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String destination;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final double ratingScore;

  @HiveField(5)
  final int days;

  @HiveField(6)
  final int nights;

  @HiveField(7)
  final String roomName;

  @HiveField(8)
  final String boarding;

  @HiveField(9)
  final int adultCount;

  @HiveField(10)
  final int childrenCount;

  @HiveField(11)
  final bool flightIncluded;

  @HiveField(12)
  final int totalPrice;

  @HiveField(13)
  final int pricePerPerson;

  @HiveField(14)
  final String scoreDescription;

  // Default constructor for HotelHiveModel
  HotelHiveModel({
    required this.hotelId,
    required this.name,
    required this.destination,
    required this.imageUrl,
    required this.ratingScore,
    required this.scoreDescription,
    required this.days,
    required this.nights,
    required this.roomName,
    required this.boarding,
    required this.adultCount,
    required this.childrenCount,
    required this.flightIncluded,
    required this.totalPrice,
    required this.pricePerPerson,
  });
}

extension HotelEntityMapper on HotelEntity {
  HotelHiveModel toHiveModel() {
    return HotelHiveModel(
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

