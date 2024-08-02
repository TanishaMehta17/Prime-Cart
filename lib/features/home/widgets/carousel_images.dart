import 'package:amazon_clone/constants/globalvariable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CaroselImage extends StatelessWidget {
  const CaroselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((i) {
        return Builder(
          builder: (BuildContext context) => Image.network(
            i,
            fit: BoxFit.cover,
            height: 200,
          ),
        );
      }).toList(), // Remove the semicolon here
      options: CarouselOptions(viewportFraction: 1, height: 200),
    );
  }
}
