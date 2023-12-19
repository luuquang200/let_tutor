import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;

  const StarRating({Key? key, required this.rating, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (rating == 0) {
      return const Text('No reviews yet');
    } else {
      return Row(
        children: List<Widget>.generate(
          5,
          (index) => Icon(
            Icons.star,
            color: index < rating ? Colors.amber : Colors.grey,
            size: size,
          ),
        ),
      );
    }
  }
}
