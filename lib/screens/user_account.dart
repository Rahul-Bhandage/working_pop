
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/modals/pop_lights_model.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import 'package:pop_lights_app/screens/home_screen.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/add_pop_lights.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/add_poplight_scan.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/adjust_pop_lights.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/app_about.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/manage_groups.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/share_settings.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import 'package:pop_lights_app/utilities/size_config.dart';
import 'package:sqflite/sqlite_api.dart';

import '../main.dart';
import 'adjust_settings/scan_file.dart';
import '../utilities/app_colors.dart';

import 'adjust_settings/adjust_settings_home.dart';
import 'adjust_settings/scan_for_devices.dart';
import 'user_account_tabviews/my_pop_lights.dart';

class UserAccount extends StatefulWidget {
  static String routeName = "screens/user_account";

  const UserAccount({Key? key}) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  int tabIndex = 0;
  int generatedIndex = 0;
  int generatedIndex1 = 0;
  int pop_len = -1;
  int are_group = 0;
  List<PopLightModel> poplist = [];
  List<String> tabList = [
    "MY POPLIGHTS",
    "ADJUST SETTINGS",
    "ADD POPLIGHTS",
    "MANAGE GROUPS"
  ];
  List<ScanResult> discoveredBluetoothDevicesList = [];


  @override
  Widget build(BuildContext context) {
    final Args = (ModalRoute
        .of(context)!
        .settings
        .arguments ?? <int, List<ScanResult>>{}) as Map;


    generatedIndex = Args['popid'];
    if (generatedIndex == -1) {
      setState(() {
        tabIndex = -1;
      });
    }
    List<ScanResult> tempScan = Args["disclist"];


    // print("generated Index we got is :: $generatedIndex");


    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        return true;
      },
      child: FutureBuilder<List<PopLightModel>?>(
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
                poplist = snapshot.data!;
                bool present = false;
                discoveredBluetoothDevicesList = [];
                for (int i = 0; i < poplist.length; i++) {
                  for (int j = 0; j < tempScan.length; j++) {
                    if (tempScan[j].device.remoteId.toString() ==
                        poplist[i].popLightId.toString()) {
                      // print("matched");
                      for (int index = 0; index <discoveredBluetoothDevicesList.length; index++)
                        if (discoveredBluetoothDevicesList[index]?.device
                            .remoteId.toString()== tempScan[j].device.remoteId.toString()) {
                          present == true;
                        }
                      if (present == false)
                        discoveredBluetoothDevicesList.add(tempScan[j]);
                    }
                  }
                }
                // disconnect();


                print(
                   "Discovered ...............: $discoveredBluetoothDevicesList");
                return Scaffold(
                  backgroundColor: cream,
                  appBar: AppBar(
                    backgroundColor: cream,
                    elevation: 0,
                    leading: GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName),
                      child: Container(
                          height: getProportionateHeight(21.0),
                          width: getProportionateWidth(21.0),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/back_eclipse.png"),
                                  fit: BoxFit.none)),
                          child: Center(
                            child: loadSVG("assets/back_arrow.svg"),
                          )),
                    ),
                    title: Text(
                      "HOME",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: getProportionateHeight(20.0),
                          fontWeight: FontWeight.w900),
                    ),
                    centerTitle: true,
                  ),
                  body: Column(children: [
                    Container(
                      width: getProportionateWidth(310.0),
                      height: getProportionateHeight(154.0),
                      margin: EdgeInsets.fromLTRB(getProportionateWidth(41),
                          getProportionateHeight(20.0),
                          getProportionateWidth(41.0),
                          getProportionateHeight(0.0)),
                      child: GridView.count(
                          crossAxisCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: getProportionateWidth(10.0),
                          mainAxisSpacing: getProportionateHeight(6.0),
                          childAspectRatio: getProportionateWidth(149.0) /
                              getProportionateHeight(73.0),
                          children: List.generate(
                            tabList.length,
                                (index) =>
                                GestureDetector(
                                  onTap: () async {
                                    if (index == -1) {
                                      index = 0;
                                    }

                                    if (index == 0) {
                                      await DatabaseHelper.getAllPopLights()
                                          .then((value) {
                                        for (PopLightModel popLightModel in value!) {
                                         // print("print group id ${popLightModel
                                         //       .groupId}");
                                          if (popLightModel.groupId > 0) {
                                            setState(() {
                                              generatedIndex1 = 4;
                                            }
                                            );
                                          }
                                        }
                                        // print('length');
                                        // print(value!.length);
                                        pop_len = value!.length;
                                      });
                                    }

                                    //
                                    // print(
                                    //     "In user account this is tab index ${index}");
                                    setState(() {
                                      tabIndex = index;
                                      // print("tabIndex :::: $tabIndex");
                                      //
                                      // print(
                                      //     "In user account setting tab value to ${tabIndex}");
                                    });
                                  },
                                  child: Container(
                                    height: getProportionateHeight(73.0),
                                    width: getProportionateWidth(149.0),
                                    decoration: BoxDecoration(
                                      color: tabIndex == index
                                          ? primaryColor
                                          : cream,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          // Shadow color
                                          blurRadius: 4.0,
                                          // Spread of the shadow
                                          offset: Offset(0,
                                              4), // Offset of the shadow from the container
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: Text(
                                          "${tabList[index].split(
                                              " ")[0]} \n ${tabList[index]
                                              .split(" ")[1]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: tabIndex == index
                                                ? secondaryColor
                                                : Colors.black,
                                            fontSize: getProportionateHeight(
                                                20.0),
                                            fontWeight: tabIndex == index
                                                ? FontWeight.w900
                                                : FontWeight.w600,
                                          ),
                                        )),
                                  ),
                                ),
                          )),
                    ),
                    const Spacer(),
                    Container(
                      width: getProportionateWidth(390.0),
                      height: getProportionateHeight(545.0),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),
                      //child: const MyPopLights(),

                      child: screensOnIndex(tabIndex),
                    ),
                  ]
                  ),
                );
            }
          }
      ),
    );
  }

  screensOnIndex(index) {
// if(index!=-1)
//     setState(() {
//     generatedIndex=index;
//     });
//     else
//     setState(() {
//     index=generatedIndex;
//     });

    for (int index = 0; index < poplist.length; index ++)
      if (poplist[index].groupId > 0)
        are_group = 1;

    if (generatedIndex == 2)
      index = 1;
    // print("In Index i am getting this $index");
    switch (index) {
      case 0:
      // if(generatedIndex==4)
        if (generatedIndex == -1)
          return AppAbout();
        if (are_group > 0)
          return ManageGroups(
              BluetoothDevicesList: discoveredBluetoothDevicesList);
        else
          return MyPopLights(
              BluetoothDevicesList: discoveredBluetoothDevicesList);


      case 1:
        if (poplist.isNotEmpty)
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, ScanDevices.routeName,
                arguments: discoveredBluetoothDevicesList);
          });
        else {
          Fluttertoast.showToast(
              msg: "Please Add The Poplights!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return MyPopLights(
              BluetoothDevicesList: discoveredBluetoothDevicesList);;
        }

        break;

      case 2:
        return AddPoplightScan(
            BluetoothDevicesList: discoveredBluetoothDevicesList);

      case 3:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, GroupTabView.routeName,
              arguments: discoveredBluetoothDevicesList);
        });

        break;

      default:
        if (index == -1)
          return AppAbout();
        if (are_group > 0)
          return ManageGroups(
              BluetoothDevicesList: discoveredBluetoothDevicesList);
        else
          return MyPopLights(
              BluetoothDevicesList: discoveredBluetoothDevicesList);
    }
  }

  disconnect() async {
    for (ScanResult bluetoothDevice in discoveredBluetoothDevicesList) {
      // print("UserAccount disconnect");
      // print("device connected bluetoothdevice ${bluetoothDevice.advertisementData.txPowerLevel}");
      isConnectingOrDisconnecting[bluetoothDevice.device.remoteId] ??=
          ValueNotifier(true);
      isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value =
      true;
      await bluetoothDevice.device.disconnect().catchError((e) {
        final snackBar = snackBarFail(prettyException("Connect Error:", e));
        snackBarKeyC.currentState?.removeCurrentSnackBar();
        snackBarKeyC.currentState?.showSnackBar(snackBar);
      }).then((v) {
        isConnectingOrDisconnecting[bluetoothDevice.device.remoteId] ??=
            ValueNotifier(false);
        isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value =
        false;
      });
    }
  }

}
