import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pop_lights_app/screens/home_screen.dart';
import 'package:pop_lights_app/screens/sign_in_sign_up/splash_screen2.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import '../../modals/group_model.dart';
import '../../utilities/size_config.dart';

class SplashScreen extends StatefulWidget {

  static String routeName = "screens/splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  List<String> tabTitlesList = ["Group 1", "Group 2"];

  @override
  void initState() {

    super.initState();

    Timer(const Duration(seconds: 1), () {

      for (int i = 0; i < tabTitlesList.length; i++) {

        if (i == tabTitlesList.length - 1) {

          Navigator.pushReplacementNamed(context, SplashScreen2.routeName);
        }

      }
    });
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return
      Container(


        decoration: const BoxDecoration(

          image: DecorationImage(image: AssetImage("assets/welcome_loading.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
         alignment: Alignment(0.0,0.5),
          child:CircularProgressIndicator(

            color: Colors.red,


          )
        )


      );

  }
}
