import 'package:flutter/material.dart';
// import 'package:flutter_japanese_restaurant_app/core/app_extension.dart';
import 'package:japanese/core/app_extension.dart';
// import 'package:flutter_japanese_restaurant_app/core/app_icon.dart';
import 'package:japanese/core/app_icon.dart';
// import 'package:flutter_japanese_restaurant_app/src/model/food.dart';
import 'package:japanese/src/models/food.dart';
// import 'package:flutter_japanese_restaurant_app/src/view/widget/counter_button.dart';
import 'package:japanese/src/views/widgets/counter_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/app_color.dart';
// import 'package:flutter_japanese_restaurant_app/src/controller/food_controller.dart';
import 'package:japanese/src/controllers/food_controller.dart';
import 'package:get/get.dart';

import '../../controllers/food_controller.dart';
import '../../models/food.dart';
// import '../widget/scale_animation.dart';
import 'package:japanese/src/views/widgets/scale_transition.dart';

final FoodController controller = Get.put(FoodController());

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({Key? key, required this.food}) : super(key: key);

  final Food food;

  PreferredSizeWidget _appBar(BuildContext context){
    return AppBar(
      title:  Text("Food Detail Screen",
        style: TextStyle(
            color: controller.isLightTheme? Colors.black:
            Colors.white
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        )
      ],
    );
  }

  Widget fab( VoidCallback onPressed){
    return FloatingActionButton(
      elevation: 0.0,
      backgroundColor: LightThemeColor.accent,
      child: food.isFavorite
          ? const Icon(AppIcon.heart)
          : const Icon(AppIcon.outlinedHeart),
      //onPressed: () => foodController.isFavoriteFood(food),
      onPressed: onPressed,
    ) ;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _appBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton:
          GetBuilder(builder: (FoodController foodController) {
        return fab(() => foodController.isFavoriteFood(food));
      }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: SizedBox(
          height: height * 0.5,
          child: Container(
            decoration:  BoxDecoration(
                color: controller.isLightTheme? Colors.white : DarkThemeColor.primaryLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RatingBar.builder(
                          itemPadding: EdgeInsets.zero,
                          itemSize: 20,
                          initialRating: food.score,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          glow: false,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => const FaIcon(
                            FontAwesomeIcons.solidStar,
                            color: LightThemeColor.yellow,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                        const SizedBox(width: 15),
                        Text(food.score.toString(),
                            style: Theme.of(context).textTheme.subtitle1),
                        const SizedBox(width: 5),
                        Text("(${food.voter})",
                            style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ).fadeAnimation(0.4),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("\$${food.price}",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                ?.copyWith(color: LightThemeColor.accent)),
                        GetBuilder(
                          builder: (FoodController foodController) {
                            return CounterButton(
                              onIncrementSelected: () =>
                                  foodController.increaseItem(food),
                              onDecrementSelected: () =>
                                  foodController.decreaseItem(food),
                              label: Text(
                                food.quantity.toString(),
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            );
                          },
                        )
                      ],
                    ).fadeAnimation(0.6),
                    const SizedBox(height: 15),
                    Text("Description",
                        style: Theme.of(context).textTheme.headline2).fadeAnimation(0.8),
                    const SizedBox(height: 15),
                    Text(
                      food.description,
                      style: Theme.of(context).textTheme.subtitle1,
                    ).fadeAnimation(0.8),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.1),
                          child: ElevatedButton(
                              onPressed: () => controller.addToCart(food),
                              child: const Text("Add to cart"))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: ScaleAnimation(
        child: Center(
          child: Image.asset(
            food.image,
            scale: 2,
          ),
        ),
      ),
    );
  }
}