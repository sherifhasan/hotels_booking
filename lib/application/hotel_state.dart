part of 'hotel_cubit.dart';


@freezed
class HotelState with _$HotelState {
  const factory HotelState.loading() = _Loading;
  const factory HotelState.loaded(List<HotelEntity> hotels) = _Loaded;
  const factory HotelState.empty() = _Empty;
  const factory HotelState.error(String message) = _Error;
}
