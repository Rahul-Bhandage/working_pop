import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/my_pop_lights.dart';

import '../../utilities/size_config.dart';
import '../Msg_Navigator.dart';
import '../group_tabview.dart';
import '../user_account.dart';


class deletedSuccessfully extends StatefulWidget {

  static String routeName = "screens/user_account_tabviews/delete_successful.dart";
  //
  // List<ScanResult> BluetoothDevicesList=[];
  const deletedSuccessfully({Key? key}) : super(key: key);


  @override
  State<deletedSuccessfully> createState() => _deletedSuccessfullyState();
}

class _deletedSuccessfullyState extends State<deletedSuccessfully> {
  List<ScanResult> BluetoothDevicesList=[];
  List<String> tabTitlesList = ["Group 1", "Group 2", "Group 3"];
  @override
  void initState() {

    super.initState();

    Timer(const Duration(seconds: 2), () {
      for (int i = 0; i < tabTitlesList.length; i++) {
        print("in remove s......");
        if (i == tabTitlesList.length - 1) {
          Navigator.pushReplacementNamed(context, GroupTabView.routeName,
              arguments: BluetoothDevicesList)
              .then((value) => setState(() {}));
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

      child: Container(

        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(


          image: DecorationImage(image: AssetImage("assets/del_success.png"), fit: BoxFit.fill),


        ),
      ),
    );

  }

}
