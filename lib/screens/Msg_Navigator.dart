
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pop_lights_app/modals/pop_lights_model.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import 'package:pop_lights_app/screens/home_screen.dart';
import 'package:pop_lights_app/screens/user_account.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/add_pop_lights.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/add_poplight_scan.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/delete_grp_success.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/error_msg.dart';

import 'package:pop_lights_app/screens/user_account_tabviews/manage_groups.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/my_pop_lights.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/remove_from_grp_successfull.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/rename_successful.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/share_settings.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/unsync_successful.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import 'package:pop_lights_app/utilities/size_config.dart';
import 'package:sqflite/sqlite_api.dart';

import '../main.dart';
import '../utilities/app_colors.dart';

import 'adjust_settings/adjust_settings_home.dart';


class Messenger extends StatefulWidget {
  static String routeName = "screens/Msg_Navigator";

  const Messenger({Key? key}) : super(key: key);

  @override
  State<Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  int generatedIndex = 0;
  List<ScanResult> discoveredBluetoothDevicesList = [];


  @override
  Widget build(BuildContext context) {
    final Args = (ModalRoute
        .of(context)!
        .settings
        .arguments ?? <int, List<ScanResult>>{}) as Map;

    generatedIndex = Args['id'];
    discoveredBluetoothDevicesList = Args["disclist"];
    print("POP IN MORE $generatedIndex");
    print("Discovered ...............: $discoveredBluetoothDevicesList");


    screensOnIndex(index) {

      print("In Index i am getting this $index");
      switch (index) {
        case 0:
            print("In ..Messenger");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context,UserAccount.routeName,
                  arguments:  {"popid":0,"disclist":discoveredBluetoothDevicesList});
            });
            // return RenamedSuccessfully( BluetoothDevicesList: discoveredBluetoothDevicesList);
            break;





        case 1:
          print("In ..Messenger");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context,RemoveSuccessfully.routeName,
                arguments: discoveredBluetoothDevicesList);
          });
          // return RenamedSuccessfully( BluetoothDevicesList: discoveredBluetoothDevicesList);
          break;
        case 2:
          print("In ..Messenger");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context,unsyncedSuccessfully.routeName,
                arguments: discoveredBluetoothDevicesList);
          });
          break;
        case 3:
          print("In ..Messenger");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context,Error_msg.routeName,
                arguments: discoveredBluetoothDevicesList);
          });

          break;
        case 4:
          print("In ..Messenger");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context,deletedSuccessfully.routeName,
                arguments: discoveredBluetoothDevicesList);
          });
          break;
        default:
          return MyPopLights(
              BluetoothDevicesList: discoveredBluetoothDevicesList);
          break;
      }
    }
    screensOnIndex(generatedIndex);
    return Container();
  }
}
