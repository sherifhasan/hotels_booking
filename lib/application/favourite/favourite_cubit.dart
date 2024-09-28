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
          (favourites) => favourites.isEmpty
          ? emit(const FavouriteState.empty())
          : emit(FavouriteState.loaded(favourites)),
    );
  }

  Future<void> addFavourite(HotelEntity hotel) async {
    state.maybeWhen(
      loaded: (favourites) {
        final updatedFavourites = [...favourites, hotel];
        emit(FavouriteState.loaded(updatedFavourites));
      },
      empty: () {
        // If currently empty, move to loaded state when a favorite is added
        emit(FavouriteState.loaded([hotel]));
      },
      orElse: () {},
    );
    await addToFavourites(hotel); // Save to local storage/database
  }

  Future<void> removeFavourite(String hotelId) async {
    state.maybeWhen(
      loaded: (favourites) {
        final updatedFavourites =
        favourites.where((hotel) => hotel.hotelId != hotelId).toList();
        if (updatedFavourites.isEmpty) {
          emit(const FavouriteState.empty());
        } else {
          emit(FavouriteState.loaded(updatedFavourites));
        }
      },
      orElse: () {},
    );
    await removeFromFavourites(hotelId); // Remove from local storage/database
  }

  bool isFavourite(String hotelId) {
    return state.maybeWhen(
      loaded: (favourites) =>
          favourites.any((hotel) => hotel.hotelId == hotelId),
      orElse: () => false,
    );
  }
}
