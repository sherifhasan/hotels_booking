import 'package:flutter/material.dart';
import 'package:hotels_booking/domain/entities/hotel_entity.dart';

class HotelDetails extends StatelessWidget {
  final HotelEntity hotel;

  const HotelDetails({
    super.key,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stay duration (days and nights)
        Text(
          '${hotel.days} Tage | ${hotel.nights} Nächte',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),

        // Room details and meal plan
        Text(
          '${hotel.roomName} | ${hotel.boarding}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),

        // Guest information and flight inclusion
        Text(
          '${hotel.adultCount} Erw., ${hotel.childrenCount} Kinder | ${hotel.flightIncluded ? "inkl. Flug" : ""}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),

        // Price information
        Text(
          'ab ${hotel.totalPrice / 100} €',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),

        // Price per person
        Text(
          '${hotel.pricePerPerson / 100} € p.P.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
