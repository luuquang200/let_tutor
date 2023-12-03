import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;

  const StarRating({super.key, required this.rating, required this.size});

  @override
  Widget build(BuildContext context) {
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
