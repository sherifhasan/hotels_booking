import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/usecases/favourite/favourite_usecases.dart';

part 'favourite_state.dart';

part 'favourite_cubit.freezed.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  final AddToFavouritesUseCase addToFavourites;
  final RemoveFromFavouritesUseCase removeFromFavourites;
  final GetFavouritesUseCase getFavourites;

  FavouriteCubit(
    this.getFavourites,
    this.addToFavourites,
    this.removeFromFavourites,
  ) : super(const FavouriteState.loading());

  Future<void> loadFavourites() async {
    emit(const FavouriteState.loading());
    final result = getFavourites();
    result.fold(
      (error) => emit(FavouriteState.error('Failed to load favourites')),
      (favourites) => emit(favourites.isEmpty
          ? const FavouriteState.empty()
          : FavouriteState.loaded(favourites)),
    );
  }

  Future<void> addFavourite(HotelEntity hotel) async {
    await addToFavourites(hotel);
    loadFavourites();
  }

  Future<void> removeFavourite(String hotelId) async {
    await removeFromFavourites(hotelId);
    loadFavourites();
  }

  bool isFavourite(String hotelId) {
    return state.maybeWhen(
      loaded: (favourites) =>
          favourites.any((hotel) => hotel.hotelId == hotelId),
      orElse: () => false,
    );
  }
}
