import 'package:flutter/material.dart';

import '../../utilities/app_utils.dart';
import '../../utilities/size_config.dart';

class ShareSettings extends StatefulWidget {
  const ShareSettings({Key? key}) : super(key: key);

  @override
  State<ShareSettings> createState() => _ShareSettingsState();
}

class _ShareSettingsState extends State<ShareSettings> {

  List<String> popLightBackground = ["assets/user_pop_light_selected_background.png", "assets/user_pop_light_selected_background.png", "assets/user_pop_light_unselected_background.png", "assets/user_pop_light_unselected_background.png"];
  List<String> popLightsList = ["assets/right_bedroom_light.svg", "assets/left_bedroom_light.svg", "assets/hallway_light.svg", "assets/reading_nook_light.svg"];
  bool btnOnOffToggle = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(

        decoration: const BoxDecoration(

          image: DecorationImage(image: AssetImage("assets/add_pop_light_background.png"), fit: BoxFit.fill),

        ),

        width: getProportionateWidth(390.0),
        height: getProportionateHeight(578.0),

        child: ListView(

          children: [

            SizedBox(

              width: getProportionateWidth(300.0),
              child: Center(
                child: loadSVG("assets/user_select_the_lights_you_want_to_share.svg"),
              ),

            ),
            
            Container(

                width: getProportionateWidth(71.0),
                height: getProportionateHeight(16.0),
                margin: EdgeInsets.only(top: getProportionateHeight(20.0), bottom: getProportionateHeight(10.0)),

                decoration: const BoxDecoration(

                    image: DecorationImage(image: AssetImage("assets/group_background.png"))

                ),

                child: Center(

                  child: loadSVG("assets/group_1_text.svg"),
                )

            ),

            Padding(
              padding: EdgeInsets.only(left: getProportionateWidth(30.0), right: getProportionateWidth(30.0), bottom: getProportionateHeight(20.0)),
              child: GridView.count(

                crossAxisCount: 2,
                crossAxisSpacing: getProportionateWidth(14.0),
                mainAxisSpacing: getProportionateHeight(23.0),
                childAspectRatio: 1.5/2.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(popLightBackground.length, (index) {

                  return Container(

                    decoration: BoxDecoration(

                        image: DecorationImage(image: AssetImage(popLightBackground[index]), fit: BoxFit.fill)
                    ),

                    height: getProportionateHeight(181.0),
                    width: getProportionateWidth(137.0),

                    child: Center(
                      child: Column(

                        children: [

                          SizedBox(

                            height: getProportionateHeight(145.0),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                const Image(image: AssetImage("assets/pop_light.png")),

                                GestureDetector(

                                  onTap: () {

                                    setState(() {

                                      if (btnOnOffToggle) {

                                        btnOnOffToggle = false;
                                      } else {
                                        btnOnOffToggle = true;
                                      }
                                    });

                                  },

                                  child: Container(

                                    height: getProportionateHeight(34.0),
                                    width: getProportionateWidth(18.0),

                                    decoration: const BoxDecoration(
                                        image: DecorationImage(image: AssetImage("assets/user_toggle_background.png"))

                                    ),
                                    alignment: (btnOnOffToggle == false) ? Alignment.bottomCenter : Alignment.topCenter,
                                    child: Container(

                                      height: getProportionateHeight(14.0),
                                      width: getProportionateWidth(14.0),

                                      decoration: BoxDecoration(

                                          image: DecorationImage(image: (btnOnOffToggle == false) ? const AssetImage("assets/user_off_background.png") : const AssetImage("assets/user_on_background.png"))

                                      ),

                                      child: Center(

                                        child: (btnOnOffToggle == false) ? loadSVG("assets/user_off_text.svg") : loadSVG("assets/user_on_text.svg"),
                                      ),

                                    ),

                                  ),
                                )

                              ],

                            ),
                          ),

                          SizedBox(

                            height: getProportionateHeight(29.0),
                            child: loadSVG(popLightsList[index]),
                          )

                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            Container(

              decoration: const BoxDecoration(

                  image: DecorationImage(image: AssetImage("assets/user_btn_background.png"))

              ),

              width: getProportionateWidth(119.0),
              height: getProportionateHeight(24.0),

              margin: EdgeInsets.only(bottom: getProportionateHeight(50.0)),

              child: Center(child: Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  loadSVG("assets/user_btn_share_text.svg"),

                  SizedBox(width: getProportionateWidth(5.0),),

                  loadSVG("assets/user_btn_arrow.svg"),

                ],

              )),

            ),

          ],

        ),

      ),
    );
  }
}
