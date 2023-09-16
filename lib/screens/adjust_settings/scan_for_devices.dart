
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pop_lights_app/screens/adjust_settings/adjust_settings_home.dart';
import '../../main.dart';

import '../../modals/blue_ch.dart';
import '../../modals/group_model.dart';
import '../../modals/pop_lights_model.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/database_helper.dart';
import '../../utilities/size_config.dart';
import '../user_account.dart';




class ScanDevices extends StatefulWidget {

  static String routeName = "screens/adjust_settings/scan_for_devices";

  const ScanDevices({Key? key}) : super(key: key);

  @override
  State<ScanDevices> createState() => _ScanDevices();
}
class BluetoothCh {
  final String characteristic;

  BluetoothCh(this.characteristic);

// Add any additional properties or methods as needed
}

class _ScanDevices extends State<ScanDevices> {
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
  int flag=0;
  List<BluetoothDevice>  d1=[];

  // final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting = {};
  // late StreamSubscription<FGBGType> subscription;

  int sec_counter=0;
  final DateTime now = DateTime.now();

  @override
  void initState() {

    super.initState();
    sec_counter=0;
    startScanner();


    // _counter=Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     sec_counter++;
    //   });
    //
    // });


  }
  @override

 void dispose() {

    super.dispose();
}

//
  @override
  Widget build(BuildContext context) {
    discoveredBluetoothDevicesList = ModalRoute.of(context)!.settings.arguments as List<ScanResult>;


    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () async {

        Navigator.pushReplacementNamed(context, UserAccount.routeName,
            arguments: {"popid": 0, "disclist": discoveredBluetoothDevicesList});
        return true;
      },

      child:
      Stack(
        children: [
          Container(

            width: double.infinity, // Fills the width of the parent
            height: double.infinity,
            child: SvgPicture.asset("assets/connection_waiting.svg",fit: BoxFit.fill,),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.03,
              ),

              Text(
                "timer:${sec_counter}",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
              ),
              Container(

                  alignment: Alignment(0.0, -0.5),
                  child: CircularProgressIndicator(

                    color: Colors.red,


                  )
              ),

            ],
          ),
        ],
      ),
    );
    // }});






  }





