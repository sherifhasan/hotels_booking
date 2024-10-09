import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotels_booking/presentation/cubits/favourite/favourite_cubit.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

import 'hotel_details.dart';
import 'rating_badge.dart';

class HotelCard extends StatelessWidget {
  final HotelEntity hotel;
  final Function(String hotelId)? onFavoriteClick;
  final bool isFavoriteScreen;

  const HotelCard({
    super.key,
    required this.hotel,
    this.onFavoriteClick,
    this.isFavoriteScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: hotel.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                placeholder: (context, url) => const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => const SizedBox(
                  height: 200,
                  child: Center(child: Text('Image not available')),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: BlocSelector<FavouriteCubit, FavouriteState, bool>(
                  selector: (state) {
                    return state.maybeWhen(
                      loaded: (favourites) =>
                          favourites.any((fav) => fav.hotelId == hotel.hotelId),
                      orElse: () => false,
                    );
                  },
                  builder: (context, isFavourite) {
                    return IconButton(
                      onPressed: () {
                        onFavoriteClick?.call(hotel.hotelId);
                      },
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border,
                        size: 36,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              if (isFavoriteScreen)
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: RatingBadge(
                    ratingScore: hotel.ratingScore,
                    scoreDescription: hotel.scoreDescription,
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  hotel.destination,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
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
                // Extra details for HotelsScreen only
                if (!isFavoriteScreen) HotelDetails(hotel: hotel),
                const SizedBox(height: 16),
                // Call to Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isFavoriteScreen) {
                        // show More details for hotel
                      } else {
                        // show best offers
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      isFavoriteScreen ? 'Zum Hotel' : 'Zu den Angeboten',
                      style: const TextStyle(
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
