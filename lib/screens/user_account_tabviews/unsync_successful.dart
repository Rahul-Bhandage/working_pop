import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/my_pop_lights.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';

import '../../utilities/size_config.dart';
import '../Msg_Navigator.dart';
import '../user_account.dart';


class unsyncedSuccessfully extends StatefulWidget {

  static String routeName = "screens/user_account_tabviews/unsync_successful.dart";
  //
  // List<ScanResult> BluetoothDevicesList=[];
  const unsyncedSuccessfully({Key? key}) : super(key: key);


  @override
  State<unsyncedSuccessfully> createState() => _unsyncedSuccessfullyState();
}

class _unsyncedSuccessfullyState extends State<unsyncedSuccessfully> {
  List<ScanResult> BluetoothDevicesList=[];
  List<String> tabTitlesList = ["Group 1", "Group 2", "Group 3"];
  @override
  void initState() {

    super.initState();

    Timer(const Duration(seconds: 2), () {
      for (int i = 0; i < tabTitlesList.length; i++) {
        print("in remove s......");
        if (i == tabTitlesList.length - 1) {
          Navigator.pushReplacementNamed(context, UserAccount.routeName,
              arguments:  {"popid":0,"disclist":BluetoothDevicesList});
        }

      }
    });
  }



  @override
  Widget build(BuildContext context) {
    BluetoothDevicesList=ModalRoute.of(context)?.settings.arguments as  List<ScanResult>;
    print("im inside remove s widigt");
    SizeConfig().init(context);
    return Container(

      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(

        image: DecorationImage(image: AssetImage("assets/UNSYNCsuccessful.png"), fit: BoxFit.fill),
        //  loadSVG("assets/UNSYNCsuccessful.svg");

      ),
    );

  }

}
