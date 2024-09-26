import 'package:freezed_annotation/freezed_annotation.dart';

part 'hotel_dto.freezed.dart';

part 'hotel_dto.g.dart';

@freezed
class ResponseDTO with _$ResponseDTO {
  const factory ResponseDTO({
    @JsonKey(name: 'hotel-count') required int hotelCount,
    required List<HotelDTO> hotels,
  }) = _ResponseDTO;

  factory ResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ResponseDTOFromJson(json);
}

@freezed
class HotelDTO with _$HotelDTO {
  const factory HotelDTO({
    @JsonKey(name: 'hotel-id') required String hotelId,
    required String name,
    required String destination,
    required List<HotelImageDTO> images,
    @JsonKey(name: 'rating-info') RatingInfoDTO? ratingInfo,
    @JsonKey(name: 'best-offer') BestOfferDTO? bestOffer,
    required double latitude,
    required double longitude,
    AnalyticsDTO? analytics,
    required int category,
    @JsonKey(name: 'category-type') String? categoryType,
  }) = _HotelDTO;

  factory HotelDTO.fromJson(Map<String, dynamic> json) =>
      _$HotelDTOFromJson(json);
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

@freezed
class RatingInfoDTO with _$RatingInfoDTO {
  const factory RatingInfoDTO({
    required double score,
    @JsonKey(name: 'reviews-count') required int reviewsCount,
    @JsonKey(name: 'score-description') required String scoreDescription,
  }) = _RatingInfoDTO;

  factory RatingInfoDTO.fromJson(Map<String, dynamic> json) =>
      _$RatingInfoDTOFromJson(json);
}

@freezed
class BestOfferDTO with _$BestOfferDTO {
  const factory BestOfferDTO({
    required int total,
    @JsonKey(name: 'original-travel-price') required int originalTravelPrice,
    @JsonKey(name: 'simple-price-per-person') required int simplePricePerPerson,
    @JsonKey(name: 'flight-included') required bool flightIncluded,
    @JsonKey(name: 'travel-date') required TravelDateDTO travelDate,
    required RoomsDTO rooms,
  }) = _BestOfferDTO;

  factory BestOfferDTO.fromJson(Map<String, dynamic> json) =>
      _$BestOfferDTOFromJson(json);
}

@freezed
class TravelDateDTO with _$TravelDateDTO {
  const factory TravelDateDTO({
    @JsonKey(name: 'departure-date') required String departureDate,
    @JsonKey(name: 'return-date') required String returnDate,
    required int days,
    required int nights,
  }) = _TravelDateDTO;

  factory TravelDateDTO.fromJson(Map<String, dynamic> json) =>
      _$TravelDateDTOFromJson(json);
}

@freezed
class RoomsDTO with _$RoomsDTO {
  const factory RoomsDTO({
    @JsonKey(name: 'overall') required OverallRoomDTO overall,
    @JsonKey(name: 'room-groups') required List<RoomGroupDTO> roomGroups,
  }) = _RoomsDTO;

  factory RoomsDTO.fromJson(Map<String, dynamic> json) =>
      _$RoomsDTOFromJson(json);
}

@freezed
class OverallRoomDTO with _$OverallRoomDTO {
  const factory OverallRoomDTO({
    required String boarding,
    required String name,
    @JsonKey(name: 'adult-count') required int adultCount,
    @JsonKey(name: 'children-count') required int childrenCount,
    @JsonKey(name: 'same-boarding') required bool sameBoarding,
  }) = _OverallRoomDTO;

  factory OverallRoomDTO.fromJson(Map<String, dynamic> json) =>
      _$OverallRoomDTOFromJson(json);
}

@freezed
class RoomGroupDTO with _$RoomGroupDTO {
  const factory RoomGroupDTO({
    required String boarding,
    required String name,
    required int quantity,
  }) = _RoomGroupDTO;

  factory RoomGroupDTO.fromJson(Map<String, dynamic> json) =>
      _$RoomGroupDTOFromJson(json);
}

@freezed
class AnalyticsDTO with _$AnalyticsDTO {
  const factory AnalyticsDTO({
    @JsonKey(name: 'select_item.item.0') AnalyticsItemDTO? selectItem,
  }) = _AnalyticsDTO;

  factory AnalyticsDTO.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsDTOFromJson(json);
}

@freezed
class AnalyticsItemDTO with _$AnalyticsItemDTO {
  const factory AnalyticsItemDTO({
    required String currency,
    required String itemCategory,
    required String itemCategory2,
    required String itemId,
    required String itemName,
    required String itemRooms,
    required String price,
    required String quantity,
  }) = _AnalyticsItemDTO;

  factory AnalyticsItemDTO.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsItemDTOFromJson(json);
}
