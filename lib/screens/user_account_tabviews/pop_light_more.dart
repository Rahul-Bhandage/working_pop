import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/modals/poplightColorList.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/remove_pop_light.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/rename_pop_light.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import 'package:pop_lights_app/screens/delete_poplight.dart';
import '../../modals/pop_lights_model.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/size_config.dart';
import '../user_account.dart';

class PopLightMore extends StatefulWidget {
  static String routeName = "screens/user_account_tabview/pop_light_more";

  //
  const PopLightMore({super.key});

  @override
  State<PopLightMore> createState() => _PopLightMoreState();
}

Widget _buildImageWithShadow(String imagePath) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // Shadow color
          blurRadius: 10.0, // Spread of the shadow
          offset: Offset(0, 10), // Offset of the shadow
        ),
      ],
    ),
    child: Image.asset(imagePath),
  );
}

class _PopLightMoreState extends State<PopLightMore> {
  String popLightId = "";

  @override
  Widget build(BuildContext context) {
    final Args =
        (ModalRoute.of(context)!.settings.arguments ?? <String, List<ScanResult>>{}) as Map;
    popLightId = Args['popid'];
    List<ScanResult> discoveredBluetoothDevicesList = Args["disclist"];
    print("POP IN MORE $popLightId");
    print("Discovered ...............: $discoveredBluetoothDevicesList");
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, UserAccount.routeName,
              arguments: {"popid": 3, "disclist": discoveredBluetoothDevicesList});
          return true;
        },
        child: Scaffold(
            // extendBodyBehindAppBar: true,
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, UserAccount.routeName,
                    arguments: {"popid": 0, "disclist": discoveredBluetoothDevicesList}),
                child: Container(
                    height: getProportionateHeight(21.0),
                    width: getProportionateWidth(21.0),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/back_eclipse.png"), fit: BoxFit.none)),
                    child: Center(
                      child: loadSVG("assets/back_arrow.svg"),
                    )),
              ),
              title: Text(
                "MAKE A SELECTION",
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: getProportionateHeight(20.0),
                    fontWeight: FontWeight.w900),
              ),
              centerTitle: true,
            ),
            body: Stack(
              children: [
                Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/background_arrow.png"),
                        fit: BoxFit.cover,


                      // Adjust the fit as needed
                      ),
                    ),
                        child: Container(
                          height: 600,


                          child: ListView(
                            children: [

                              GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(context, RenamePopLight.routeName,
                                    arguments: {
                                      "popid": "PopLight\t$popLightId",
                                      "diclist": discoveredBluetoothDevicesList
                                    }),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateWidth(67.0),
                                      top: getProportionateHeight(45.0),
                                      right: getProportionateWidth(67.0)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2), // Shadow color
                                          blurRadius: 5.0, // Spread of the shadow
                                          offset: Offset(0, 1), // Offset of the shadow
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(20.0), // Set your desired border radius
                                    ),
                                    child: loadSVG("assets/rename_pop_light_button.svg"),
                                  ),
                                ),
                              ),

                              //REMOVE FROM GROUP
                              GestureDetector(
                                onTap: () {
                                  print("Removing PopLight started. with id: $popLightId");

                                  Navigator.pushReplacementNamed(context, RemovePopLight.routeName,
                                      arguments: {
                                        "popid": popLightId,
                                        "diclist": discoveredBluetoothDevicesList
                                      });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateWidth(67.0),
                                      top: getProportionateHeight(12.0),
                                      right: getProportionateWidth(67.0)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2), // Shadow color
                                          blurRadius: 5.0, // Spread of the shadow
                                          offset: Offset(0, 1), // Offset of the shadow
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(20.0), // Set your desired border radius
                                    ),
                                    child: loadSVG("assets/remove_from_group_button.svg"),
                                  ),
                                ),
                              ),

                              //UNSYNC THE POPLIGHT
                              GestureDetector(
                                onTap: () async {
                                  print("DeletePopLight");

                                  Navigator.pushReplacementNamed(context, DeletePopLight.routeName,
                                      arguments: {
                                        "popid": popLightId,
                                        "diclist": discoveredBluetoothDevicesList
                                      });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateWidth(67.0),
                                      top: getProportionateHeight(12.0),
                                      right: getProportionateWidth(67.0)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2), // Shadow color
                                          blurRadius: 5.0, // Spread of the shadow
                                          offset: Offset(0, 1), // Offset of the shadow
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(20.0), // Set your desired border radius
                                    ),
                                    child: loadSVG("assets/unsync_pop_light.svg"),
                                  ),
                                ),
                              ),
                              FutureBuilder<List<PopLightModel>?>(
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
                                      print("IN POP Color More");
                                      print(snapshot.data!);
                                      List<PopLightModel> colorModel = snapshot.data!;
                                      print(" after(colorModel);");
                                      List<PopLightModel> PopLightListForColors = [];
                                      snapshot.data?.map((e) {
                                        PopLightListForColors.add(e);
                                      });

                                      return SizedBox(
                                          height: getProportionateHeight(380.0),
                                          child: GridView.count(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: getProportionateWidth(10.0),
                                            mainAxisSpacing: getProportionateHeight(10.0),
                                            childAspectRatio: getProportionateWidth(123.0) /
                                                getProportionateHeight(120.0),
                                            padding: EdgeInsets.only(
                                              left: getProportionateWidth(67.0),
                                              top: getProportionateHeight(0.0),
                                              right: getProportionateWidth(67.0),
                                            ),
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    try {
                                                      for (PopLightModel model in colorModel) {
                                                        if (model.popLightId == popLightId) {
                                                          model.colorid = 'assets/SageGreenLight.png';
                                                          DatabaseHelper.updatePopLight(model);
                                                        }
                                                      }
                                                    } catch (e) {
                                                      print(e.toString());
                                                    }
                                                    Fluttertoast.showToast(
                                                        msg: "Color  Update Successfull",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);
                                                    Navigator.pushReplacementNamed(
                                                        context, UserAccount.routeName, arguments: {
                                                      "popid": 3,
                                                      "disclist": discoveredBluetoothDevicesList
                                                    });
                                                  },
                                                  child: _buildImageWithShadow(
                                                      'assets/sage_green_pop_light.png')),
                                              GestureDetector(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Color  Update Successfull",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);

                                                  try {
                                                    for (PopLightModel model in colorModel) {
                                                      if (model.popLightId == popLightId) {
                                                        model.colorid = 'assets/VermillionRedLight.png';
                                                        DatabaseHelper.updatePopLight(model);
                                                      }
                                                    }
                                                  } catch (e) {
                                                    print(e.toString());
                                                  }
                                                  Navigator.pushReplacementNamed(
                                                      context, UserAccount.routeName, arguments: {
                                                    "popid": 3,
                                                    "disclist": discoveredBluetoothDevicesList
                                                  });
                                                },
                                                child: _buildImageWithShadow('assets/red_pop_light.png'),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Color  Update Successfull",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                  try {
                                                    for (PopLightModel model in colorModel) {
                                                      if (model.popLightId == popLightId) {
                                                        model.colorid = 'assets/MarigoldLight.png';
                                                        DatabaseHelper.updatePopLight(model);
                                                      }
                                                    }
                                                  } catch (e) {
                                                    print(e.toString());
                                                  }
                                                  Navigator.pushReplacementNamed(
                                                      context, UserAccount.routeName, arguments: {
                                                    "popid": 3,
                                                    "disclist": discoveredBluetoothDevicesList
                                                  });
                                                },
                                                child:
                                                    _buildImageWithShadow('assets/yellow_pop_light.png'),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Color is Update Successfull",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);

                                                  try {
                                                    for (PopLightModel model in colorModel) {
                                                      if (model.popLightId == popLightId) {
                                                        model.colorid = 'assets/DustyRoseLight.png';
                                                        DatabaseHelper.updatePopLight(model);
                                                      }
                                                    }
                                                  } catch (e) {
                                                    print(e.toString());
                                                  }
                                                  Navigator.pushReplacementNamed(
                                                      context, UserAccount.routeName, arguments: {
                                                    "popid": 3,
                                                    "disclist": discoveredBluetoothDevicesList
                                                  });
                                                },
                                                child: _buildImageWithShadow('assets/pink_pop_light.png'),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Color Update Successfull",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);

                                                  try {
                                                    for (PopLightModel model in colorModel) {
                                                      if (model.popLightId == popLightId) {
                                                        model.colorid = 'assets/MatteBlackLight.png';
                                                        DatabaseHelper.updatePopLight(model);
                                                      }
                                                    }
                                                  } catch (e) {
                                                    print(e.toString());
                                                  }
                                                  Navigator.pushReplacementNamed(
                                                      context, UserAccount.routeName, arguments: {
                                                    "popid": 3,
                                                    "disclist": discoveredBluetoothDevicesList
                                                  });
                                                },
                                                child:
                                                    _buildImageWithShadow('assets/black_pop_light.png'),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Fluttertoast.showToast(
                                                      msg: "Color is Update Successfull",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor: Colors.red,
                                                      textColor: Colors.white,
                                                      fontSize: 16.0);
                                                  try {
                                                    for (PopLightModel model in colorModel) {
                                                      if (model.popLightId == popLightId) {
                                                        model.colorid = 'assets/WhiteLight.png';
                                                        DatabaseHelper.updatePopLight(model);
                                                      }
                                                    }
                                                  } catch (e) {
                                                    print(e.toString());
                                                  }
                                                  Navigator.pushReplacementNamed(
                                                      context, UserAccount.routeName, arguments: {
                                                    "popid": 3,
                                                    "disclist": discoveredBluetoothDevicesList
                                                  });
                                                },
                                                child:
                                                    _buildImageWithShadow('assets/white_pop_light.png'),
                                              )
                                            ],
                                          ));
                                  }
                                },
                              ),
                              SizedBox(
                                height:MediaQuery.of(context).size.height*0.055,
                              ),
                            ],
                          ),
                        )
                  ),
              ],
            ),
            ));
  }
}
