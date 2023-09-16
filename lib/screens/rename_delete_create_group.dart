import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/modals/group_model.dart';
import 'package:pop_lights_app/screens/delete_group.dart';
import 'package:pop_lights_app/utilities/database_helper.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import '../utilities/app_colors.dart';
import '../utilities/app_utils.dart';
import '../utilities/size_config.dart';
import 'user_account_tabviews/rename_pop_light.dart';

class RenameDeleteCreateGroup extends StatefulWidget {
  static String routeName = "screens/rename_delete_create_group";

  const RenameDeleteCreateGroup({super.key});

  @override
  State<RenameDeleteCreateGroup> createState() => _RenameDeleteCreateGroupState();
}

class _RenameDeleteCreateGroupState extends State<RenameDeleteCreateGroup> {
  @override
  Widget build(BuildContext context) {
    final Args = (ModalRoute.of(context)!.settings.arguments ?? <int, List<ScanResult>>{}) as Map;

    int groupId = Args['id'];
    List<ScanResult> discoveredBluetoothDevicesList = Args["disclist"];
    print("POP IN MORE $groupId");
    print("Discovered ...............: $discoveredBluetoothDevicesList");

    return WillPopScope(
        onWillPop: () async {
      Navigator.pushReplacementNamed(context, GroupTabView.routeName,
                  arguments: discoveredBluetoothDevicesList)
              .then((value) => setState(() {}));

          return true;
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: primaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pushReplacementNamed(context, GroupTabView.routeName,
                        arguments: discoveredBluetoothDevicesList)
                    .then((value) => setState(() {})),
                child: Container(
                    height: getProportionateHeight(21.0),
                    width: getProportionateWidth(21.0),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/back_eclipse.png"), fit: BoxFit.none)),
                    child: Center(
                      child: loadSVG("assets/back_arrow.svg"),
                    )),
              ),
              title: Text(
                "MAKE A SELECTION",
                style: TextStyle(
                    color: secondaryColor,
                    fontSize: getProportionateHeight(20.0),
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/bg_img.jpg"),
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
              child: ListView(
                children: [
                  Container(

                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RenamePopLight.routeName, arguments: {
                        "popid": "Group\t$groupId",
                        "diclist": discoveredBluetoothDevicesList
                      }),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: getProportionateWidth(62.0),
                            top: getProportionateHeight(240.0),
                            right: getProportionateWidth(65.0)),
                        child: Container(
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
                          child: loadSVG("assets/rename_group_button.svg"),),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, DeleteGroup.routeName, arguments: {
                      "id": groupId.toString(),
                      "disclist": discoveredBluetoothDevicesList
                    }),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateWidth(62.0),
                          top: getProportionateHeight(12.0),
                          right: getProportionateWidth(62.0)),
                      child: Container(
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
    child: loadSVG("assets/delete_group_button.svg"),),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      DatabaseHelper.getAllGroups().then((value) {
                        DatabaseHelper.addGroup(GroupModel(
                                groupId: value!.length + 1,
                                groupName: "Group ${value!.length + 1}",
                                isDeletable: 1))
                            .then((value) {});
                      });
                      Navigator.pushReplacementNamed(context, GroupTabView.routeName,
                              arguments: discoveredBluetoothDevicesList)
                          .then((value) => setState(() {}));
                      Fluttertoast.showToast(
                          msg: "Successfully created Group",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: getProportionateWidth(62.0),
                          top: getProportionateHeight(12.0),
                          right: getProportionateWidth(62.0)),
                      child:  Container(
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
    child:loadSVG("assets/create_new_group_button.svg"),),
                    ),
                  ),
                ],
              ),
            )));
  }
}
