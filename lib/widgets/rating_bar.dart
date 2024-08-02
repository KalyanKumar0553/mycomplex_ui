import 'package:flutter/material.dart';
import 'package:mycomplex_ui/colors.dart';

class RatingBar extends StatelessWidget {
  final double averageRating;
  final int totalRatings;
  final List<int> ratingCounts; // List of counts for each star rating [5-star, 4-star, 3-star, 2-star, 1-star]

  const RatingBar({super.key, 
    required this.averageRating,
    required this.totalRatings,
    required this.ratingCounts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(averageRating.toStringAsFixed(1), style: const TextStyle(color:AppColors.textColor, fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('Average Rating', style: TextStyle(color:AppColors.textColor)),
              ],
            ),
            Column(
              children: [
                Text(totalRatings.toString(), style: const TextStyle(color:AppColors.textColor, fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('Total Ratings', style: TextStyle(color:AppColors.textColor)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildRatingRow(5, ratingCounts[0], Colors.green),
        _buildRatingRow(4, ratingCounts[1], Colors.lightGreen),
        _buildRatingRow(3, ratingCounts[2], Colors.yellow),
        _buildRatingRow(2, ratingCounts[3], Colors.orange),
        _buildRatingRow(1, ratingCounts[4], Colors.red),
      ],
    );
  }

  Widget _buildRatingRow(int star, int count, Color color) {
    double percentage = (count / totalRatings) * 100;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('$star★'),
          const SizedBox(width: 8),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color:Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  height: 20,
                  width: percentage,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text('$count (${percentage.toStringAsFixed(0)}%)'),
        ],
      ),
    );
  }
}
