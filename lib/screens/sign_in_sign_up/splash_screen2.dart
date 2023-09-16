import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pop_lights_app/screens/home_screen.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import '../../modals/group_model.dart';
import '../../utilities/size_config.dart';

class SplashScreen2 extends StatefulWidget {

  static String routeName = "screens/splash_screen2";

  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {

  List<String> tabTitlesList = ["Group 1", "Group 2", "Group 3"];

  @override
  void initState() {

    super.initState();

    Timer(const Duration(seconds: 1), () {

      for (int i = 0; i < tabTitlesList.length; i++) {

        DatabaseHelper.addGroup(GroupModel(groupId: tabTitlesList.indexOf(tabTitlesList[i]) + 1, groupName: tabTitlesList[i], isDeletable: 0)).then((value) {

          if (i == tabTitlesList.length - 1) {

            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return
      Container(


        decoration: const BoxDecoration(

          image: DecorationImage(image: AssetImage("assets/splashscreen.png"),
            fit: BoxFit.fill,
          ),
        ),

      );

  }
}
