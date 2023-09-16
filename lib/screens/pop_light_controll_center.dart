import 'package:flutter/material.dart';
import 'package:pop_lights_app/screens/user_account.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

import '../utilities/app_colors.dart';

class PopLightsControlCenter extends StatefulWidget {

  static String routeName = "screens/pop_lights_control_center";

  const PopLightsControlCenter({Key? key}) : super(key: key);

  @override
  State<PopLightsControlCenter> createState() => _PopLightsControlCenterState();
}

class _PopLightsControlCenterState extends State<PopLightsControlCenter> {

  List<String> lightLocations = ["Hallway Lights", "Master bedroom Lights", "Reading Nook Lights"];
  String selectedLocation = "Hallway Lights";

  bool btnOnOffToggle = false;
  double _currentSliderValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(

            image: DecorationImage(image: AssetImage("assets/login_sign_up_background.jpg"), fit: BoxFit.cover)
        ),

        padding: EdgeInsets.only(top: getProportionateHeight(80.0)),

        child: ListView(

          children: [

            Container(
              margin: EdgeInsets.only(left: getProportionateWidth(50.0), right: getProportionateWidth(50.0)),
              padding: EdgeInsets.only(right: getProportionateWidth(10.0)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 0.80),
              ),
              child: DropdownButton(
                borderRadius:BorderRadius.circular(12),
                dropdownColor: highlightColor,
                underline:const SizedBox.shrink(),
                isExpanded: true,
                value: selectedLocation,
                style: TextStyle(color: primaryColor, fontSize: getProportionateHeight(getProportionateHeight(20.0))),
                items: List.generate(lightLocations.length, (index) {

                  return DropdownMenuItem<String>(
                    value: lightLocations[index],
                    child: Center(child: Text(lightLocations[index], style: TextStyle(fontSize: getProportionateHeight(12.0), fontWeight: FontWeight.w600),)),
                  );

                }),
                onChanged: (value) {

                  setState(() => selectedLocation = value!);
                },
              ),
            ),

            Stack(

              alignment: Alignment.center,
              children: [

                btnOnOffToggle ? Image.asset("assets/pop_light_on.png", height: getProportionateHeight(349.0), width: getProportionateWidth(234.0),) : Image.asset("assets/pop_light_off.png", height: getProportionateHeight(349.0), width: getProportionateWidth(234.0)),

                Positioned(
                  right: getProportionateWidth(40.0),
                  child: GestureDetector(

                    onTap: () {

                      setState(() {

                        if (btnOnOffToggle) {

                          btnOnOffToggle = false;
                        } else {
                          btnOnOffToggle = true;
                        }

//                        !btnOnOffToggle;
                        print("toggle $btnOnOffToggle");

                      });

                    },

                    child: Container(

                      height: getProportionateHeight(66.0),
                      width: getProportionateWidth(36.0),

                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/on_off_btn_background.png"))

                      ),
                      alignment: (btnOnOffToggle == false) ? Alignment.bottomCenter : Alignment.topCenter,
                      child: Container(

                        height: getProportionateHeight(28.0),
                        width: getProportionateWidth(28.0),

                        decoration: BoxDecoration(

                            image: DecorationImage(image: (btnOnOffToggle == false) ? const AssetImage("assets/off_btn_background.png") : const AssetImage("assets/on_btn_background.png"))

                        ),

                        child: Center(

                          child: (btnOnOffToggle == false) ? loadSVG("assets/off_text.svg") : loadSVG("assets/on_text.svg"),
                        ),

                      ),

                    ),
                  ),
                )

              ],

            ),

            Container(

              height: getProportionateHeight(314.0),
              width: getProportionateWidth(390.0),
              alignment: Alignment.bottomCenter,
              decoration: const BoxDecoration(

                  image: DecorationImage(image: AssetImage("assets/controls_background.png"), fit: BoxFit.fill)

              ),

              child: Stack(

                alignment: Alignment.topCenter,
                children: [

                  Positioned(

                    left: getProportionateWidth(54.0),
                    top: getProportionateHeight(78.0),
                    child: Image.asset("assets/modes_control.png"),
                  ),

                  Positioned(
                    top: getProportionateHeight(21.0),

                    child: Image.asset("assets/brightness_controller.png")
                  ),

                  Positioned(
                    right: getProportionateWidth(54.0),
                    top: getProportionateHeight(78.0),
                    child: Image.asset("assets/timer.png")
                  ),

                  Positioned(

                    top: getProportionateHeight(150.0),
/*                    left: getProportionateWidth(72.5),
                    right: getProportionateWidth(72.5),*/

                    child: SizedBox(
                      width: getProportionateWidth(245.0),
                      child: Slider(
                        value: _currentSliderValue,
                        max: 100,
                        divisions: 10,
                        label: _currentSliderValue.round().toString(),
                        activeColor: highlightColor,
                        inactiveColor: secondaryColor,
                        onChanged: (double value) {
                          setState(() {
                            _currentSliderValue = value;
                          });
                        },
                      ),
                    ),
                  ),
                  
                  Positioned(

                    top: getProportionateHeight(194.0),
                    left: getProportionateWidth(72.5),
                    right: getProportionateWidth(72.5),

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        loadSVG("assets/brightness_text.svg"),

                        Text("$_currentSliderValue%", style: const TextStyle(color: highlightColor, fontWeight: FontWeight.w600),)
                      ],

                    ),
                  ),

                  Positioned(

                    left: getProportionateWidth(15.0),
                    right: getProportionateWidth(15.0),
                    bottom: getProportionateHeight(15.0),

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        GestureDetector(

                          child: loadSVG("assets/account_text.svg"),
                          onTap: () => Navigator.pushNamed(context, UserAccount.routeName),

                        ),

                        GestureDetector(

                          child: loadSVG("assets/settings_text.svg"),
                          onTap: () => print("Settings"),

                        )

                      ],

                    ),
                  )
                  
                ],
                
              ),

            ),

          ],

        ),

      ),
    );
  }

}
