import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final String images;
  const SingleProduct({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(10),
            child: Image.network(
              images,
              fit: BoxFit.fitHeight,
              width: 180,
            ),
          ),
        ));
  }
}
