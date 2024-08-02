import 'package:amazon_clone/constants/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: GlobalVariables.secondaryColor,
      ),
      itemCount: 5,
      direction: Axis.horizontal,
      rating: rating,
      itemSize: 15,
    );
  }
}
