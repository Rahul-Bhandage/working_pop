import 'package:flutter/material.dart';
import 'package:pop_lights_app/screens/home_screen.dart';
import 'package:pop_lights_app/screens/sign_in_sign_up/sign_up_screen.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

class SignInScreen extends StatefulWidget {

  static String routeName = "screens/sign_in_screen";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          image: DecorationImage(image: AssetImage("assets/login_sign_up_background.jpg"), fit: BoxFit.cover)
        ),

        child: Stack(

          children: [

            Positioned(

                top: 0.0,
                right: getProportionateWidth(22.0),
                child: Image.asset('assets/img_1.png')
            ),

            Positioned(
              top: getProportionateHeight(37.0),
              left: 0.0,
              child: Image.asset("assets/img_2.png"),
            ),

            Positioned(
              top: getProportionateHeight(135.0),
              right: 0.0,
              child: Image.asset("assets/img_3.png"),
            ),

            Positioned(
              top: getProportionateHeight(292.0),
              left: 0.0,
              child: Image.asset("assets/img_4.png"),
            ),

            Positioned(
              top: getProportionateHeight(309.0),
              right: getProportionateWidth(21.0),
              child: Image.asset("assets/img_5.png"),
            ),

            Positioned(

              top: getProportionateHeight(426.0),
              bottom: 0.0,

              child: Container(

                height: getProportionateHeight(418.0),
                width: getProportionateWidth(390.0),
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(image: AssetImage("assets/login_bottom_card.png"), fit: BoxFit.fill)
                ),

                child: ListView(

                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,

                  children: [

                    Padding(

                      padding: EdgeInsets.only(top: getProportionateHeight(0.0), right: getProportionateWidth(47.0), bottom: getProportionateHeight(13.0), left: getProportionateWidth(47.0)),
                      child: loadSVG("assets/login_text_1.svg"),
                    ),

                    Padding(

                      padding: EdgeInsets.only(right: getProportionateWidth(144.0), left: getProportionateWidth(144.0), bottom: getProportionateHeight(20.0)),
                      child: loadSVG("assets/login_text_2.svg"),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(26.5), right: getProportionateWidth(26.5)),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'EMAIL/USERNAME',
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(26.5), top: getProportionateHeight(25.0), right: getProportionateWidth(26.5), bottom: getProportionateHeight(28.0)),
                      child: TextField(
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',

                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(

                      onTap: () => Navigator.pushReplacementNamed(context, HomeScreen.routeName),

                      child: Container(

                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(image: AssetImage("assets/sign_in_button_background.png"), fit: BoxFit.fill)
                        ),
                        margin: EdgeInsets.fromLTRB(getProportionateWidth(128), getProportionateHeight(0.0), getProportionateWidth(128), getProportionateHeight(11.0)),
                        child: Padding(
                          padding: EdgeInsets.only(top: getProportionateHeight(9.0), bottom: getProportionateHeight(9.0)),
                          child: Center(child: loadSVG("assets/sign_in_text.svg")),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(141.5), right: getProportionateWidth(141.5), bottom: getProportionateHeight(25.0)),
                      child: loadSVG("assets/forgot_password.svg"),
                    ),

                    GestureDetector(

                      onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),

                      child: Container(

                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(image: AssetImage("assets/sign_up_button_background.png"), fit: BoxFit.fill)
                        ),

                        margin: EdgeInsets.fromLTRB(getProportionateWidth(35), getProportionateHeight(0.0), getProportionateWidth(35), getProportionateHeight(38.0)),

                        child: Padding(
                          padding: EdgeInsets.only(top: getProportionateHeight(9.0), bottom: getProportionateHeight(9.0)),
                          child: Center(child: loadSVG("assets/sign_up_text.svg")),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
