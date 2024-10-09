import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels_booking/presentation/cubits/favourite/favourite_cubit.dart';
import 'widgets/hotel_card.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (hotels) => ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final hotel = hotels[index];
                return HotelCard(
                  isFavoriteScreen: true,
                  hotel: hotel,
                  onFavoriteClick: (hotelId) {
                    final isFavourite =
                        context.read<FavouriteCubit>().isFavourite(hotelId);
                    if (isFavourite) {
                      context.read<FavouriteCubit>().removeFavourite(hotelId);
                    } else {
                      context.read<FavouriteCubit>().addFavourite(hotel);
                    }
                  },
                );
              },
            ),
            empty: () => const Center(child: Text('No Favorites available')),
            error: (message) => Center(child: Text('Error: $message')),
          );
        },
      ),
    );
  }
}
