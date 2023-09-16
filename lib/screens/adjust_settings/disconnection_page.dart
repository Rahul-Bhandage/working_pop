
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pop_lights_app/screens/adjust_settings/adjust_settings_home.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import '../../main.dart';
import '../../modals/group_model.dart';
import '../../modals/pop_lights_model.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/database_helper.dart';
import '../../utilities/size_config.dart';
import '../user_account.dart';



class DisconnectDevices extends StatefulWidget {

  static String routeName = "screens/adjust_settings/disconnection_page";

  const DisconnectDevices({Key? key}) : super(key: key);

  @override
  State<DisconnectDevices> createState() => _DisconnectDevices();
}
class BluetoothCh {
  final String characteristic;

  BluetoothCh(this.characteristic);

// Add any additional properties or methods as needed
}

class _DisconnectDevices extends State<DisconnectDevices> {
  double t=0;
  bool chgen=false;
  double brightnessLevel = 0.0;
  int warmthLever = 0;
  int timerState = 0;
  int selectedIndex = 0;
  bool isCustomTimer = false;
  String selectedValue = "";
  int dropDownIndex = 0;
  int groupPopLights = 0;
  bool isToggled = false;
  bool isTog = false;
  int i = 0;
  int con_time=1;
  int discoveredCount=0;
  bool flagDiscoverServices = false;


  BluetoothCharacteristic? ch,chr;
  List<BluetoothCharacteristic?> ch1=[],ch2=[];
  List<Map<String, dynamic>> ch_group=[];
  bool _showOverlay = false;
  List<GroupModel> groupsList = [];
  List<PopLightModel> popLightsList = [];
  List<ScanResult> discoveredBluetoothDevicesList = [];
  List<ScanResult> foundPopLightsList = [];
  List<BluetoothCh> bluetoothCharacteristics=[];


  final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting = {};
  late StreamSubscription<FGBGType> subscription;

  Timer?_counter;
  int sec_counter=0;
  final DateTime now = DateTime.now();

  @override
  void initState() {

    super.initState();
    sec_counter=0;

    // _counter=Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     sec_counter++;
    //   });
    //
    // });
  }
  @override
  void dispose() {
    // _counter?.cancel();
    super.dispose();
  }

//
  @override
  Widget build(BuildContext context) {
    discoveredBluetoothDevicesList = ModalRoute.of(context)!.settings.arguments as List<ScanResult>;
    timer_function();
    SizeConfig().init(context);
    //   return  FutureBuilder<List<Map<String, dynamic>>>(
    //       future: DatabaseHelper.getch(),
    //   builder: (context, snapshot) {
    //   switch (snapshot.connectionState) {
    //     case ConnectionState.none:
    //       return Container();
    //
    //     case ConnectionState.waiting:
    //       return Container();
    //
    //     case ConnectionState.active:
    //       return Container();
    //
    //     case ConnectionState.done:
    //       ch_group=snapshot.data!;
    //       List<Map<String, dynamic>> data = ch_group; // Your list of data
    //
    // // Your list of data
    //
    //   List<BluetoothCh> bluetoothCharacteristics = data.map((item) {
    //   return BluetoothCh(item['characteristic']);
    //   }).toList();
    //   print("print ch2 $bluetoothCharacteristics");
    // for(BluetoothCh abc in bluetoothCharacteristics)
    //   {
    //     ch2[].
    //     ch2.add(abc.characteristic as BluetoothCharacteristic?);
    //     print("ch we got ${abc.characteristic}");
    //   }

    return WillPopScope(
      onWillPop: () async {

        Navigator.pushReplacementNamed(context, UserAccount.routeName,
            arguments: {"popid": 0, "disclist": foundPopLightsList});
        return true;
      },
      child:
      Stack(
        children: [
          Container(

              width: double.infinity, // Fills the width of the parent
              height: double.infinity,
              child: SvgPicture.asset("assets/disconnecting.svg",fit: BoxFit.fill,),
          ),

          Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.03,
            ),

            Text(
              "timer:${sec_counter}",
              style: TextStyle(fontSize: 20, color: highlightColor),
            ),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
            ),
            Container(

                alignment: Alignment(0.0, 0.5),
                child: CircularProgressIndicator(

                  color: highlightColor,


                )
            ),

          ],
        ),
        ],
      ),


      );
    // }});






  }

  timer_function() async
  {

    for (ScanResult bluetoothDevice in discoveredBluetoothDevicesList) {
      isConnectingOrDisconnecting[bluetoothDevice.device.remoteId] ??= ValueNotifier(true);
      isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value = true;
      await bluetoothDevice.device.disconnect().catchError((e) {
        final snackBar = snackBarFail(prettyException("Connect Error:", e));
        snackBarKeyC.currentState?.removeCurrentSnackBar();
        snackBarKeyC.currentState?.showSnackBar(snackBar);
      }).then((v) {
        isConnectingOrDisconnecting[bluetoothDevice.device.remoteId] ??= ValueNotifier(false);
        isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value = false;
      });
    }
    print("length of device disconnecting ${discoveredBluetoothDevicesList.length}");
        Navigator.pushReplacementNamed(context, UserAccount.routeName,arguments:  {"popid":0,"disclist":discoveredBluetoothDevicesList});


  }


}