//   int cou=-1;
//   stream() async {
//
//     // var box =await Hive.openBox<BluetoothCharacteristic1>('blech');
//     print("In Stream ---------------------------------------------------------------");
//     for(ScanResult r in discoveredBluetoothDevicesList){
//       List<BluetoothService> services = await r.device.discoverServices();
//       // print("Services in stream $services");
//       services.forEach((service) async {
//         BluetoothCharacteristic? chh,chhh;
//         // print("services we got .......${service}");
//         if (service.serviceUuid.toString().toUpperCase().contains("FFB0") == true) {
//           for (BluetoothCharacteristic bc in service.characteristics) {
//             if (bc.characteristicUuid.toString().toUpperCase().contains("FFB1") == true) {
//               chh=bc;
//               //
//               // var a = ble_ch.BluetoothCharacteristic1(remoteId: bc.remoteId , serviceUuid: bc.serviceUuid, secondaryServiceUuid: bc.secondaryServiceUuid, characteristicUuid: bc.characteristicUuid, descriptors: bc.descriptors, characteristicProperties: bc.properties , value: bc.value);
//               //
//               //
//               // await box.add(a);
//               // DatabaseHelper.insertch(bc);
//               // print("characterstic are $bc");
//             }
//           }
//         }
//         //
//         // var storedCharacteristic=box.get(0) as ble_ch.BluetoothCharacteristic1?;
//         // if(storedCharacteristic!=null)
//         // print(storedCharacteristic);
//         bool present=false;
//         for (int index=0;index<ch1.length;index++)
//           if(ch1[index]?.remoteId==chh?.remoteId || chh==null) {
//             present == true;
//             chh=chhh;
//           }
//         if(ch1==[]&& chh!=null)
//           ch1=[chh];
//         if(!present){
//           if(chh!=null)
//             ch1.add(chh);
//           chh=chhh;
//         }
//
//       });
//
//     }
//     if(ch1.length>1){
//       chgen=true;
//     }
//
//
//   }
//
//   connection() async{
//     final DateTime start = DateTime.now();
//     print("start connection : ${start.second} ${start.millisecond}");
//     print("Conection:--------------------------------------------------");
//     // for (ScanResult bluetoothDevice in discoveredBluetoothDevicesList) {
//     //   if (!foundPopLightsList.contains(bluetoothDevice))
//     //     foundPopLightsList.add(bluetoothDevice);
//     // }
//     for (ScanResult bluetoothDevice in discoveredBluetoothDevicesList) {
//       if (bluetoothDevice.device.localName == 'POP_Light') {
//         // print("connection with pop in comparision ");
//         print("device iam connecting with ${bluetoothDevice.device.remoteId}");
//
//           await bluetoothDevice.device.connect(timeout:Duration(seconds:2));
//
//
//
//
//       }
//     }
//     final DateTime stop_con = DateTime.now();
//
//     print("Connection stopped ${stop_con.second} ${stop_con.millisecond} ");
//
//   }
//
//
//   void callDiscoverServices() async {
//     print("in callDiscoverServices-----------------------------------------------");
//
//     try {
//       for(int x=0;x<discoveredBluetoothDevicesList.length;x++){
//         await discoveredBluetoothDevicesList[x].device.discoverServices();
//         print("Discovered Device $x");
//       }
//     }catch(e){
//       print(e.toString());
//     //   Fluttertoast.showToast(
//     //       msg: "",
//     //       toastLength: Toast.LENGTH_SHORT,
//     //       gravity: ToastGravity.BOTTOM,
//     //       timeInSecForIosWeb: 1,
//     //       backgroundColor: Colors.red,
//     //       textColor: Colors.white,
//     //       fontSize: 16.0);
//     }
//   }
  startScanner() async
  { bool present=false;


  try{

    FlutterBluePlus.scanResults.listen((results) async {

      for (ScanResult r in results) {
        if (r.device.localName == "POP_Light") {
          for (int index = 0; index <
              foundPopLightsList.length; index++) {

            if (foundPopLightsList[index]?.device.remoteId.toString()==
                r?.device.remoteId.toString()) {
              present == true;
            }
          }
          if (present == false) {
            foundPopLightsList.add(r);
          }
          // print('${r.device.localName} found! rssi: ${r.rssi}');

        }
      }
    });
// Start scanning
    print("before scan length ${discoveredBluetoothDevicesList}");
    FlutterBluePlus.startScan(timeout: Duration(milliseconds: 200));
// Stop scanning
    await Future.delayed(Duration(milliseconds: 500));

    // Stop scanning
    await FlutterBluePlus.stopScan();


    for (int j = 0; j < foundPopLightsList.length; j++) {
      if (foundPopLightsList[j].device.remoteId.toString() =="POP_Light") {
        // print("matched");
        for (int index = 0; index <discoveredBluetoothDevicesList.length; index++)
          if (discoveredBluetoothDevicesList[index]?.device
              .remoteId.toString()== foundPopLightsList[j].device.remoteId.toString()) {
            present == true;
          }
        if (present == false)
          discoveredBluetoothDevicesList.add(foundPopLightsList[j]);
      }
    }



    int length=discoveredBluetoothDevicesList.length;
    print("Devices in discovered list after scan");
    for (int i=0;i<discoveredBluetoothDevicesList.length;i++)
    {
      print("Devic ${discoveredBluetoothDevicesList[i].device.remoteId}");
      if(i==discoveredBluetoothDevicesList.length-1)
        begin();

    }



    if(FlutterBluePlus.isScanning==false)
    {
      print("Stoped scanning");
    }
  }
  catch (e) {
    final snackBar = snackBarFail(prettyException("Start Scan Error:", e));
    snackBarKeyB.currentState?.removeCurrentSnackBar();
    snackBarKeyB.currentState?.showSnackBar(snackBar);
  }

  }


