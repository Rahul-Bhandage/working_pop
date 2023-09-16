import 'dart:async';
import 'dart:io';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/size_config.dart';
import '../../main.dart';
import '../../modals/combination_model.dart';
import '../../modals/group_model.dart';
import '../../modals/pop_lights_model.dart';
import '../../utilities/database_helper.dart';
import '../user_account.dart';
import 'disconnection_page.dart';

class AdjustSettingsHome extends StatefulWidget {
  static String routeName = "screens/adjust_settings_home";

  const AdjustSettingsHome({super.key});

  @override
  State<AdjustSettingsHome> createState() => _AdjustSettingsHomeState();
}
class BluetoothCh {
  final BluetoothCharacteristic characteristic;

  BluetoothCh(this.characteristic);

// Add any additional properties or methods as needed
}
class _AdjustSettingsHomeState extends State<AdjustSettingsHome> {
  double brightnessLevel = 0.0;
  int warmthLever = 0;
  int timerState = 0;
  int selectedIndex = 0;
  bool servicefound = false;

  bool isCustomTimer = false;
  String selectedValue = "";
  int dropDownIndex = 0;
  int groupid = 0;
  int groupPopLights = 0;
  bool isToggled = false;
  bool isTog = false;
  bool discovered = false;
  bool proceeddiscovery = false;
  int i = 0;
  bool individual = false;
  bool grouped = false;
  bool poplight=true;
  bool gpop=true;

  int ison=0;

  int discoveredCount = 0;
  int disconnectCount = 0;
  bool flagDiscoverServices = false;

  BluetoothCharacteristic? ch, chr;

  var ser;
  List<int> gHasPoplight=[];
  List<List<BluetoothService>> service_list = [];
  List<BluetoothCharacteristic?> ch1 = [];
  List<BluetoothCh> ch2 = [];
  List<BluetoothCharacteristic?> tempch1 = [];
  List<BluetoothCh?> tempch2 = [];
  List<BluetoothService> service = [];
  List<GroupModel> groupsList = [];
  List<PopLightModel> popLightsList = [];
  List<PopLightModel> grppopLightsList = [];
  List<PopLightModel> pll=[];
  List<GroupModel> gll=[];
  int r = 0;
  List<ScanResult> discoveredBluetoothDevicesList = [];
  List<ScanResult> foundPopLightsList = [];
  final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting = {};
  late StreamSubscription<FGBGType> subscription;


  @override
  void initState() {
    generateMinutesToBleCommandMap();

    subscription = FGBGEvents.stream.listen((event) async {
      if (event == FGBGType.foreground) {
        print("APP IN FOREGROUND ");

//if its come back to foreground, then restart your app
      } else {
//if its gone to background
        print("APP IN background ");
        // for (ScanResult r in foundPopLightsList)
        //   if (r.advertisementData.connectable == false) await r.device.disconnect();
      }
    });
    super.initState();
  }

  @override
  void dispose() async{
    // disconnect();

    // print("APP IN Dispose ");
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Args =
    (ModalRoute.of(context)!.settings.arguments ?? <String, List<ScanResult>>{}) as Map;
    tempch1=[];
    tempch1 = Args['ch'];
    foundPopLightsList = Args['disclist'];

    print(
        "---------------------------------------------------------------------------------------");

    print(
        "---------------------------------------------------------------------------------------");

    print(
        "---------------------------------------------------------------------------------------");
//
    print('tempch1 :${tempch1.length}');


    print(
        "---------------------------------------------------------------------------------------");

    print(
        "---------------------------------------------------------------------------------------");

    print(
        "---------------------------------------------------------------------------------------");

    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
          // disconnect();
          Navigator.pushReplacementNamed(context, DisconnectDevices.routeName,
              arguments:foundPopLightsList);
          return true;
        },
        child: Scaffold(
          //APP BAR ...begins

          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () async {
                // disconnect();

                Navigator.pushReplacementNamed(context, DisconnectDevices.routeName,
                    arguments:foundPopLightsList);
              },
              child: Container(
                  height: getProportionateHeight(11.0),
                  width: getProportionateWidth(21.0),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/back_eclipse.png"), fit: BoxFit.none)),
                  child: Center(
                    child: loadSVG("assets/back_arrow.svg"),
                  )),
            ),
            flexibleSpace: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    // disconnect();

