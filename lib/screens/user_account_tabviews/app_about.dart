import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/rating_page.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

class AppAbout extends StatelessWidget {
  const AppAbout({super.key});
  static String routeName = "screens/app_about";
   _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
        isScrollControlled: true,
      builder: (BuildContext context) {
        return RateThisApp();// Remove padding

      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: getProportionateHeight(50.0),
          ),
          Text(
            "WE'RE HERE TO HELP!",
            style: TextStyle(
                color: secondaryColor,
                fontSize: getProportionateHeight(25.0),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: getProportionateHeight(50.0),
          ),
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(
                  msg: "Links inactive",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            child: Text(
              "FAQ PAGE",
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateHeight(20.0),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: getProportionateHeight(50.0),
          ),
          Text(
            "EMAIL US!",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateHeight(20.0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: getProportionateHeight(20.0),
          ),
          Image.asset(
            "assets/about_screen_swiggly_line.png",
            fit: BoxFit.fill,
          ),
          Text(
            "ABOUT",
            style: TextStyle(
                color: secondaryColor,
                fontSize: getProportionateHeight(25.0),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: getProportionateHeight(10.0),
          ),


          GestureDetector(
          onTap: () {

            _openBottomSheet(context);

                },
         child: Text(
            "rate this app",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateHeight(16.0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          ),




          SizedBox(
            height: getProportionateHeight(5.0),
          ),
          Text(
            "Terms & Conditions",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateHeight(16.0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: getProportionateHeight(5.0),
          ),
          Text(
            "Privacy Policy",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateHeight(16.0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: getProportionateHeight(5.0),
          ),
          Text(
            "Software Licenses",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateHeight(16.0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: getProportionateHeight(5.0),
          ),
          Text(
            "Ble radio/address",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateHeight(16.0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: getProportionateHeight(5.0),
          ),
          Text(
            "App Version",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateHeight(16.0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(
            height: getProportionateHeight(5.0),
          ),
          Text(
            "Poplight Firmware Version",
            style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateHeight(16.0),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
        ],
      ),

    );
  }
}
