import 'package:amazon_clone/constants/globalvariable.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});
  void navigateToCategoryPage(BuildContext context, String category) {
    // we will need ByildContext context here as it a staless widget
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      'assets/images/mobiles.jpeg',
      'assets/images/fashion.jpeg',
      'assets/images/essentials.jpeg',
      'assets/images/books.jpeg',
      'assets/images/appliances.jpeg',
    ];
    List<String> list1 = [
      'Mobiles',
      'Fashion',
      'Essentials',
      'Books',
      'Appliances',
    ];
    return SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemExtent: 80, //every item will have a width and hwight of 75
            itemCount: GlobalVariables.categoryImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => navigateToCategoryPage(
                    context, GlobalVariables.categoryImages[index]['title']!),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          list[index],
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                    Text(list1[index],
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400))
                  ],
                ),
              );
            }));
  }
}
