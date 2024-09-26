import 'package:flutter/material.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

class HotelCard extends StatelessWidget {
  final HotelEntity hotel;

  const HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel image
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

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hotel name
                Text(
                  hotel.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Hotel destination
                Text(hotel.destination),

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
                Text('${hotel.days} Tage | ${hotel.nights} Nächte'),

                const SizedBox(height: 8),

                // Room details and meal plan
                Text('${hotel.roomName} | ${hotel.boarding}'),

                const SizedBox(height: 8),

                // Guest information and flight inclusion
                Text(
                    '${hotel.adultCount} Erw., ${hotel.childrenCount} Kinder | ${hotel.flightIncluded ? "inkl. Flug" : ""}'),

                const SizedBox(height: 8),

                // Price information
                Text(
                  'ab ${hotel.totalPrice / 100} €',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                // Price per person
                Text('${hotel.pricePerPerson / 100} € p.P.'),

                const SizedBox(height: 16),

                // Call to Action Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Add your action here (e.g., navigate to a details page)
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Button color
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      child: const Text(
                        'Zu den Angeboten',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
