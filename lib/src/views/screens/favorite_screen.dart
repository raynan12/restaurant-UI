import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese/core/app_color.dart';
import 'package:japanese/core/app_extension.dart';
import 'package:japanese/core/app_icon.dart';
import 'package:japanese/src/controllers/food_controller.dart';
import 'package:japanese/src/views/widgets/empty_widget.dart';

import '../../models/food.dart';

final FoodController controller = Get.put(FoodController());

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Screen',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: EmptyWidget(
        type: EmptyWidgetType.favorite,
        title: 'Empty favorite',
        condition: controller.favoriteFood.isNotEmpty,
        child: ListView.separated(
          padding: EdgeInsets.all(15),
          itemCount: controller.favoriteFood.length,
          itemBuilder: (_, index) {
            Food food = controller.favoriteFood[index];
            return Card(
              color: controller.isLightTheme
                  ? Colors.white
                  : DarkThemeColor.primaryLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)
              ),
              child: ListTile(
                title: 
                Text(food.name, style: Theme.of(context).textTheme.headline4,),
                leading: Image.asset(food.image),
                subtitle: Text(
                  food.description,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                trailing: Icon(AppIcon.heart, color: Colors.redAccent,),
              ),
            ).fadeAnimation(index * 0.6);
          }, 
          separatorBuilder: (BuildContext context, int index) {
            return Padding(padding: EdgeInsets.only(bottom: 15));
          }, 
        ),
      ),
    );
  }
}