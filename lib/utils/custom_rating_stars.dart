import 'package:flutter/material.dart';

class CustomRatingStars extends StatelessWidget {
  final double rating;
  final int maxStars;
  final ValueChanged<double> onRatingChanged;

  const CustomRatingStars({
    Key? key,
    required this.rating,
    required this.maxStars,
    required this.onRatingChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () => onRatingChanged(index + 1.0),
        );
      }),
    );
  }
}
