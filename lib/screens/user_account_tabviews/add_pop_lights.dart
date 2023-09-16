import 'package:flutter/material.dart';

import '../../utilities/app_colors.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/size_config.dart';
import '../light_syncing.dart';

class AddPopLights extends StatefulWidget {

  const AddPopLights({Key? key}) : super(key: key);

  @override
  State<AddPopLights> createState() => _AddPopLightsState();
}

class _AddPopLightsState extends State<AddPopLights> {

  List popLightNames = ["POPLIGHT_067"];
  bool searching = false;
  bool notFound = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          image: DecorationImage(image: AssetImage("assets/add_pop_light_background.png"), fit: BoxFit.fill),
        ),

        height: getProportionateHeight(578.0),
        width: getProportionateWidth(390.0),

        child: Center(

          child: ListView(

            shrinkWrap: true,
            children: [

              Padding(

                padding: EdgeInsets.only(left: getProportionateWidth(47.5), right: getProportionateWidth(47.5)),
                child: loadSVG("assets/user_turn_on_bluetooth_and_be_within_10_ft_of_pop_light.svg"),
              ),

              Container(

                margin: EdgeInsets.only(top: getProportionateHeight(19.0)),
                child: Stack(

                  alignment: AlignmentDirectional.center,

                  children: [

                    loadSVG("assets/user_ellipse_4.svg"),
                    loadSVG("assets/user_ellipse_3.svg"),
                    loadSVG("assets/user_ellipse_2.svg"),
                    loadSVG("assets/user_ellipse_1.svg"),
                    loadSVG("assets/user_bt_vector.svg"),
                  ],

                ),

              ),

              Padding(

                padding: EdgeInsets.only(left: getProportionateWidth(119.5), top: getProportionateHeight(38.0), right: getProportionateWidth(119.5), bottom: getProportionateHeight(50.0)),
                child: loadSVG("assets/user_searching_for_devices.svg"),
              ),

              SizedBox(

                  height: getProportionateHeight(30.0),
                  width: getProportionateWidth(30.0),
                  child: notFound ? Image.asset('assets/not_found_emoji.png') : (searching == true) ? Image.asset('assets/device_search_icon.png') : Image.asset('assets/user_pop_light_icon.png')
              ),

              Padding(
                padding: EdgeInsets.only(left: getProportionateWidth(69.5), top: getProportionateHeight(23.0), right: getProportionateWidth(69.5)),
                child: notFound ? Container(

                  decoration: const BoxDecoration(

                      image: DecorationImage(image: AssetImage("assets/no_devices_found_box.png"), fit: BoxFit.cover)
                  ),

                  margin: EdgeInsets.only(top: getProportionateHeight(15.0)),

                  child: Padding(
                    padding: EdgeInsets.only(top: getProportionateHeight(5.0), bottom: getProportionateHeight(5.0)),
                    child: const Center(child: Text("NO DEVICES FOUND", style: TextStyle(fontWeight: FontWeight.w700),)),
                  ),

                ) : Column(

                  children: popLightNames.map((popLightName) => Container(

                    decoration: const BoxDecoration(

                        image: DecorationImage(image: AssetImage("assets/user_found_light_background.png"), fit: BoxFit.cover)
                    ),

                    margin: EdgeInsets.only(top: getProportionateHeight(15.0)),

                    child: Padding(
                      padding: EdgeInsets.only(top: getProportionateHeight(5.0), bottom: getProportionateHeight(5.0)),
                      child: Center(child: Text(popLightName, )),
                    ),

                  ),).toList(),

                ),
              ),

              notFound ? Padding(
                padding: EdgeInsets.fromLTRB(getProportionateWidth(77.5), getProportionateHeight(19.0), getProportionateWidth(77.5), getProportionateHeight(0.0)),
                child: loadSVG("assets/alert_message.svg"),

              ) : Container(),

              Padding(
                padding: EdgeInsets.only(left: getProportionateWidth(28.5), right: getProportionateWidth(28.5), bottom: getProportionateHeight(10.0)),
                child: Row(

                  children: [

                    Text("NAME YOUR ${popLightNames[0]}", style: TextStyle(color: highlightColor, fontSize: getProportionateHeight(10.0), fontWeight: FontWeight.w800),),

//                  SizedBox(width: getProportionateWidth(5.0),),

                    Stack(

                      children: [

                        SizedBox(
                          width: getProportionateWidth(192.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColor),),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColor),),
                              labelText: '',
                            ),
                          ),
                        ),

                        Positioned(

                          right: 0.0,
                          bottom: 5.0,

                          child: Container(

                            decoration: const BoxDecoration(

                              image: DecorationImage(image: AssetImage("assets/user_next_btn_background.png")),
                            ),

                            child: Padding(
                              padding: EdgeInsets.fromLTRB(getProportionateWidth(5.0), getProportionateHeight(5.0), getProportionateWidth(5.0), getProportionateHeight(5.0)),
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  loadSVG("assets/user_next_text.svg"),
                                  loadSVG("assets/user_next_arrow.svg"),
                                ],

                              ),
                            ),

                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  loadSVG("assets/user_skip_text.svg"),
                  loadSVG("assets/user_skip_arrow.svg"),
                ],

              ),

              Container(

                width: getProportionateWidth(119.0),
                height: getProportionateHeight(24.0),
                margin: EdgeInsets.only(top: getProportionateHeight(30.0)),

                decoration: const BoxDecoration(

                  image: DecorationImage(image: AssetImage("assets/user_btn_background.png"))

                ),

                child: Center(

                  child: loadSVG("assets/user_set_up_pop_light.svg"),

                ),

              )

            ],

          ),
        ),

      ),

    );
  }
}
