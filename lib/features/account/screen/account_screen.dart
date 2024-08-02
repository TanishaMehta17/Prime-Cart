import 'package:amazon_clone/constants/globalvariable.dart';
import 'package:amazon_clone/features/account/widgets/below_app_bar.dart';
import 'package:amazon_clone/features/account/widgets/orders.dart';
import 'package:amazon_clone/features/account/widgets/top_button.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              // as app bar does not allow you to have a gradient or a widget we use flexibe space which will hv a conatiner containing a gradient effect
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient),
              ),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/images/amazon.png',
                          width: 120,
                          height: 45,
                          color: Colors.black,
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(Icons.notifications_outlined),
                            ),
                            Icon(Icons.search),
                          ],
                        ))
                  ]),
            )),
        body: const Column(
          children: [
            BelowAppBar(),
            SizedBox(height: 10),
            TopButtons(),
            SizedBox(height: 20),
            Orders(),
          ],
        ));
  }
}
