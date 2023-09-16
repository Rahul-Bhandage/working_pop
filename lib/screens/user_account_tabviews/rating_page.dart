import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

class RateThisApp extends StatelessWidget {
  const RateThisApp({super.key});
  static String routeName = "screens/rating_page";

  @override
  Widget build(BuildContext context) {

    return Container(

        width: getProportionateWidth(390.0),
        height: getProportionateHeight(645.0),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius:
          BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
        ),
        //child: const MyPopLights(),

        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: getProportionateHeight(10.0),
              ),
              IconButton(
                onPressed: () {
                  // Add your close button action here
                  Navigator.pop(context); // For example, close the current screen
                },
                padding: EdgeInsets.only(left: 280.0,top: 0.0),
                icon: SvgPicture.asset(
                  'assets/XOUT.svg', // Replace with your image path
                  width: 24.0, // Set the width of the image
                  height: 24.0, // Set the height of the image
                ),
              ),
              SizedBox(
                height: getProportionateHeight(20.0),
              ),
              Text(
                "RATE THIS APP!",
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: getProportionateHeight(35.0),
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: getProportionateHeight(50.0),
              ),
              Container(
                child: SvgPicture.asset(
                  "assets/5star.svg",height: 55,
                ),
              ),
              SizedBox(
                height: getProportionateHeight(50.0),
              ),
              Text(
                "Like what we're doing?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateHeight(20.0),
                  fontWeight: FontWeight.w400,

                ),
              ),

              // Image.asset(
              //   "assets/about_screen_swiggly_line.png",
              //   fit: BoxFit.fill,
              // ),

              SizedBox(
                height: getProportionateHeight(20.0),
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
                child: Container(
                  height: getProportionateHeight(43.0),
                  width: getProportionateWidth(249.0),
                  decoration: BoxDecoration(
                    color:  cream,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 4.0, // Spread of the shadow
                        offset: Offset(0, 4), // Offset of the shadow from the container
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                        "RATE AND REVIEW US!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: getProportionateHeight(20.0),
                          fontWeight:  FontWeight.w600,
                        ),
                      )),
                ),

                ),







              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              Center(

                 child: Text(
                   softWrap: true,
                   maxLines: 2,
                    " Help us recruit for the \n  Poplight Revolution!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateHeight(20.0),
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.56,
                  ),
                )
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
            ],
          ),

        ),
      );

  }
}
