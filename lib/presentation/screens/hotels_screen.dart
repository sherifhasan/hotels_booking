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
      appBar: AppBar(title: const Text('Hotels')),
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (hotels) => RefreshIndicator(
              onRefresh: () async {
                context.read<HotelCubit>().fetchHotels();
              },
              child: ListView.builder(
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];

                  return HotelCard(
                    hotel: hotel,
                    onFavoriteClick: (hotelId) {
                      final isFavourite = context
                          .read<FavouriteCubit>()
                          .isFavourite(hotel.hotelId);

                      if (isFavourite) {
                        // Remove from favorites
                        context.read<FavouriteCubit>().removeFavourite(hotelId);
                      } else {
                        // Add to favorites
                        context.read<FavouriteCubit>().addFavourite(hotel);
                      }
                    },
                  );
                },
              ),
            ),
            empty: () => const Center(child: Text('No hotels available')),
            error: (message) => _ErrorView(
              message: 'Error: $message',
              onRetry: () => context.read<HotelCubit>().fetchHotels(),
            ),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
