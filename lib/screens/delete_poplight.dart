import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/screens/deleted_successfully.dart';
import 'package:pop_lights_app/screens/user_account.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/pop_light_more.dart';
import 'package:drop_shadow/drop_shadow.dart';
import '../modals/pop_lights_model.dart';
import '../utilities/app_colors.dart';
import '../utilities/app_utils.dart';
import '../utilities/database_helper.dart';
import '../utilities/size_config.dart';
import 'Msg_Navigator.dart';

class DeletePopLight extends StatefulWidget {
  static String routeName = "screens/delete_poplight";

  const DeletePopLight({super.key});

  @override
  State<DeletePopLight> createState() => _DeletePopLightState();
}

class _DeletePopLightState extends State<DeletePopLight> {
  @override
  Widget build(BuildContext context) {
    final Args =
        (ModalRoute.of(context)!.settings.arguments ?? <String, List<ScanResult>>{}) as Map;
    String poplightId = Args['popid'];
    List<ScanResult> discoveredBluetoothDevicesList = Args["diclist"];

    print("Inside delete poplight:${poplightId}");
    return Scaffold(
      backgroundColor: secondaryColor,
      body: FutureBuilder<List<PopLightModel>?>(
          future: DatabaseHelper.getPopLight(poplightId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Container();

              case ConnectionState.waiting:
                print("POP is waiting del");
                return Container();

              case ConnectionState.active:
                print("POP is active del");
                return Container();

              case ConnectionState.done:
                print("POP is done del");

                PopLightModel poplightModel = snapshot.data!.first;
                print(poplightModel);

                print(" pop model in del pop    $poplightModel");
                return Stack(

                  children: [
                    Container(
                    decoration: const BoxDecoration(

                      image: DecorationImage(image: AssetImage("assets/N.png"),
                        fit: BoxFit.fill,
                      ),
                    ),),
                    // UNSYNC_BG.svg
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(

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
                            child:loadSVG("assets/unsync_are_sure.svg"),

                            //vdown.svg


                        ),),
                        SizedBox(
                          height: getProportionateHeight(28.0),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getProportionateWidth(70), right: getProportionateWidth(70)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  print("unsynced ${poplightModel.popLightId} ${poplightModel.popLightName}");
                                  await DatabaseHelper.addunsynced(poplightModel);
                                  DatabaseHelper.deletePopLight(poplightModel).then((value) {
                                    print("First then");

                                    DatabaseHelper.getAllPopLights().then((value) {
                                      print("Total groups: ${value!.length}");
                                      Fluttertoast.showToast(
                                          msg: "Pop Light Unsynced Successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    });
                                  });

                                  Navigator.pushReplacementNamed(context, Messenger.routeName,
                                      arguments: {
                                        "id": 2,
                                        "disclist": discoveredBluetoothDevicesList
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
                                  "popid": poplightId,
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
                    ),

            ],
                );
            }
          }),
    );
  }
}
