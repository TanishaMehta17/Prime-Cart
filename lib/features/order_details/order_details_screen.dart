import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/constants/globalvariable.dart';
import 'package:amazon_clone/features/admin/services/admin_service.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currenStep = 0;
  final AdminServices adminServices = AdminServices();

  void navigateToSearchScrren(String query) {
    Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: query);
  }

  //only for admin
  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status + 1,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currenStep += 1;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    currenStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            // as app bar does not allow you to have a gradient or a widget we use flexibe space which will hv a conatiner containing a gradient effect
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1,
                          child: TextFormField(
                              onFieldSubmitted: navigateToSearchScrren,
                              decoration: InputDecoration(
                                  prefixIcon: InkWell(
                                      onTap: () {},
                                      child: const Padding(
                                        padding: EdgeInsets.only(left: 6),
                                        child: Icon(Icons.search),
                                      )),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      const EdgeInsets.only(top: 10),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(7),
                                    ),
                                    borderSide: BorderSide(
                                        color: Colors.black38, width: 1),
                                  ),
                                  hintText: "Search Amazon.in",
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ))),
                        )),
                  ),
                  Container(
                      color: Colors.transparent,
                      height: 42,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(
                        Icons.mic,
                        color: Colors.black,
                        size: 25,
                      ))
                ]),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("View order details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Date:        ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.order.orderedAt),
                    )}"),
                    Text("Order Id :         ${widget.order.id}"),
                    Text("Order Total:       \$${widget.order.totalPrice}"),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Purchase Deatils",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0;
                        i < widget.order.products.length;
                        i++) // dont add {} as they are collection in flutter
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(' QTY: ${widget.order.quantity[i]}'),
                            ],
                          ))
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Tracking",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Stepper(
                      currentStep: currenStep,
                      controlsBuilder: (context, details) {
                        if (user.type == 'admin') {
                          return CustomButton(
                            text: 'Done',
                            onTap: () => changeOrderStatus(details.currentStep),
                          );
                        }
                        return const SizedBox();
                      },
                      steps: [
                        Step(
                          title: const Text('Pending'),
                          content:
                              const Text('Your order is yet to be delivered'),
                          isActive: currenStep > 0,
                          state: currenStep > 0
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text('Completed'),
                          content: const Text(
                              'Your order has been delivered, you are yet to sign.'),
                          isActive: currenStep > 1,
                          state: currenStep > 1
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text('Recieved'),
                          content: const Text(
                              'Your order has been delivered and signed by you.'),
                          isActive: currenStep > 2,
                          state: currenStep > 2
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text('Delivered'),
                          content: const Text(
                              'Your order has been delivered and signed by you!'),
                          isActive: currenStep >= 3,
                          state: currenStep >= 3
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
