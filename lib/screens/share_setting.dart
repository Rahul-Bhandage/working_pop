
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/modals/group_model.dart';
import 'package:pop_lights_app/screens/delete_group.dart';
import 'package:pop_lights_app/screens/user_account.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import '../utilities/app_colors.dart';
import '../utilities/app_utils.dart';
import '../utilities/size_config.dart';
import 'user_account_tabviews/rename_pop_light.dart';

class ShareSetting extends StatefulWidget {

  static String routeName = "screens/share_setting.dart";

  const ShareSetting({super.key});

  @override
  State<ShareSetting> createState() => _ShareSettingState();
}

class _ShareSettingState extends State<ShareSetting> {

  @override
  Widget build(BuildContext context) {
    final Args = (ModalRoute
        .of(context)!
        .settings
        .arguments ?? <int, List<ScanResult>>{}) as Map;

    int groupId = Args['id'];
    List<ScanResult> discoveredBluetoothDevicesList = Args["disclist"];
    print("POP IN MORE $groupId");
    print("Discovered ...............: $discoveredBluetoothDevicesList");

    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context,GroupTabView.routeName,arguments: discoveredBluetoothDevicesList).then((value) =>setState((){}));

          return true;
        },

        child:Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () =>  Navigator.pushNamed(context, UserAccount.routeName,
                    arguments:  {"popid":0,"disclist":discoveredBluetoothDevicesList}),
                child: Container(

                    height: getProportionateHeight(21.0),
                    width: getProportionateWidth(21.0),

                    decoration: const BoxDecoration(

                        image: DecorationImage(image: AssetImage("assets/back_eclipse.png"), fit: BoxFit.none)

                    ),

                    child: Center(child: loadSVG("assets/back_arrow.svg"),)

                ),
              ),
              title: Text("MAKE A SELECTION", style: TextStyle(color: secondaryColor, fontSize: getProportionateHeight(20.0), fontWeight: FontWeight.w600),),
              centerTitle: true,
            ),

            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg_img.jpg"),
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),

              ),
              child:ListView(

                children: [

                  GestureDetector(
                    onTap: ()  { Navigator.pushNamed(context, UserAccount.routeName,
                              arguments:  {"popid":0,"disclist":discoveredBluetoothDevicesList});
                              Fluttertoast.showToast(
                              msg: "This Feature is Under Testing",
                              toastLength: Toast
                                  .LENGTH_SHORT,
                              gravity: ToastGravity
                                  .BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors
                                  .red,
                              textColor: Colors
                                  .white,
                              fontSize: 16.0);
                            },
                    child: Padding(
                    padding: EdgeInsets.only(left: getProportionateWidth(62.0), top: getProportionateHeight(240.0), right: getProportionateWidth(65.0)),
                    child: Image.asset("assets/message.png"),
                  ),
                  ),

                  GestureDetector(
                    onTap: (){  Navigator.pushNamed(context, UserAccount.routeName,
                        arguments:  {"popid":0,"disclist":discoveredBluetoothDevicesList});
                    Fluttertoast.showToast(
                        msg: "This Feature is Under Testing",
                        toastLength: Toast
                            .LENGTH_SHORT,
                        gravity: ToastGravity
                            .BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors
                            .red,
                        textColor: Colors
                            .white,
                        fontSize: 16.0);
                    },

                      child: Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(62.0), top: getProportionateHeight(12.0), right: getProportionateWidth(62.0)),
                      child: Image.asset("assets/copy_link.png"),
                    ),
                  ),

                  GestureDetector(

                    onTap: () {

                      Navigator.pushNamed(context, UserAccount.routeName,
                          arguments:  {"popid":0,"disclist":discoveredBluetoothDevicesList});
                        Fluttertoast.showToast(
                          msg: "This Feature is Under Testing",
                          toastLength: Toast
                              .LENGTH_SHORT,
                          gravity: ToastGravity
                              .BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors
                              .red,
                          textColor: Colors
                              .white,
                          fontSize: 16.0);

                    },

                    child: Padding(
                      padding: EdgeInsets.only(left: getProportionateWidth(62.0), top: getProportionateHeight(12.0), right: getProportionateWidth(62.0)),
                      child: Image.asset("assets/air_drop.png"),
                    ),
                  ),

                ],
              ),
            )
        ));
  }
}
