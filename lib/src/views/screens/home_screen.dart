import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese/core/app_data.dart';
import 'package:japanese/src/controllers/food_controller.dart';
import 'package:japanese/src/views/screens/cart_screen.dart';
import 'package:japanese/src/views/screens/favorite_screen.dart';
import 'package:japanese/src/views/screens/food_list_screen.dart';
import 'package:japanese/src/views/screens/profile_screen.dart';
import 'package:japanese/src/views/widgets/page_transition.dart';

final FoodController controller = Get.put(FoodController());

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Widget> screen = [
    FoodListScreen(),
    CartScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PageTransition(
          child: screen[controller.currentBottomNavItemIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentBottomNavItemIndex.value,
          onTap: controller.switchBetweenBottomNavigationItems,
          selectedFontSize: 0,
          items: AppData.bottomNavigationItems.map(
            (element) {
              return BottomNavigationBarItem(
                icon: element.disableIcon,
                label: element.label,
                activeIcon: element.enableIcon);
            }).toList(),
        );
      }),
    );
  }
}