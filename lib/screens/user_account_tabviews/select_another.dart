import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pop_lights_app/screens/home_screen.dart';
import 'package:pop_lights_app/screens/sign_in_sign_up/splash_screen2.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import '../../modals/group_model.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/size_config.dart';

class select_another extends StatefulWidget {

  static String routeName = "screens/user_account_tabviews/select_another";

  const select_another({Key? key}) : super(key: key);

  @override
  State<select_another> createState() => _select_another();
}

class _select_another extends State<select_another> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {

    super.initState();


}

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
return SafeArea(
  child:   Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      toolbarHeight: 200.0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        IconButton(
          onPressed: () {
            // Add your close button action here
            Navigator.pop(context); // For example, close the current screen
          },
          padding: EdgeInsets.only(right: 40.0,top: 0.0),
          icon: SvgPicture.asset(
            'assets/XOUT.svg', // Replace with your image path
            width: 24.0, // Set the width of the image
            height: 24.0, // Set the height of the image
          ),
        ),
      ],
      
    ),
  
  
  
      body:
          Container(
      width: double.infinity, // Fills the width of the parent
      height: double.infinity,
      child:SvgPicture.asset("assets/select_another.svg",fit: BoxFit.fill,),
  ),
      // Container(
      //     decoration: BoxDecoration(
      //       image: DecorationImage(image: AssetImage("assets/"))
      //
      // )
      // ),
      
  
  
  
  ),
);
  }
}
