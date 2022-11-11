import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese/core/app_color.dart';
import 'package:japanese/core/app_style.dart';
import 'package:japanese/src/controllers/food_controller.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_japanese_restaurant_app/core/app_color.dart';
import 'package:japanese/core/app_color.dart';
// import 'package:flutter_japanese_restaurant_app/core/app_extension.dart';
import 'package:japanese/core/app_extension.dart';
// import 'package:flutter_japanese_restaurant_app/src/view/widget/counter_button.dart';
import 'package:japanese/src/views/widgets/counter_button.dart';
// import 'package:flutter_japanese_restaurant_app/src/view/widget/empty_widget.dart';
import 'package:japanese/src/views/widgets/empty_widget.dart';
import 'package:get/get.dart';
import '../../../core/app_style.dart';
// import '../../controller/food_controller.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final FoodController controller = Get.put(FoodController());

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Cart Screen',
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  Widget _bottomAppBar(double height, double width, BuildContext context) {
    return BottomAppBar(
      child: SizedBox(
        height: height * 0.32,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
          child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal',
                          style: 
                          Theme.of(context).textTheme.headline5),
                        Obx(() {
                          return Text('\$${controller.subtotalPrice.value}',
                            style: 
                            Theme.of(context).textTheme.headline2);
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Taxes',
                          style: 
                          Theme.of(context).textTheme.headline5),
                        Text('\$${5.00}',
                          style: 
                          Theme.of(context).textTheme.headline2),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      thickness: 4.0,
                      height: 30.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                          style: 
                          Theme.of(context).textTheme.headline2),
                        Obx(() {
                          return Text(
                            controller.totalPrice.value ==5.0? '\$0.0' : '\$${controller.totalPrice}' ,
                            style: h2Style.copyWith(
                              color: LightThemeColor.accent),
                          );
                        })
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.1),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Check-out'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cartListView(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(30),
      shrinkWrap: true,
      itemCount: controller.cartFood.length,
      itemBuilder: (_, index) {
        return Dismissible(
          onDismissed: (direction) {
            if(direction==DismissDirection.startToEnd) {
              controller.removeCartItemAtSpecificIndex(index);
            }
          },
          key: Key(controller.cartFood[index].name),
          background: Row(children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(Icons.delete),
            ),
          ],),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: controller.isLightTheme
                ? Colors.white
                : DarkThemeColor.primaryLight,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 20,),
                Image.asset(controller.cartFood[index].image,
                  scale: 10,),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.cartFood[index].name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '\$${controller.cartFood[index].price}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    CounterButton(
                      onIncrementSelected: () =>
                            controller.increaseItem(
                              controller.cartFood[index]), 
                      onDecrementSelected: () =>
                          controller.decreaseItem(
                            controller.cartFood[index]),
                      size: Size(24, 24),
                      padding: 0, 
                      label: Text(
                        controller.cartFood[index].quantity
                          .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline2,
                      ),
                    ),
                    Text('\$${controller.calculatePricePerEachItem(
                      controller.cartFood[index])}',
                    )
                  ],
                ),
              ],
            ),
          ).fadeAnimation(index * 0.6),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(padding: EdgeInsets.all(10));
      }, 
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: controller.cartFood.isNotEmpty
        ? _bottomAppBar(height, width, context)
        : SizedBox(),
      appBar: _appBar(context),
      body: EmptyWidget(
        title: 'Empty cart',
        condition: controller.cartFood.isNotEmpty, 
        child: SingleChildScrollView(
          child: SizedBox(
            height: height*0.5,
            child: GetBuilder(
              builder: (FoodController controller) {
                return cartListView(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}