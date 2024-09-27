import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotels_booking/application/favourite/favourite_cubit.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

class HotelCard extends StatelessWidget {
  final HotelEntity hotel;
  final Function(String hotelId)? onFavoriteClick;
  final Function(String hotelId)? onActionButtonClick;

  const HotelCard({
    super.key,
    required this.hotel,
    this.onFavoriteClick,
    this.onActionButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    final isFavourite =
        context.read<FavouriteCubit>().isFavourite(hotel.hotelId);
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                hotel.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 200,
                    child: Center(child: Text('Image not available')),
                  );
                },
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    onFavoriteClick?.call(hotel.hotelId);
                  },
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    size: 32,
                    color: isFavourite ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel name
                Text(
                  hotel.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge, // Use the titleLarge style from the theme
                ),

                const SizedBox(height: 8),

                // Hotel destination
                Text(
                  hotel.destination,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Use the bodyMedium style from the theme
                ),

                const SizedBox(height: 8),

                // Star rating
                Row(
                  children: List.generate(
                    hotel.ratingScore.toInt(),
                    (index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Stay duration (days and nights)
                Text(
                  '${hotel.days} Tage | ${hotel.nights} Nächte',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Use the bodyMedium style from the theme
                ),

                const SizedBox(height: 8),

                // Room details and meal plan
                Text(
                  '${hotel.roomName} | ${hotel.boarding}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Use the bodyMedium style from the theme
                ),

                const SizedBox(height: 8),

                // Guest information and flight inclusion
                Text(
                  '${hotel.adultCount} Erw., ${hotel.childrenCount} Kinder | ${hotel.flightIncluded ? "inkl. Flug" : ""}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Use the bodyMedium style from the theme
                ),

                const SizedBox(height: 8),

                // Price information
                Text(
                  'ab ${hotel.totalPrice / 100} €',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ), // Use titleLarge with bold style
                ),

                const SizedBox(height: 4),

                // Price per person
                Text(
                  '${hotel.pricePerPerson / 100} € p.P.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium, // Use the bodyMedium style from the theme
                ),

                const SizedBox(height: 16),

                // Call to Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your action here (e.g., navigate to a details page)
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Theme.of(context)
                          .primaryColor, // Use the primary color from the theme
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Zu den Angeboten',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