                    // print("Home is pressed");
                    Navigator.pushReplacementNamed(context, DisconnectDevices.routeName,
                        arguments:foundPopLightsList);
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).padding.top * 0.45,
                          top: MediaQuery.of(context).padding.top * 1.57,
                          left: MediaQuery.of(context).padding.top * 0.45),
                      child: Text(
                        "HOME",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            fontSize: getProportionateHeight(14.0)),
                      )),
                ),
              ],
            ),
            centerTitle: true,
          ),

          body: Stack(
            children: [
              //Combined model for Both POP Light and Group Model

              FutureBuilder<List<CombineModel>>(
                future: DatabaseHelper.getCombinedModels(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.active:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.done:
                      final combinedModels = snapshot.data!;
                      List<int> length_pop = [], length_grp = [];
                      //combinedModels has collection of both pop and grp which needs to seperated
                      //combinedModels( popLightModel , GroupModel  );
                      snapshot.data!.map((e) {
                        length_pop.add(e.length_of_model1);
                        length_grp.add(e.length_of_model2);
                        // print("length_pop $length_pop");
                        // print("length_grp $length_grp");
                      });

                      popLightsList = combinedModels[0].model1;
                      if(poplight){
                        for(int i=0;i<popLightsList.length;i++){
                          if(popLightsList[i].groupId==0){
                            pll.add(popLightsList[i]);
                          }else{
                            if(!gHasPoplight.contains(popLightsList[i].groupId))
                              gHasPoplight.add(popLightsList[i].groupId);
                          }
                        }
                        poplight=false;
                      }
                      gll = combinedModels[0].model2;
                      if(gpop){
                        for(int i=0;i<gll.length;i++) {
                          for(int o=0;o<gHasPoplight.length;o++){
                            if(gll[i].groupId==gHasPoplight[o]){
                              groupsList.add(gll[i]);
                            }
                          }
                        }
                        gpop=false;
                      }
                      // print("PLL :${pll}");
                      // print("GLL :${groupsList}");
                      // // popLightsList = List.generate(
                      //     length_pop[1], (
                      //     index) => combinedModels[index].model1);
                      // groupsList = List.generate(
                      //     length_grp[1], (
                      //     index) => combinedModels[index].model2);
                      //



                      List<String> p1 = [];
                      List<String> g1 = [];
                      int j = 1;
                      //printing poplight list and group  list
                      // for (int i = 0; i < popLightsList.length; i++) {
                      //   print("poplist : ${popLightsList[i].popLightName}");
                      //   if (p1.contains(popLightsList[i].popLightName) && p1 != Null) {
                      //     p1.add(popLightsList[i].popLightName + j.toString());
                      //     j++;
                      //   } else {
                      //     p1.add(popLightsList[i].popLightName);
                      //   }
                      // }
                      for(int index=0;index<pll.length;index++)
                      {
                        if(pll[index].groupId<1);
                        if (p1.contains(pll[index].popLightName) && p1 != Null) {
                          p1.add(pll[index].popLightName + j.toString());
                          j++;
                        } else {
                          p1.add(pll[index].popLightName);
                        }
                      }


                      List<String> p2 = [];
                      for (int i = 0; i < pll.length; i++) {
                        // print("poplist : ${pll[i].popLightName}");
                        if (p2.contains(pll[i].popLightName) && p2 != Null) {
                          p2.add(pll[i].popLightName + j.toString());
                          j++;
                        } else {
                          p2.add(popLightsList[i].popLightName);
                        }
                      }
                      j = 1;
                      for (int i = 0; i < groupsList.length; i++) {
                        // print("grouplist : ${groupsList[i].groupId}");

                        //   if(g1.contains(groupsList[i].groupName)&& g1!=Null){
                        //       groupsList[i].groupName=groupsList[i].groupName+j.toString();
                        //   print("I contain groupname");
                        //     g1.add(groupsList[i].groupName);
                        //     j++;
                        //   }
                        //   else{
                        //     g1.add(groupsList[i].groupName);
                        //   }
                      }
                      j = 0;

                      //generating drop down elements
                      List<String> tabList = p1 +List.generate(groupsList.length, (index) => groupsList[index].groupName);

                      if (selectedValue.isEmpty) {
                        selectedValue = tabList.first;
                      }
                      //
                      // print("TabList: $tabList");
                      // print("dropDownIndex: $dropDownIndex");
                      // print("popLightsList length: ${popLightsList.length}");
                      //
                      if(pll.length!=0)
                        if (dropDownIndex < pll.length) {
                          for (int index = 0; index < tempch1.length; index++) {
                            if (tempch1[index]?.remoteId.toString() ==
                                pll[dropDownIndex].popLightId.toString()) {
                              ch = tempch1[index];

                              // ch_generator(popLightsList[dropDownIndex-1]);
                              // print("im ch $ch");
                              print('ch');
                              ch!.onValueReceived.listen((event) {
                                // print("CH RECEIVED VALUE : ${event}");
                              });
                            }
                          }  individual = true;
                          grouped = false;
                        }

                      if (dropDownIndex >= pll.length) {
                        if (groupsList.length > 0) {
                          for (int index = 0; index < groupsList.length; index++) {
                            print(
                                "checking grp ${tabList[dropDownIndex] == groupsList[index].groupName}");
                            if (tabList[dropDownIndex] == groupsList[index].groupName) {
                              groupid = groupsList[index].groupId;
                            }
                          }
                          grppopLightsList = [];
                          ch1=[];
                          for (int index = 0; index < popLightsList.length; index++) {
                            if (popLightsList[index].groupId == groupid)
                              grppopLightsList.add(popLightsList[index]);
                          }
                          for (int index = 0; index < grppopLightsList.length; index++) {

                            for (int index1 = 0; index1 < tempch1.length; index1++) {

                              if (grppopLightsList[index].popLightId.toString() ==
                                  tempch1[index1]?.remoteId.toString()) {


                                bool present=false;
                                for (int index2=0;index2<ch1.length;index2++)
                                  if(ch1[index2]?.remoteId==tempch1[index1]?.remoteId ) {
                                    present == true;

                                  }
                                if(!present){
                                  ch1.add(tempch1[index1]);
                                }

                              }
                            }

                            individual = false;
                            grouped = true;
                            print("Discovered List length ${ch1.length}");
                            // print("im ch1 ${ch1!}");
                          }
                        } else {
                          print("No Grouped Elements!!");
                        }
                      }

                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/adjust_settings_background.jpg"),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                "assets/wavy_background.png",
                                fit: BoxFit.fill,
                              )),



                          if(individual==true)
                            Container(
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      SizedBox(
                                        height: getProportionateHeight(720.0),
                                      ),
                                      Stack(
                                        children: [
                                          Image(
                                              image: AssetImage(isToggled
                                                  ?  "assets/pop_light_on.png"
                                                  :"assets/pop_light_off_state.png")
                                          ),
                                          Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.center,

                                              children: [
                                                SizedBox(
                                                  height:getProportionateHeight(180),
                                                  width: getProportionateWidth(120.0),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top:80,left:40),
                                                  child: GestureDetector(

                                                    child: loadSVG(isToggled
                                                        ? "assets/on_button.svg"
                                                        : "assets/off_button.svg"),
                                                    onTap: () async {
                                                      if (isToggled) {
                                                        // OFF button tapped
                                                        print("Off Clicked");

                                                        print(
                                                            "Command place ------------------------------");
                                                        // if(dropDownIndex >popLightsList.length)
                                                        // if (grouped == true) if (ch1.length > 0) {
                                                        //   for (int q = 0; q < ch1.length; q++) {
                                                        //     ch1[q]!.write([0x1, 0x1, 0x0],
                                                        //         withoutResponse: ch1[q]!
                                                        //             .properties
                                                        //             .writeWithoutResponse);
                                                        //   }
                                                        // }
                                                        if (ch != null) {
                                                          ch?.write([0x1, 0x1, 0x0],
                                                              withoutResponse:
                                                              ch!.properties.writeWithoutResponse);
                                                        }
                                                      } else {
                                                        // ON button tapped

                                                        print("ON Clicked");
                                                        // if(dropDownIndex >popLightsList.length)
                                                        // if (ch1.length > 0) {
                                                        //   for (int q = 0; q < ch1.length; q++) {
                                                        //     ch1[q]!.write([0x1, 0x1, 0x1],
                                                        //         withoutResponse: ch1[q]!
                                                        //             .properties
                                                        //             .writeWithoutResponse);
                                                        //   }
                                                        // }

                                                        if (ch != null) {
                                                          ch?.write([0x1, 0x1, 0x1],
                                                              withoutResponse:
                                                              ch!.properties.writeWithoutResponse);
                                                        } else {}
                                                      }

                                                      // Update toggle state
                                                      setState(() {
                                                        isToggled = !isToggled;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ])),



                          if(grouped==true)
                            Container(
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,

                                    children: [
                                      SizedBox(
                                        width:30,
                                        height: getProportionateHeight(690.0),
                                      ),
                                      Stack(
                                        children: [
                                          Image(
                                              image: AssetImage(isToggled
                                                  ?  "assets/multiple_pop_lit.png"
                                                  : "assets/multiple_pop_off.png"),width:300,height:450),
                                          Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              mainAxisAlignment: MainAxisAlignment.center,

                                              children: [
                                                SizedBox(
                                                  height:getProportionateHeight(230),
                                                  width: getProportionateWidth(210.0),
                                                ),
                                                GestureDetector(

                                                  child: loadSVG(isToggled
                                                      ? "assets/on_button.svg"
                                                      : "assets/off_button.svg"),
                                                  onTap: () async {
                                                    if (isToggled) {
                                                      // OFF button tapped
                                                      print("Off Clicked");

                                                      print(
                                                          "Command place ------------------------------");
                                                      // if(dropDownIndex >popLightsList.length)

                                                      for (int q = 0; q < ch1.length; q++) {
                                                        ch1[q]!.write([0x1, 0x1, 0x0]);
                                                      }


                                                    } else {
                                                      // ON button tapped

                                                      print("ON Clicked");


                                                      for (int q = 0; q <ch1.length; q++) {
                                                        ch1[q]!.write(
                                                            [0x1, 0x1, 0x1]);
                                                      }
                                                    }

                                                    // Update toggle state
                                                    setState(() {
                                                      isToggled = !isToggled;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ])),




                          Padding(
                            padding: EdgeInsets.only(
                                top: getProportionateHeight(90.0),
                                bottom: getProportionateHeight(700.0)),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: DropdownButtonHideUnderline(
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black, // Border color
                                        width: 2.6, // Border thickness
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          12.0), // Optional: add border radius
                                    ),
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: Text(
                                        'Select Item',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                      ),
                                      items: tabList
                                          .map((String item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Center(
                                          child: Text(
                                            item.toUpperCase(),
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900,
                                              // Add desired font weight
                                              color: item == selectedValue
                                                  ? primaryColor
                                                  : Colors
                                                  .black, // Change color based on selection
                                            ),
                                          ),
                                        ),
                                      ))
                                          .toList(),
                                      value: selectedValue,
                                      onChanged: (String? value) {
                                        dropDownIndex = tabList.indexOf(value!);

                                        setState(() {
                                          ch = chr;
                                          ch1 = [];
                                          selectedValue = value;
                                        });
                                      },
                                      buttonStyleData: ButtonStyleData(
                                        padding:EdgeInsets.symmetric(horizontal: 16),
                                        height: 60,
                                        width: MediaQuery.of(context).size.width*0.6,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: Colors.black26,
                                            width: 2,
                                          ),
                                          color: secondaryColor,
                                        ),
                                        elevation: 2,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        width: MediaQuery.of(context).size.width*0.55,
                                        offset:Offset(MediaQuery.of(context).size.width*0.025, 0),
                                        maxHeight: MediaQuery.of(context).size.height*0.19,
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness: MaterialStateProperty.all(6),
                                          thumbVisibility: MaterialStateProperty.all(true),
                                          thumbColor: MaterialStatePropertyAll(Colors.redAccent),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black, // Border color
                                            width: 3, // Border thickness
                                          ),
                                          borderRadius:
                                          BorderRadius.only(
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(12)
                                          ),
                                          color: highlightColor,
                                        ),
                                      ),
                                      menuItemStyleData: MenuItemStyleData(
                                        height: 50,
                                        selectedMenuItemBuilder:(context, child) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.only(
                                                  bottomLeft: Radius.circular(12),
                                                  bottomRight: Radius.circular(12)
                                              ),
                                            ),
                                          );
                                        },
                                        overlayColor: MaterialStateProperty.all<Color?>(const Color.fromARGB(
                                            255, 215, 238, 3)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          //hear drop down selections ends




                          Positioned(
                            bottom: 0.0,
                            child: Container(
                              width: getProportionateWidth(390.0),
                              height: getProportionateHeight(314.0),
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/bottom_nav_screen.jpg"),
                                      fit: BoxFit.fill)),
                              child: Column(
                                children: [
                                  selectedIndex == 0
                                      ? timerUI()
                                      : selectedIndex == 1
                                      ? warmthUI()
                                      : brightnessUI(),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 0;
                                            isCustomTimer = false;
                                          });
                                        },
                                        child: selectedIndex == 0
                                            ? loadSVG("assets/timer_on.svg")
                                            : loadSVG("assets/timer_off.svg"),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 1;
                                          });
                                        },
                                        child: selectedIndex == 1
                                            ? loadSVG("assets/warmth_on.svg")
                                            : loadSVG("assets/warmth_off.svg"),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = 2;
                                          });
                                        },
                                        child: selectedIndex == 2
                                            ? loadSVG("assets/brightness_on.svg")
                                            : loadSVG("assets/brightness_off.svg"),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: getProportionateHeight(30.0),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                  }
                },
              ),
              //Overlay Screen
            ],
          ),
        ));
  }

  disconnect() async{
    for (ScanResult bluetoothDevice in foundPopLightsList) {
      print("adjust setiing disconnect");
      isConnectingOrDisconnecting[bluetoothDevice.device.remoteId] ??= ValueNotifier(true);
      isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value = true;
      const duration = Duration(days: 0, hours: 0, minutes: 0, seconds: 1,
          milliseconds: 0, microseconds: 0);
      await bluetoothDevice.device.disconnect(timeout:1).catchError((e) {
        final snackBar = snackBarFail(prettyException("Connect Error:", e));
        snackBarKeyC.currentState?.removeCurrentSnackBar();
        snackBarKeyC.currentState?.showSnackBar(snackBar);
      }).then((v) {
        isConnectingOrDisconnecting[bluetoothDevice.device.remoteId] ??= ValueNotifier(false);
        isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value = false;
      });
    }
  }

  // is_connecting(ScanResult bluetoothDevice,bool connnection)  async {
  //   isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]??= ValueNotifier(true);
  //   isConnectingOrDisconnecting[bluetoothDevice.device.remoteId]!.value = true;
  //   if(connnection==true) {
  //     await bluetoothDevice.device.connect(timeout: Duration(seconds: 35)).catchError((e) {
  //       final snackBar =
  //       snackBarFail(prettyException("Connect Error:", e));
  //       snackBarKeyC.currentState?.removeCurrentSnackBar();
  //       snackBarKeyC.currentState?.showSnackBar(snackBar);
  //     }).then((v) {
  //       isConnectingOrDisconnecting[bluetoothDevice
  //           .device.remoteId] ??= ValueNotifier(false);
  //       isConnectingOrDisconnecting[
  //       bluetoothDevice.device.remoteId]!
  //           .value = false;
  //     });
  //   } else
  //   if(connnection==false){
  //     await bluetoothDevice.device.disconnect().catchError((e) {
  //       final snackBar =
  //       snackBarFail(prettyException("Connect Error:", e));
  //       snackBarKeyC.currentState?.removeCurrentSnackBar();
  //       snackBarKeyC.currentState?.showSnackBar(snackBar);
  //     }).then((v) {
  //       isConnectingOrDisconnecting[bluetoothDevice
  //           .device.remoteId] ??= ValueNotifier(false);
  //       isConnectingOrDisconnecting[
  //       bluetoothDevice.device.remoteId]!
  //           .value = false;
  //     });
  //   }
  //   proceeddiscovery=true;
  //
  // }
  //
  //
  // void callDiscoverServices(BluetoothDevice device) async {
  //   print("in callDiscoverServices");
  //
  //   print("Device in dicovery ${device.remoteId}");
  //   service=await device.discoverServices(timeout: 15);
  //
  //   servicefound=true;
  //   print("Discovered Device ");
  //
  //
  // }
  //
  // ch_generator(PopLightModel popList)
  // {
  //   print("Ch ke andar ...");
  //
  //   for (ScanResult bluetoothDevice in discoveredBluetoothDevicesList) {
  //     print("bluetoothDevice: ${bluetoothDevice.device
  //         .remoteId} , ${bluetoothDevice.device
  //         .localName}");
  //     if (bluetoothDevice.device.remoteId.toString() ==
  //         popList.popLightId) {
  //       r=r+1;
  //       print("matched polight  ${bluetoothDevice.device.remoteId} , ${bluetoothDevice.device.localName}");
  //       //connecting to poplight
  //       is_connecting(bluetoothDevice,true);
  //       //discovering Services
  //       if(dropDownIndex!=0)
  //         if(proceeddiscovery==true){
  //           callDiscoverServices(bluetoothDevice.device);
  //         }
  //
  //       print("\n\n\nthis is id im getting in ch-generate ${popList.popLightId}\n\n\n\n");
  //
  //       //streaming services
  //       if(dropDownIndex!=0)
  //         if(servicefound==true)
  //           for (BluetoothService bs in service) {
  //             print("services we got .......${bs}");
  //             if (bs.serviceUuid.toString().toUpperCase().contains("FFB0") == true) {
  //               for (BluetoothCharacteristic bc in bs.characteristics) {
  //                 if (bc.characteristicUuid.toString().toUpperCase().contains("FFB1") == true) {
  //
  //                   if(dropDownIndex >popLightsList.length) {
  //                     if(!ch1.contains(bc)){
  //                       print("\n\n\nvharacteristics $bc\n\n\n");
  //                       ch1.add(bc);
  //                       service=[];
  //                     }
  //
  //                   } else {
  //                     ch = bc;
  //                   }
  //                 }
  //               }
  //             }
  //           }
  //       // stream(bluetoothDevice);
  //       // print('this is ch $ch');
  //       // if(ch!=Null)
  //       //
  //     }
  //
  //   }
  // }

  brightnessUI() {
    return Column(
      children: [
        SizedBox(
          height: getProportionateHeight(40.0),
        ),
        loadSVG("assets/adjust_brightnesss_text.svg"),
        SizedBox(
          height: getProportionateHeight(38.0),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: getProportionateWidth(25.0), right: getProportionateWidth(25.0)),
          child: Slider(
              value: brightnessLevel,
              max: 100,
              divisions: 5,
              thumbColor: Colors.amber,
              activeColor: secondaryColor,
              inactiveColor: secondaryColor,
              label: brightnessLevel.round().toString(),
              onChanged: (double value) {
                print("Inside slider:$value");

                print("Changed! 1");
                switch (value.toInt()) {
                  case 0:
                    if (grouped) {
                      if (ch1[0] != null) {
                        for (int q = 0; q < ch1.length; q++) {
                          ch1[q]!.write([0x1, 0x2, 0x0],
                              withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                        }
                      }
                    }

                    if (individual) if (ch != null) {
                      ch!.write([0x1, 0x2, 0x0],
                          withoutResponse: ch!.properties.writeWithoutResponse);
                    }
                    break;

                  case 20:
                    if (grouped) if (ch1[0] != null) {
                      for (int q = 0; q < ch1.length; q++) {
                        ch1[q]!.write([0x1, 0x2, 0x01],
                            withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                      }
                    }
                    if (individual) if (ch != null) {
                      ch!.write([0x1, 0x2, 0x01],
                          withoutResponse: ch!.properties.writeWithoutResponse);
                    }
                    break;
                  case 40:
                    if (grouped) if (ch1[0] != null) {
                      for (int q = 0; q < ch1.length; q++) {
                        ch1[q]!.write([0x1, 0x2, 0x05],
                            withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                      }
                    }
                    if (individual) if (ch != null) {
                      ch!.write([0x1, 0x2, 0x05],
                          withoutResponse: ch!.properties.writeWithoutResponse);
                    }
                    break;
                  case 60:
                    if (grouped) if (ch1[0] != null) {
                      for (int q = 0; q < ch1.length; q++) {
                        ch1[q]!.write([0x1, 0x2, 0x10],
                            withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                      }
                    }
                    if (individual) if (ch != null) {
                      ch!.write([0x1, 0x2, 0x10],
                          withoutResponse: ch!.properties.writeWithoutResponse);
                    }
                    break;
                  case 80:
                    if (grouped) if (ch1[0] != null) {
                      for (int q = 0; q < ch1.length; q++) {
                        ch1[q]!.write([0x1, 0x2, 0x14],
                            withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                      }
                    }
                    if (individual) if (ch != null) {
                      print("bright ness 80 %");
                      ch!.write([0x1, 0x2, 0x14],
                          withoutResponse: ch!.properties.writeWithoutResponse);
                    }
                    break;
                  case 100:
                    if (grouped) if (ch1[0] != null) {
                      for (int q = 0; q < ch1.length; q++) {
                        ch1[q]!.write([0x1, 0x2, 0x18],
                            withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                      }
                    }
                    if (individual) if (ch != null) {
                      ch!.write([0x1, 0x2, 0x18],
                          withoutResponse: ch!.properties.writeWithoutResponse);
                    }
                    break;

                  default:
                    if (grouped) if (ch1[0] != null) {
                      for (int q = 0; q < ch1.length; q++) {
                        ch1[q]!.write([0x1, 0x2, 0x01],
                            withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                      }
                    }
                    if (individual) if (ch != null) {
                      ch!.write([0x1, 0x2, 0x01],
                          withoutResponse: ch!.properties.writeWithoutResponse);
                    }
                }

                setState(() {
                  print("Changed!");

                  brightnessLevel = value;
                });
              }),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: getProportionateWidth(50.0),
              top: getProportionateHeight(10.0),
              right: getProportionateWidth(45.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              loadSVG("assets/brightness_text_black.svg"),
              Text(
                "${brightnessLevel.toString()} %",
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              )
            ],
          ),
        )
      ],
    );
  }

  warmthUI() {
    return Column(
      children: [
        SizedBox(
          height: getProportionateHeight(40.0),
        ),
        loadSVG("assets/choose_color_warmth_text.svg"),
        SizedBox(
          height: getProportionateHeight(39.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (grouped) if (ch1[0] != null) {
                  for (int q = 0; q < ch1.length; q++) {
                    ch1[q]!.write([0x1, 0x6, 0x0],
                        withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                  }
                }
                if (individual) if (ch != null) {
                  ch!.write([0x1, 0x6, 0x0], withoutResponse: ch!.properties.writeWithoutResponse);
                }

                setState(() {
                  warmthLever = 0;
                });
              },
              child: Container(
                width: getProportionateWidth(106.0),
                height: getProportionateHeight(66.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 4.0, // Spread of the shadow
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ],
                    color: warmthLever == 0 ? highlightColor : secondaryColor,
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
                child: const Center(
                  child: Text(
                    "COOL\nGLOW",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (grouped) if (ch1[0] != null) {
                  for (int q = 0; q < ch1.length; q++) {
                    ch1[q]!.write([0x1, 0x6, 0x01],
                        withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                  }
                }
                if (individual) if (ch != null) {
                  ch!.write([0x1, 0x6, 0x01], withoutResponse: ch!.properties.writeWithoutResponse);
                }

                setState(() {
                  warmthLever = 1;
                });
              },
              child: Container(
                width: getProportionateWidth(106.0),
                height: getProportionateHeight(66.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 4.0, // Spread of the shadow
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ],
                    color: warmthLever == 1 ? highlightColor : secondaryColor,
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0.0), bottomLeft: Radius.circular(0.0))),
                child: const Center(
                  child: Text(
                    "NEUTRAL\nGLOW",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (grouped) if (ch1[0] != null) {
                  for (int q = 0; q < ch1.length; q++) {
                    ch1[q]!.write([0x1, 0x6, 0x02],
                        withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                  }
                }
                if (individual) if (ch != null) {
                  ch!.write([0x1, 0x6, 0x02], withoutResponse: ch!.properties.writeWithoutResponse);
                }

                setState(() {
                  warmthLever = 2;
                });
              },
              child: Container(
                width: getProportionateWidth(106.0),
                height: getProportionateHeight(66.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 4.0, // Spread of the shadow
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ],
                    color: warmthLever == 2 ? highlightColor : secondaryColor,
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                child: const Center(
                  child: Text(
                    "WARM\nGLOW",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  int selectedHour = 1;
  int selectedMinute = 15;

  Map<int, int> minutesToBleCommand = {};

  void generateMinutesToBleCommandMap() {
    for (int minute = 15; minute <= 3840; minute += 15) {
      minutesToBleCommand[minute] = minute ~/ 15;
    }
  }

  List<DropdownMenuItem<int>> _buildHourDropdownItems() {
    return List.generate(64, (index) {
      return DropdownMenuItem<int>(
        value: index,
        child: Center(
          child: Text(
            '$index',
            style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w800),
          ),
        ),
      );
    });
  }

  Map<int, int> minutesToBleDropdown = {
    0: 0x00,
    15: 0x01,
    30: 0x02,
    45: 0x03,
  };

  List<DropdownMenuItem<int>> _buildMinuteDropdownItems() {
    return minutesToBleDropdown.keys.map((minute) {
      return DropdownMenuItem<int>(
        value: minute,
        child: Center(
          child: Text(
            '$minute',
            style: TextStyle(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w800),
          ),
        ),
      );
    }).toList();
  }

  timerUI() {
    return Column(
      children: [
        SizedBox(
          height: getProportionateHeight(40.0),
        ),
        loadSVG("assets/set_timer_text.svg"),
        SizedBox(
          height: getProportionateHeight(10.0),
        ),
        Text("(${tempch1.length})",style:TextStyle(color: Colors.white),),
        loadSVG("assets/pop_light_will_turn_off_after_text.svg"),
        SizedBox(
          height: getProportionateHeight(10.0),
        ),
        !isCustomTimer
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if (grouped) if (ch1[0] != null) {
                  for (int q = 0; q < ch1.length; q++) {
                    ch1[q]!.write([0x2, 0x3, 0x0, 0x2],
                        withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                  }
                }
                if (individual) if (ch != null) {
                  ch!.write([0x2, 0x3, 0x0, 0x2],
                      withoutResponse: ch!.properties.writeWithoutResponse);
                }
                Fluttertoast.showToast(
                    msg: "Timer set for 30 MIN.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                setState(() {
                  timerState = 0;
                });
              },
              child: Container(
                width: getProportionateWidth(106.0),
                height: getProportionateHeight(66.0),
                decoration: BoxDecoration(
                    color: timerState == 0 ? highlightColor : secondaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 4.0, // Spread of the shadow
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ],
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
                child: const Center(
                  child: Text(
                    "30 MIN",
                    style: TextStyle(
                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (grouped) if (ch1[0] != null) {
                  for (int q = 0; q < ch1.length; q++) {
                    ch1[q]!.write([0x2, 0x3, 0x0, 0x4],
                        withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                  }
                }
                if (individual) if (ch != null) {
                  ch!.write([0x2, 0x3, 0x0, 0x4],
                      withoutResponse: ch!.properties.writeWithoutResponse);
                }
                Fluttertoast.showToast(
                    msg: "Timer set for 1 Hour.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
                setState(() {
                  timerState = 1;
                });
              },
              child: Container(
                width: getProportionateWidth(106.0),
                height: getProportionateHeight(66.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 4.0, // Spread of the shadow
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ],
                    color: timerState == 1 ? highlightColor : secondaryColor,
                    border: Border.all(color: Colors.black, width: 1.0),

                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0.0), bottomLeft: Radius.circular(0.0))),
                child: const Center(
                  child: Text(
                    "1 HR",
                    style: TextStyle(
                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  timerState = 2;
                  isCustomTimer = true;
                });

                print("Is custom timer: $isCustomTimer");
              },
              child: Container(
                width: getProportionateWidth(106.0),
                height: getProportionateHeight(66.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 4.0, // Spread of the shadow
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ],
                    color: timerState == 2 ? highlightColor : secondaryColor,
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                child: const Center(
                  child: Text(
                    "CUSTOM",
                    style: TextStyle(
                        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            )
          ],
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: getProportionateWidth(212.0),
              height: getProportionateHeight(66.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      blurRadius: 4.0, // Spread of the shadow
                      offset: Offset(0, 4), // Offset of the shadow
                    ),
                  ],
                  color: timerState == 0 ? highlightColor : secondaryColor,
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0))),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    showPicker(
                      context: context,
                      value: _time,

                      duskSpanInMinutes: 250, // optional
                      onChange: onTimeChanged,
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonHideUnderline(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(12.0), // Optional: add border radius
                        ),
                        child: DropdownButton2<int>(
                          isExpanded: true,
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: _buildHourDropdownItems(),
                          value: selectedHour,
                          onChanged: (value) {
                            setState(() {
                              selectedHour = value!;
                            });
                          },
                          iconStyleData: IconStyleData(iconSize: 0.0),
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: MediaQuery.of(context).size.height * 0.075,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(0.0)),
                              color: secondaryColor,
                            ),
                            elevation: 2,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            isOverButton: true,
                            maxHeight: 320,
                            offset: const Offset(0, 320),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                              thumbColor: MaterialStatePropertyAll(Colors.redAccent),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 2, // Border thickness
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                              color: highlightColor,
                            ),
                          ),
                          alignment: Alignment.topRight,
                          menuItemStyleData: MenuItemStyleData(
                            height: 60,
                            overlayColor: MaterialStateProperty.all<Color?>(Colors.blue[80]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.075,
                      width: MediaQuery.of(context).size.width * 0.025,
                      decoration: BoxDecoration(
                          color: timerState == 1 ? highlightColor : secondaryColor,
                          // border: Border.all(color: Colors.black, width: 2.0),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              bottomLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                              bottomRight: Radius.circular(0.0))),
                      child: const Center(
                        child: Text(
                          ":",
                          style: TextStyle(
                              color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(12.0), // Optional: add border radius
                        ),
                        child: DropdownButton2<int>(
                          isExpanded: true,
                          iconStyleData: IconStyleData(iconSize: 0.0),
                          hint: Center(
                            child: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: _buildMinuteDropdownItems(),
                          value: selectedMinute,
                          onChanged: (value) {
                            setState(() {
                              selectedMinute = value!;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: MediaQuery.of(context).size.height * 0.075,
                            width: MediaQuery.of(context).size.width * 0.25,
                            elevation: 2,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            offset: const Offset(0, 315),
                            direction: DropdownDirection.textDirection,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black, // Border color
                                width: 2, // Border thickness
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                              color: highlightColor,
                            ),
                          ),
                          alignment: Alignment.topRight,
                          menuItemStyleData: MenuItemStyleData(
                            height: 60,
                            overlayColor: MaterialStateProperty.all<Color?>(Colors.blue[80]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                int totalMinutes = (selectedHour * 60) + selectedMinute;
                int? selectedBleCommand = minutesToBleCommand[totalMinutes];
                // generateMinutesToBleCommandMap();
                // List<int> cmd = [0x2,0x3,0x0];
                // cmd.add(selectedBleCommand!);
                // print("Command: $cmd");
                // print("\n\n\n\n-----all minute to ble .......");
                // print(minutesToBleCommand);

                print(totalMinutes);
                // print(selectedBleCommand);

                // Now you can use 'totalMinutes' and 'selectedBleCommand'
                // to send the appropriate BLE command to the device

                if (selectedBleCommand != null) {
                  int hexCommand =
                  int.parse('0x' + selectedBleCommand.toRadixString(16).toUpperCase());
                  print("\n\n\n\n\n\nThis is hex command");
                  print(hexCommand);
                  print("\n\n\n\n\n\n");
                  List<int> cmd = [0x2, 0x3, 0x0];
                  cmd.add(selectedBleCommand);
                  print("Command: $cmd");
                  if (grouped) if (ch1[0] != null) {
                    for (int q = 0; q < ch1.length; q++) {
                      ch1[q]!.write(cmd,
                          withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                    }
                  }
                  if (individual) if (ch != null) {
                    ch!.write(cmd, withoutResponse: ch!.properties.writeWithoutResponse);
                  }
                  setState(() {
                    timerState = 2;
                  });
                  Fluttertoast.showToast(
                      msg: "Timer set for: " +
                          selectedHour.toString() +
                          " : " +
                          selectedMinute.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  // Send BLE command here using flutter_blue
                  // Make sure you have proper Bluetooth permissions and device connection logic
                } else {
                  Fluttertoast.showToast(
                      msg: "Timer cannot be set for: " +
                          selectedHour.toString() +
                          " : " +
                          selectedMinute.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                if (_time.minute == 15) {
                  if (grouped) if (ch1[0] != null) {
                    for (int q = 0; q < ch1.length; q++) {
                      ch1[q]!.write([0x2, 0x3, 0x0, 0x1],
                          withoutResponse: ch1[q]!.properties.writeWithoutResponse);
                    }
                  }
                  if (individual) if (ch != null) {
                    ch!.write([0x2, 0x3, 0x0, 0x1],
                        withoutResponse: ch!.properties.writeWithoutResponse);
                  }
                  Fluttertoast.showToast(
                      msg: "Timer set for 15 MIN.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }

                setState(() {
                  timerState = 2;
                });
              },
              child: Container(
                width: getProportionateWidth(106.0),
                height: getProportionateHeight(66.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 4.0, // Spread of the shadow
                        offset: Offset(0, 4), // Offset of the shadow
                      ),
                    ],
                    color: highlightColor,
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0))),
                child: const Center(
                  child: Text(
                    "SET",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Time _time = Time(hour: 00, minute: 30, second: 20);
  bool iosStyle = true;

  void onTimeChanged(Time newTime) {
    setState(() {
      _time = newTime;
    });
  }

  SnackBar snackBarGood(String message) {
    return SnackBar(content: Text(message), backgroundColor: Colors.blue);
  }

  SnackBar snackBarFail(String message) {
    return SnackBar(content: Text(message), backgroundColor: Colors.red);
  }

  String prettyException(String prefix, dynamic e) {
    if (e is FlutterBluePlusException) {
      return "$prefix ${e.description}";
    } else if (e is PlatformException) {
      return "$prefix ${e.message}";
    }
    return prefix + e.toString();
  }
}



// BluetoothCharacteristic _extract_char(BuildContext context, List<BluetoothService> services) {
//   print("Insde extract char");
//   late BluetoothCharacteristic bchar;
//   for (BluetoothService bs in services) {
//     if (bs.serviceUuid.toString().toUpperCase().contains("FFB0") == true) {
//       for (BluetoothCharacteristic bc in bs.characteristics) {
//         if (bc.characteristicUuid.toString().toUpperCase().contains("FFB1") == true) {
//           bchar = bc;
//         }
//       }
//     }
//   }
//   return bchar;
//
// }