//   disconnect() async{
//     for (ScanResult bluetoothDevice in foundPopLightsList) {
//       isConnectingOrDisconnecting[bluetoothDevice.device.remoteId] ??= ValueNotifier(true);
//       isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value = true;
//       await bluetoothDevice.device.disconnect().catchError((e) {
//         final snackBar = snackBarFail(prettyException("Connect Error:", e));
//         snackBarKeyC.currentState?.removeCurrentSnackBar();
//         snackBarKeyC.currentState?.showSnackBar(snackBar);
//       }).then((v) {
//         isConnectingOrDisconnecting[bluetoothDevice.device.remoteId] ??= ValueNotifier(false);
//         isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value = false;
//       });
//     }
//   }


  connection(BluetoothDevice bluetoothDevice) async {

    if(await is_connected(bluetoothDevice)==false){
    if (bluetoothDevice.localName == 'POP_Light')
    {
      bool present=false;
      for (int index=0;index<ch1.length;index++){
        if(ch1[index]?.remoteId==bluetoothDevice.remoteId) {
          present == true;

        }}
      if(!present){
        print("connection with pop in comparision ");
        print("device iam connecting with $bluetoothDevice");


        isConnectingOrDisconnecting[
        bluetoothDevice.remoteId] ??= ValueNotifier(true);
        isConnectingOrDisconnecting[bluetoothDevice.remoteId]!
            .value = true;
        await bluetoothDevice
            .connect(timeout: Duration(seconds: 1))
            .catchError((e) {
          final snackBar =
          snackBarFail(prettyException("Connect Error:", e));
          snackBarKeyC.currentState?.removeCurrentSnackBar();
          snackBarKeyC.currentState?.showSnackBar(snackBar);
        }).then((v) {
          isConnectingOrDisconnecting[bluetoothDevice.remoteId] ??= ValueNotifier(false);
          isConnectingOrDisconnecting[
          bluetoothDevice.remoteId]!
              .value = false;
        });
        bool isconnected=await is_connected(bluetoothDevice);
        print("isconnected $isconnected");

        // print("device iam connected with $bluetoothDevice");

      }
    }
 }

  }



  stream(BluetoothDevice r) async {
    print("In Stream ---------------------------------------------------------------");
    // for(ScanResult r in discoveredBluetoothDevicesList){

      List<BluetoothService> services =
          await r.discoverServices(timeout: 1);
      // print("Services in stream $services");
      services.forEach((service) async {
        BluetoothCharacteristic? chh, chhh;
        // print("services we got .......${service}");
        if (service.serviceUuid.toString().toUpperCase().contains("FFB0") ==
            true) {
          for (BluetoothCharacteristic bc in service.characteristics) {
            if (bc.characteristicUuid
                    .toString()
                    .toUpperCase()
                    .contains("FFB1") ==
                true) {
              chh = bc;
            }
          }
        }
        bool present = false;
        for (int index = 0; index < ch1.length; index++)
          if (ch1[index]?.remoteId == chh?.remoteId || chh == null) {
            present == true;
            chh = chhh;
          }
        if (ch1 == [] && chh != null) ch1 = [chh];
        if (!present) {
          if (chh != null) {
            ch1.add(chh);
          }
          chh = chhh;
        }
      });

      if(d1.isNotEmpty)
        {
          for(int i = 0 ; i < d1.length ; i++ )
            {
              connection(d1[i]);
            }
        }
    // print("ch1 $ch1 ");
    print("discoveredBluetoothDevicesList length ${discoveredBluetoothDevicesList.length}");
    // if (ch1.length==discoveredBluetoothDevicesList.length) {
    //   print("ch list we are sending $ch1");
    //
    //
    //   Navigator.pushReplacementNamed(context, AdjustSettingsHome.routeName,
    //       arguments: {
    //         'ch': ch1,
    //         "disclist": discoveredBluetoothDevicesList
    //       });
    // }

    print("Length of ch ${ch1.length}");
  }

   is_connected(BluetoothDevice device) {
    bool state=false;
    device.state.listen((event) {
      if(event==BluetoothConnectionState.connected) {
        state = true;
         stream(device);
        print(state);

      }else
      if(event==BluetoothConnectionState.disconnected) {
        state=false;
        flag=1;
        // d1.add(device);
        print(state);
      }
      else  if(event==BluetoothConnectionState.connecting)
        {
          print("connecting");
        }

    });

    return state;

  }

  is_present(ScanResult r)async
  {
    bool present=false;
    for (int i=0;i<ch1.length;i++){
      if(ch1[i]?.remoteId==r?.device.remoteId ) {
        present == true;
      }}
    if(!present){
      await  connection(r.device);
    }
  }

  void begin() async{
    for (int i=0;i<discoveredBluetoothDevicesList.length;i++){
      print("Device ${discoveredBluetoothDevicesList[i].device.remoteId} ");
      await connection(discoveredBluetoothDevicesList[i].device);
      if(i==discoveredBluetoothDevicesList.length-1)
        {

          Navigator.pushReplacementNamed(context, AdjustSettingsHome.routeName,
              arguments: {
                'ch': ch1,
                "disclist": discoveredBluetoothDevicesList
              });
        }
    }

  }

}
