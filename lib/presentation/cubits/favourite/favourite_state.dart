part of 'favourite_cubit.dart';

@freezed
class FavouriteState with _$FavouriteState {
  const factory FavouriteState.loading() = _Loading;

  const factory FavouriteState.loaded(List<HotelEntity> favourites) = _Loaded;

  const factory FavouriteState.empty() = _Empty;

  const factory FavouriteState.error(String message) = _Error;
}
