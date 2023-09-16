import 'dart:math';

import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import '../modals/group_model.dart';
import '../modals/pop_lights_model.dart';
import '../utilities/app_colors.dart';
import '../utilities/app_utils.dart';
import '../utilities/database_helper.dart';
import '../utilities/size_config.dart';
import 'Msg_Navigator.dart';

class DeleteGroup extends StatefulWidget {
  static String routeName = "screens/delete_group";

  const DeleteGroup({super.key});

  @override
  State<DeleteGroup> createState() => _DeleteGroupState();
}

class _DeleteGroupState extends State<DeleteGroup> {
  Map<bool, PopLightModel> chosenPopLight = {};
  Map<GroupModel, List<PopLightModel>> syncedLightsMap = {};
  List<PopLightModel> addedList = [];

  @override
  Widget build(BuildContext context) {
    final Args = (ModalRoute.of(context)!.settings.arguments ?? <int, List<ScanResult>>{}) as Map;

    String groupId = Args['id'];
    List<ScanResult> discoveredBluetoothDevicesList = Args["disclist"];
    print("POP IN MORE $groupId");
    print("Discovered ...............: $discoveredBluetoothDevicesList");

    return Scaffold(
      backgroundColor: secondaryColor,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: GestureDetector(
      //     onTap: () => Navigator.pop(context),
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
      body: FutureBuilder<List<GroupModel>?>(
          future: DatabaseHelper.getGroup(int.parse(groupId)),
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
                          try {} catch (e) {
                            Navigator.pushReplacementNamed(context, GroupTabView.routeName,
                                    arguments: discoveredBluetoothDevicesList)
                                .then((value) => setState(() {}));
                            Fluttertoast.showToast(
                                msg: "No Element Found",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }

                          return Stack(
                            children: [
                              SvgPicture.asset("assets/delete_grp_vector_line.svg"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: loadSVG("assets/are_you_sure_delete.svg"),
                                  ),
                                  SizedBox(
                                    height: getProportionateHeight(28.0),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateWidth(70),
                                        right: getProportionateWidth(70)),
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
                                              onTap: () async {
                                                DatabaseHelper.getAllGroups().then((value) async {
                                                  print('${groupModel.groupId}');
                                                  if (groupModel.groupId == 3 ||
                                                      groupModel.groupId < 3) {
                                                    groupModel.groupName =
                                                        "GROUP ${groupModel.groupId}";
                                                    print("Name");
                                                    print(
                                                        'Updated group name ${groupModel.groupName}');
                                                    DatabaseHelper.updateGroup(groupModel);
                                                    Fluttertoast.showToast(
                                                        msg: "PopLights Removed From Group ",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor: Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0);

                                                    print("in first 3 grp ");
                                                    print('${remove_poplight(groupModel.groupId)}');
                                                    print("out first 3 grp ");
                                                  }

                                                  if (groupModel.groupId > 3) {
                                                    DatabaseHelper.getAllGroups().then((value) {
                                                      print("Total groups: ${groupId}");

                                                      {
                                                        try {
                                                          DatabaseHelper.deleteGroup(groupModel)
                                                              .then((value) {
                                                            print("First then");
                                                            print('${remove_poplight(groupModel.groupId)}');
                                                            Navigator.pushReplacementNamed(
                                                                    context, GroupTabView.routeName,
                                                                    arguments:
                                                                        discoveredBluetoothDevicesList)
                                                                .then((value) => setState(() {}));

                                                            Fluttertoast.showToast(
                                                                msg: "Successfully Deleted a Group",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.BOTTOM,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.red,
                                                                textColor: Colors.white,
                                                                fontSize: 16.0);
                                                          });
                                                        } catch (e) {
                                                          Navigator.pushReplacementNamed(
                                                                  context, GroupTabView.routeName,
                                                                  arguments:
                                                                      discoveredBluetoothDevicesList)
                                                              .then((value) => setState(() {}));
                                                          Fluttertoast.showToast(
                                                              msg: "No Element Found",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.red,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0);
                                                        }
                                                      }
                                                    });
                                                  }
                                                });

                                                Navigator.pushReplacementNamed(
                                                    context, Messenger.routeName, arguments: {
                                                  "id": 4,
                                                  "disclist": discoveredBluetoothDevicesList
                                                });
                                              },
                                              child: loadSVG("assets/yes_button.svg"),
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
                                                    context, GroupTabView.routeName,
                                                    arguments: discoveredBluetoothDevicesList)
                                                .then((value) => setState(() {})),
                                            child: loadSVG("assets/no_button.svg"),
                                            ),
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                      }
                    });
            }
          }),
    );
  }

  remove_poplight(int groupIndex) {
    DatabaseHelper.getAllPopLights().then((value) {
      for (PopLightModel popLightModel in value!) {
        print(
            "inside remove pop grp groupId: ${popLightModel.groupId},groupIndex is ${groupIndex}");
        if (popLightModel.groupId == groupIndex) {
          popLightModel.groupId = 0;
          DatabaseHelper.updatePopLight(popLightModel);
        }
      }
    });
    // DatabaseHelper.getGroup().then((value) {
    //   for (GroupModel popLightModel in value!) {
    //     print("inside remove pop grp groupId: ${popLightModel.groupName},groupIndex is ${groupIndex}");
    //     if(popLightModel.groupId==groupIndex){
    //       popLightModel.groupId =0;
    //       DatabaseHelper.updateGroup(popLightModel);
    //
    //     }
    //   }
    // });
  }
}
