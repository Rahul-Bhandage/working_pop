import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/modals/group_model.dart';
import 'package:pop_lights_app/screens/Msg_Navigator.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/pop_light_more.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/rename_successful.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import '../../modals/pop_lights_model.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/size_config.dart';
import 'package:pop_lights_app/screens/user_account.dart';

class RenamePopLight extends StatefulWidget {
  static String routeName = "screens/user_account_tabview/rename_pop_light";

  const RenamePopLight({super.key});

  @override
  State<RenamePopLight> createState() => _RenamePopLightState();
}

class _RenamePopLightState extends State<RenamePopLight> {
  final renameController = TextEditingController();
  bool isPopLight = false;
  late String typeId;
  late String text_value;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    renameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Args =
        (ModalRoute.of(context)!.settings.arguments ?? <String, List<ScanResult>>{}) as Map;
    String? idGroupPopLight = Args['popid'];
    List<ScanResult> discoveredBluetoothDevicesList = Args["diclist"];

    // String? idGroupPopLight = ModalRoute.of(context)!.settings.arguments as String;

    print("idGroupPopLight: $idGroupPopLight");

    typeId = idGroupPopLight!.split("\t")[1];
    if (idGroupPopLight?.split("\t")[0] == "Group") {
      isPopLight = false;
    } else {
      isPopLight = true;
    }
    print("$typeId type id .................");
    return Scaffold(
        backgroundColor: cream,
        // appBar: AppBar(
        //   backgroundColor: cream,
        //   elevation: 0,
        //   leading: GestureDetector(
        //     onTap: () {
        //       Navigator.pushNamed(context, PopLightMore.routeName);
        //     },
        //     child: Container(
        //         height: getProportionateHeight(21.0),
        //         width: getProportionateWidth(21.0),
        //         decoration: const BoxDecoration(
        //             image: DecorationImage(
        //                 image: AssetImage("assets/back_eclipse.png"), fit: BoxFit.none)),
        //         child: Center(
        //           child: loadSVG("assets/back_arrow.svg"),
        //         )),
        //   ),
        // ),
        body: isPopLight
            ? FutureBuilder<List<PopLightModel>?>(
                future: DatabaseHelper.getPopLight(typeId),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container();

                    case ConnectionState.waiting:
                      return Container();

                    case ConnectionState.active:
                      return Container();

                    case ConnectionState.done:
                      print("\n\n\n\nPOP rename connection done ");
                      PopLightModel popLightModel = snapshot.data!.first;
                      print("\n\n\n\nPOP pop model snapshot ");
                      return Stack(
                        children: [
                          loadSVG("assets/rename_pop_light_squiggle_line.svg"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  width: getProportionateWidth(295.0),
                                  height: getProportionateHeight(95.0),

                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Shadow color
                                          blurRadius: 10.0, // Spread of the shadow
                                          offset:
                                          Offset(0, 4), // Offset of the shadow
                                        ),
                                      ],
                                      color: primaryColor,
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      border: Border.all(color: Colors.black)),
                                  child: Center(
                                    child: TextField(
                                        // maxLength: 25,
                                        // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                        // inputFormatters: [
                                        //   FilteringTextInputFormatter.deny(
                                        //       RegExp(r'^\s')), // Disallow empty input
                                        //   FilteringTextInputFormatter.allow(RegExp(
                                        //       r'[a-zA-Z0-9 ]')), // Allow only letters and numbers
                                        // ],
                                        textAlign: TextAlign.center,
                                        controller: renameController,
                                        onChanged: (value) {
                                          text_value = value;
                                          renameController.value = TextEditingValue(
                                              text: value.toUpperCase(),
                                              selection: renameController.selection);
                                        },
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18.0,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                          hintText: 'TYPE HERE',
                                          counterText: "",
                                          hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ),

                                ),
                              ),
                              SizedBox(
                                height: getProportionateHeight(28.0),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateWidth(60),
                                    right: getProportionateWidth(60)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.2), // Shadow color
                                              blurRadius: 10.0, // Spread of the shadow
                                              offset:
                                              Offset(0, 4), // Offset of the shadow
                                            ),
                                          ]
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (text_value.isNotEmpty) {
                                            popLightModel.popLightName = renameController.text;

                                            DatabaseHelper.updateunsynced(popLightModel);
                                            DatabaseHelper.updatePopLight(popLightModel)
                                                .then((value) {
                                              print("First then");

                                              DatabaseHelper.getPopLight(popLightModel.popLightId)
                                                  .then((value) {
                                                print("Second then: ${value!.first.popLightName}");
                                                print("\n\n\n\n\n\nsendiiing to messenger.......");

                                                Navigator.pushReplacementNamed(
                                                    context, Messenger.routeName, arguments: {
                                                  "id": 0,
                                                  "disclist": discoveredBluetoothDevicesList
                                                });
                                              });
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Invalid input, Try again",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        },
                                        child:  Container(
                  decoration: BoxDecoration(
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Shadow color
                  blurRadius: 10.0, // Spread of the shadow
                  offset:
                  Offset(0, 4), // Offset of the shadow
                  ),
                  ]
                  ),
                  child:loadSVG("assets/rename_pop_light_save.svg"),),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.2), // Shadow color
                                              blurRadius: 10.0, // Spread of the shadow
                                              offset:
                                              Offset(0, 4), // Offset of the shadow
                                            ),
                                          ]
                                      ),
                                      child: GestureDetector(
                                        onTap: () => Navigator.pushReplacementNamed(
                                            context, PopLightMore.routeName, arguments: {
                                          "popid": typeId,
                                          "disclist": discoveredBluetoothDevicesList
                                        }),
                                        child: Container(
                  decoration: BoxDecoration(
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Shadow color
                  blurRadius: 10.0, // Spread of the shadow
                  offset:
                  Offset(0, 4), // Offset of the shadow
                  ),
                  ]
                  ),
                  child: loadSVG("assets/rename_pop_light_back.svg"),),
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
                })
            : FutureBuilder<List<GroupModel>?>(
                future: DatabaseHelper.getGroup(int.parse(typeId)),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container();

                    case ConnectionState.waiting:
                      return Container();

                    case ConnectionState.active:
                      return Container();

                    case ConnectionState.done:
                      GroupModel groupModel = snapshot.data!.first;

                      return Stack(
                        children: [
                          loadSVG("assets/rename_pop_light_squiggle_line.svg"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  width: getProportionateWidth(290.0),
                                  height: getProportionateHeight(95.0),
                                  decoration: BoxDecoration(

                  boxShadow: [
                  BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Shadow color
                  blurRadius: 10.0, // Spread of the shadow
                  offset:
                  Offset(0, 4), // Offset of the shadow
                  ),
                  ],
                                      color: primaryColor,
                                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                                      border: Border.all(color: Colors.black)),
                                  child: Center(
                                    child: TextField(
                                      // maxLength: 15,
                                      // maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.deny(
                                      //       RegExp(r'^\s')), // Disallow empty input
                                      //   FilteringTextInputFormatter.allow(RegExp(
                                      //       r'[a-zA-Z0-9 ]')), // Allow only letters and numbers
                                      // ],
                                      textAlign: TextAlign.center,
                                      controller: renameController,
                                      onChanged: (value) {
                                        text_value = value;
                                        renameController.value = TextEditingValue(
                                            text: value.toUpperCase(),
                                            selection: renameController.selection);
                                      },
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18.0,
                                      ),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                        hintText: 'TYPE HERE',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateHeight(28.0),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: getProportionateWidth(60),
                                    right: getProportionateWidth(60)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (text_value.isNotEmpty) {
                                          groupModel.groupName = renameController.text;

                                          DatabaseHelper.updateGroup(groupModel).then((value) {
                                            print("First then");

                                            DatabaseHelper.getGroup(groupModel.groupId)
                                                .then((value) {
                                              print("Second then: ${value!.first.groupName}");
                                              FocusManager.instance.primaryFocus?.unfocus();
                                            });
                                          });
                                          Navigator.pushReplacementNamed(
                                              context, GroupTabView.routeName,
                                              arguments: discoveredBluetoothDevicesList);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Invalid input, Try again",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: Container(
                  decoration: BoxDecoration(
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Shadow color
                  blurRadius: 10.0, // Spread of the shadow
                  offset:
                  Offset(0, 4), // Offset of the shadow
                  ),
                  ]
                  ),
                  child: loadSVG("assets/rename_pop_light_save.svg"),),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.pushReplacementNamed(
                                          context, GroupTabView.routeName,
                                          arguments: discoveredBluetoothDevicesList),
                                      child: Container(
                  decoration: BoxDecoration(
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black
                      .withOpacity(0.2), // Shadow color
                  blurRadius: 10.0, // Spread of the shadow
                  offset:
                  Offset(0, 4), // Offset of the shadow
                  ),
                  ]
                  ),
                  child: loadSVG("assets/rename_pop_light_back.svg"),),
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
