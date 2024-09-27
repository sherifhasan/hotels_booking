import 'package:flutter/material.dart';

class RatingBadge extends StatelessWidget {
  final double ratingScore;
  final String scoreDescription;

  const RatingBadge({
    super.key,
    required this.ratingScore,
    required this.scoreDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.shade600,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.sentiment_satisfied_alt,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            '${ratingScore.toStringAsFixed(1)} / 5.0 $scoreDescription',
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            ' (${ratingScore.toInt()} Bew.)',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
