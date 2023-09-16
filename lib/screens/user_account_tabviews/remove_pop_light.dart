import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/screens/user_account.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/pop_light_more.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import '../../modals/pop_lights_model.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/size_config.dart';
import '../Msg_Navigator.dart';

class RemovePopLight extends StatefulWidget {
  static String routeName = "screens/user_account_tabview/remove_pop_light";

  const RemovePopLight({super.key});

  @override
  State<RemovePopLight> createState() => _RemovePopLight();
}

class _RemovePopLight extends State<RemovePopLight> {
  List<ScanResult> discoveredBluetoothDevicesList = [];

  @override
  Widget build(BuildContext context) {
    final Args =
        (ModalRoute.of(context)!.settings.arguments ?? <String, List<ScanResult>>{}) as Map;
    String popLightId = Args['popid'];
    List<ScanResult> discoveredBluetoothDevicesList = Args["diclist"];
    print("Im inside remove pop $popLightId");

    return Scaffold(
        backgroundColor: cream,
        body: FutureBuilder<List<PopLightModel>?>(
            future: DatabaseHelper.getPopLight(popLightId),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container();

                case ConnectionState.waiting:
                  return Container();

                case ConnectionState.active:
                  return Container();

                case ConnectionState.done:
                  PopLightModel popLightModel = snapshot.data!.first;
                  print(popLightModel);

                  return Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(

                          image: DecorationImage(image: AssetImage("assets/remove_pop.png"),
                            fit: BoxFit.fill,
                          ),
                        ),),
                      // remove_pop.png
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Center(
                          //   child: Image.asset("assets/REMOVE.png"),
                          // ),
                          SizedBox(
                            height: getProportionateHeight(128.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateWidth(70), right: getProportionateWidth(70)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    DatabaseHelper.getAllPopLights().then((value) {
                                      print("Total groups: ${popLightModel.groupId}");

                                      if (popLightModel.groupId > 0) {
                                        popLightModel.groupId = 0;
                                        DatabaseHelper.updatePopLight(popLightModel).then((value) {
                                          print("First then");

                                          Fluttertoast.showToast(
                                              msg: "Poplight Removed Successfully from Group",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                          Navigator.pushReplacementNamed(
                                              context, Messenger.routeName, arguments: {
                                            "id": 1,
                                            "disclist": discoveredBluetoothDevicesList
                                          });

                                          DatabaseHelper.getPopLight(popLightModel.popLightId)
                                              .then((value) {
                                            print("Second then: ${value!.first.popLightName}");
                                            print("Second then");
                                          });
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "PopLights are not  Grouped",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);

                                        Navigator.pushReplacementNamed(context, Messenger.routeName,
                                            arguments: {
                                              "id": 3,
                                              "disclist": discoveredBluetoothDevicesList
                                            });
                                      }
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15), // Shadow color
                                          blurRadius: 8.0, // Spread of the shadow
                                          offset: Offset(0, 0), // Offset of the shadow
                                        ),
                                      ],
                                    ),
                                    child: loadSVG("assets/yes_button.svg"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushReplacementNamed(
                                      context, PopLightMore.routeName, arguments: {
                                    "popid": popLightId,
                                    "disclist": discoveredBluetoothDevicesList
                                  }),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.15), // Shadow color
                                          blurRadius: 8.0, // Spread of the shadow
                                          offset: Offset(0, 0), // Offset of the shadow
                                        ),
                                      ],
                                    ),
                                    child: loadSVG("assets/no_button.svg"),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  );
              }
            }));
  }
}
