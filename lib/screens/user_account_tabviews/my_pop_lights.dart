import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pop_lights_app/modals/pop_lights_model.dart';
import 'package:pop_lights_app/modals/poplightColorList.dart';
import 'package:pop_lights_app/screens/share_setting.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/pop_light_more.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

import '../../utilities/app_utils.dart';
import '../home_screen.dart';

class MyPopLights extends StatefulWidget {
  static String routeName = "screens/user_account_tabview/my_pop_lights";

  List<ScanResult> BluetoothDevicesList=[];
  MyPopLights({Key? key, required this.BluetoothDevicesList}) : super(key: key);



  @override
  State<MyPopLights> createState() => _MyPopLightsState();
}

class _MyPopLightsState extends State<MyPopLights> {


  bool btnOnOffToggle = false;
  List<PopLightModel> addedList = [];

  List<String> colorPaths=[];
  // List<String> Img()
  // {
  //   FutureBuilder<List<PopLightColorModel>>(
  //       future: DatabaseHelper.getPopLightColor(),
  //   builder: (context, snapshot) {
  // switch (snapshot.connectionState) {
  // case ConnectionState.none:
  // return Container();
  //
  // case ConnectionState.waiting:
  // return Container();
  //
  // case ConnectionState.active:
  // return Container();
  //
  // case ConnectionState.done:
  // colorList = snapshot.data!;
  // print(colorList);
  // }
  //       return Container();
  //       }
  //       );
  // colorList.map((e){
  //   colorPaths.add(popLightColorModelToJson(e));
  //
  // });
  // return colorPaths;
  // }
  @override
  Widget build(BuildContext context) {

    List<ScanResult> discoveredBluetoothDevicesList=widget.BluetoothDevicesList;
    print("\n\n\n\n\n\n\n\n-----inside my pop lights ----------------");
    print(discoveredBluetoothDevicesList);
    print("\n\n\n\n\n\n\n\n");
    setState(() {

    });
    return FutureBuilder<List<PopLightModel>?>(
        future: DatabaseHelper.getAllPopLights(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();

            case ConnectionState.waiting:
              return Container();

            case ConnectionState.active:
              return Container();

            case ConnectionState.done:
              addedList = snapshot.data!;
              // Img();

              return addedList.isEmpty
                  ? Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: getProportionateHeight(50.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "NO POPLIGHTS YET",
                        style: TextStyle(
                            color: secondaryColor,
                            fontSize: getProportionateHeight(25.0),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: getProportionateWidth(5.0)),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.2), // Shadow color
                              blurRadius: 12.0, // Spread of the shadow
                              offset:
                              Offset(0, 6), // Offset of the shadow
                            ),
                          ],),

                      child:loadSVG(
                        "assets/sad_emogi.svg",
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateHeight(15.0)),
                  GestureDetector(
                    onTap: () {
                      print("Add poplight");
                      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    },
                    child: Container(

                      child: loadSVG("assets/add_pop_light_button.svg"),

          ),),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, HomeScreen.routeName),
                      child:Container(
                        decoration: BoxDecoration(
                        boxShadow: [
                        BoxShadow(
                        color: Colors.black
                            .withOpacity(0.2), // Shadow color
                        blurRadius: 10.0, // Spread of the shadow
                        offset:
                        Offset(3, 3), // Offset of the shadow
                        ),
                        ],),

                      child: loadSVG("assets/add_pop_light.svg"),
                    )),
                  ),
                ],
              )
                  : Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Add poplight");
                      Navigator.pushReplacementNamed(context, ShareSetting.routeName,arguments:  {"id":0,"disclist":discoveredBluetoothDevicesList});

                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: getProportionateHeight(10.0),
                          right: getProportionateWidth(35.0),
                          bottom: getProportionateHeight(15.0)),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: loadSVG("assets/plus.svg"),
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: getProportionateHeight(433.0),
                      width: getProportionateWidth(335.0),
                      child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: getProportionateWidth(15.0),
                          mainAxisSpacing: getProportionateHeight(10.0),
                          childAspectRatio:
                          getProportionateWidth(150.0) / getProportionateHeight(200.0),
                          children: List.generate(



                            addedList.length,
                                (index) => GestureDetector(
                              onTap: () {
                                print("Index: $index");
                                print("color id of pop light ${addedList[index].colorid}, poplight id ${addedList[index].popLightName} ${addedList[index].popLightId} ");
                              },
                              child: DottedBorder(
                                borderPadding: EdgeInsets.zero,
                                padding: EdgeInsets.all(0.5),
                                color: Colors.black,
                                strokeWidth: 2.0,
                                dashPattern: const [3, 2],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20),
                                child: Container(
                                  height: getProportionateHeight(225.0),
                                  width: getProportionateWidth(165.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: secondaryColor,
                                  ),
                                  child: FittedBox(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            // pop light off image
                                            SizedBox(
                                              height: getProportionateHeight(148.0),
                                              width: getProportionateWidth(122.0),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 22, top: 5),
                                                // Set your desired left padding
                                                child: Center(
                                                  child: Image.asset(
                                                      addedList[index].colorid),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              height: getProportionateHeight(10.0),
                                            ),

                                            // Poplight name
                                            Container(
                                              width: getProportionateWidth(120.0),
                                              child: Padding(
                                                padding:
                                                EdgeInsets.only(left: 27),
                                                // Set your desired left padding
                                                child: Center(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    addedList[index]
                                                        .popLightName
                                                        .toUpperCase(),
                                                    softWrap: false,
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: getProportionateHeight(
                                                          14.0),
                                                      fontWeight: FontWeight.w500,

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              height: getProportionateHeight(8.0),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                                context, PopLightMore.routeName,
                                                arguments: {
                                                  "popid": addedList[index].popLightId,
                                                  "disclist": discoveredBluetoothDevicesList
                                                });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: getProportionateHeight(5.0),
                                              right: getProportionateHeight(6.0),

                                            ),
                                            child:  loadSVG("assets/pop_light_more.svg"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ),
                          )),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                      height: getProportionateHeight(50.0),
                      child: loadSVG("assets/vector_136.svg"))
                ],
              );

          }
        });

  }
}