import 'package:flutter/material.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

import '../../utilities/app_utils.dart';

class SignUpScreen extends StatefulWidget {

  static String routeName = "screens/sign_up_screen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.deepOrange,)
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

      body: Container(

        decoration: const BoxDecoration(

            image: DecorationImage(image: AssetImage("assets/login_sign_up_background.jpg"), fit: BoxFit.fill)
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
              child: Image.asset("assets/img_sign_up_2.png"),
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

                height: getProportionateHeight(478.0),
                width: getProportionateWidth(390.0),
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(image: AssetImage("assets/sign_up_bottom_card.png"), fit: BoxFit.fill)
                ),

                child: ListView(

                  children: [

                    Padding(

                      padding: EdgeInsets.only(top: getProportionateHeight(0.0), right: getProportionateWidth(47.5), bottom: getProportionateHeight(13.0), left: getProportionateWidth(47.5)),
                      child: loadSVG("assets/create_an_account_text.svg"),
                    ),

                    Padding(

                      padding: EdgeInsets.only(right: getProportionateWidth(150.0), left: getProportionateWidth(150.0), bottom: getProportionateHeight(10.0)),
                      child: loadSVG("assets/lets_get_lit.svg"),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(26.5), right: getProportionateWidth(26.5)),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'NAME',
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(26.5), top: getProportionateHeight(20.0), right: getProportionateWidth(26.5), bottom: getProportionateHeight(28.0)),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                        ),
                      ),
                    ),

                    Container(

                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(image: AssetImage("assets/google_login_button_background.png"), fit: BoxFit.fill)
                      ),

                      margin: EdgeInsets.only(left: getProportionateWidth(30.5), right: getProportionateWidth(30.5)),

                      child: Padding(

                        padding: EdgeInsets.only(top: getProportionateHeight(10.0), bottom: getProportionateHeight(10.0)),

                        child: Center(

                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              Image.asset('assets/g_logo.png'),

                              SizedBox(width: getProportionateWidth(5.0),),

                              loadSVG("assets/continue_with_google.svg"),

                            ],

                          ),

                        ),
                      ),

                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(26.5), top: getProportionateHeight(20.0), right: getProportionateWidth(26.5), bottom: getProportionateHeight(28.0)),
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

                      onTap: () => Navigator.pushReplacementNamed(context, SignUpScreen.routeName),

                      child: Container(

                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(image: AssetImage("assets/connect_pop_light_background.png"), fit: BoxFit.fill)
                        ),
                        margin: EdgeInsets.fromLTRB(getProportionateWidth(128), getProportionateHeight(0.0), getProportionateWidth(128), getProportionateHeight(11.0)),
                        child: Padding(
                          padding: EdgeInsets.only(top: getProportionateHeight(9.0), bottom: getProportionateHeight(9.0)),
                          child: Center(child: loadSVG("assets/connect_pop_light.svg")),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        )


        /*Column(

          children: [

            const Spacer(),

            Expanded(
              child: Container(

                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(image: AssetImage("assets/sign_up_bottom_card.png"), fit: BoxFit.fill)
                ),

                child: ListView(

                  children: [

                    Padding(

                      padding: EdgeInsets.only(top: getProportionateHeight(0.0), right: getProportionateWidth(47.5), bottom: getProportionateHeight(13.0), left: getProportionateWidth(47.5)),
                      child: loadSVG("assets/create_an_account_text.svg"),
                    ),

                    Padding(

                      padding: EdgeInsets.only(right: getProportionateWidth(150.0), left: getProportionateWidth(150.0), bottom: getProportionateHeight(10.0)),
                      child: loadSVG("assets/lets_get_lit.svg"),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(26.5), right: getProportionateWidth(26.5)),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'NAME',
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(26.5), top: getProportionateHeight(20.0), right: getProportionateWidth(26.5), bottom: getProportionateHeight(28.0)),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                        ),
                      ),
                    ),

                    Container(

                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(image: AssetImage("assets/google_login_button_background.png"), fit: BoxFit.fill)
                      ),

                      margin: EdgeInsets.only(left: getProportionateWidth(30.5), right: getProportionateWidth(30.5)),

                      child: Padding(

                        padding: EdgeInsets.only(top: getProportionateHeight(10.0), bottom: getProportionateHeight(10.0)),

                        child: Center(

                          child: Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              Image.asset('assets/g_logo.png'),

                              SizedBox(width: getProportionateWidth(5.0),),

                              loadSVG("assets/continue_with_google.svg"),

                            ],

                          ),

                        ),
                      ),

                    ),

                    Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(26.5), top: getProportionateHeight(20.0), right: getProportionateWidth(26.5), bottom: getProportionateHeight(28.0)),
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

                      onTap: () => Navigator.pushReplacementNamed(context, SignUpScreen.routeName),

                      child: Container(

                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(image: AssetImage("assets/connect_pop_light_background.png"), fit: BoxFit.fill)
                        ),
                        margin: EdgeInsets.fromLTRB(getProportionateWidth(128), getProportionateHeight(0.0), getProportionateWidth(128), getProportionateHeight(11.0)),
                        child: Padding(
                          padding: EdgeInsets.only(top: getProportionateHeight(9.0), bottom: getProportionateHeight(9.0)),
                          child: Center(child: loadSVG("assets/connect_pop_light.svg")),
                        ),
                      ),
                    ),

                  ],
                ),

              ),
            )

          ],

        ),*/
      ),

    );
  }
}
