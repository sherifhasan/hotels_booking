import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';
import 'package:hotels_booking/domain/usecases/favourite/favourite_usecases.dart';
import 'package:hotels_booking/domain/failure.dart';

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
      (failure) => emit(FavouriteState.error(_mapFailureToMessage(failure))),
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

    final result = await addToFavourites(hotel);
    result.fold(
      (failure) {
        emit(FavouriteState.error(_mapFailureToMessage(failure)));
        // Optionally revert the optimistic UI update
        loadFavourites();
      },
      (_) => {},
    );
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

    final result = await removeFromFavourites(hotelId);
    result.fold(
      (failure) {
        emit(FavouriteState.error(_mapFailureToMessage(failure)));
        // Optionally revert the optimistic UI update
        loadFavourites();
      },
      (_) => {},
    );
  }

  bool isFavourite(String hotelId) {
    return state.maybeWhen(
      loaded: (favourites) =>
          favourites.any((hotel) => hotel.hotelId == hotelId),
      orElse: () => false,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure _:
        return 'Database error occurred.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
