import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_dto.freezed.dart';

part 'hotel_dto.g.dart';

@freezed
class HotelDTO with _$HotelDTO {
  const factory HotelDTO({
    @JsonKey(name: 'hotel-id') required String hotelId,
    @JsonKey(name: 'destination') required String destination,
    @JsonKey(name: 'category') required int category,
    @JsonKey(name: 'best-offer') required BestOfferDTO bestOffer,
    required List<HotelImageDTO> images,
  }) = _HotelDTO;

  factory HotelDTO.fromJson(Map<String, dynamic> json) =>
      _$HotelDTOFromJson(json);
}

@freezed
class BestOfferDTO with _$BestOfferDTO {
  const factory BestOfferDTO({
    @JsonKey(name: 'travel-price') required double travelPrice,
    @JsonKey(name: 'flight-included') required bool flightIncluded,
    @JsonKey(name: 'rooms') required RoomsDTO rooms,
    @JsonKey(name: 'travel-date') required TravelDateDTO travelDate,
  }) = _BestOfferDTO;

  factory BestOfferDTO.fromJson(Map<String, dynamic> json) =>
      _$BestOfferDTOFromJson(json);
}

@freezed
class RoomsDTO with _$RoomsDTO {
  const factory RoomsDTO({
    required String name,
    @JsonKey(name: 'adult-count') required int adultCount,
    @JsonKey(name: 'children-count') required int childrenCount,
  }) = _RoomsDTO;

  factory RoomsDTO.fromJson(Map<String, dynamic> json) =>
      _$RoomsDTOFromJson(json);
}

@freezed
class TravelDateDTO with _$TravelDateDTO {
  const factory TravelDateDTO({
    required int days,
    required int nights,
  }) = _TravelDateDTO;

  factory TravelDateDTO.fromJson(Map<String, dynamic> json) =>
      _$TravelDateDTOFromJson(json);
}

@freezed
class HotelImageDTO with _$HotelImageDTO {
  const factory HotelImageDTO({
    required String large,
    required String small,
  }) = _HotelImageDTO;

  factory HotelImageDTO.fromJson(Map<String, dynamic> json) =>
      _$HotelImageDTOFromJson(json);
}
