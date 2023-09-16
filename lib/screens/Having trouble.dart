
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/modals/pop_lights_model.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import 'package:pop_lights_app/screens/home_screen.dart';
import 'package:pop_lights_app/screens/user_account.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/add_poplight_scan.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/app_about.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/manage_groups.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import 'package:pop_lights_app/utilities/size_config.dart';
import '../utilities/app_colors.dart';
import 'adjust_settings/scan_for_devices.dart';
import 'user_account_tabviews/my_pop_lights.dart';

class HavingTrouble extends StatefulWidget {
  static String routeName = "screens/Having_trouble";

  const HavingTrouble({Key? key}) : super(key: key);

  @override
  State<HavingTrouble> createState() => _HavingTrouble();
}

class _HavingTrouble extends State<HavingTrouble> {
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

    List<ScanResult> tempScan = Args["disclist"];
    print("generated Index we got is :: $generatedIndex");
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        return true;
      },
      child: Scaffold(
        backgroundColor: cream,
        appBar: AppBar(
          backgroundColor: cream,
          elevation: 0,
          leading: GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName),
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
            margin: EdgeInsets.fromLTRB(
                getProportionateWidth(41), getProportionateHeight(20.0),
                getProportionateWidth(41.0), getProportionateHeight(0.0)),
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
                          Navigator.pushReplacementNamed(
                              context, UserAccount.routeName,
                              arguments: {
                                "popid": 0,
                                "disclist": tempScan
                              });
                        },
                        child: Container(
                          height: getProportionateHeight(73.0),
                          width: getProportionateWidth(149.0),
                          decoration: BoxDecoration(
                            color:  cream,
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
                                    " ")[0]} \n ${tabList[index].split(
                                    " ")[1]}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: getProportionateHeight(20.0),
                                  fontWeight:FontWeight.w600,
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
              BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            //child: const MyPopLights(),

            child: const AppAbout(),
          ),
        ]
        ),

      ),
    );
  }
}
