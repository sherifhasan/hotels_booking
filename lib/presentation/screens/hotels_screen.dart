import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels_booking/application/favourite/favourite_cubit.dart';
import 'package:hotels_booking/application/hotel/hotel_cubit.dart';

import 'widgets/hotel_card.dart';

@RoutePage()
class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hotels')),
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          return state.when(
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (hotels) => ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                return HotelCard(
                  hotel: hotels[index],
                  onFavoriteClick: (hotelId) {
                    final isFavourite =
                        context.read<FavouriteCubit>().isFavourite(hotelId);

                    if (isFavourite) {
                      // Remove from favorites
                      context.read<FavouriteCubit>().removeFavourite(hotelId);
                    } else {
                      // Add to favorites
                      context
                          .read<FavouriteCubit>()
                          .addFavourite(hotels[index]);
                    }
                  },
                );
              },
            ),
            empty: () => Center(child: Text('No hotels available')),
            error: (message) => Center(child: Text('Error: $message')),
          );
        },
      ),
    );
  }
}
