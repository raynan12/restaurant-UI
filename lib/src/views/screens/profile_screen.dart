import 'package:flutter/material.dart';
import 'package:japanese/core/app_asset.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Image.asset(AppAsset.profileImage, width: 300,)),
          Text(
            'Hello Sina!',
            style: Theme.of(context).textTheme.headline1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAsset.githubImage,
                width: 60,
              ),
              SizedBox(width: 10,),
              Text(
                'https://github.com/raynan12?tab=repositories',
                style: Theme.of(context).textTheme.headline3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}