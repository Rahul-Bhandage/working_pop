
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/pop_light_more.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/select_another.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

import '../modals/group_model.dart';
import '../modals/pop_lights_model.dart';
import '../utilities/database_helper.dart';

class Groupview extends StatefulWidget {
  static String routeName = "screens/Group_view";
  List<GroupModel> tabTitlesList = [];
  List<PopLightModel> addedList = [];
  List<bool> isAdded = [];
  Map<bool, PopLightModel> chosenPopLight = {};
  List<ScanResult> discoveredBluetoothDevicesList = [];
  Map<GroupModel, List<PopLightModel>> syncedLightsMap = {};
  bool _alreadygroupedID=false;
  int tabIndex = 0;
  int groupIndex=0;
  Groupview(  {Key? key, required this.groupIndex,required this.addedList,required this.tabTitlesList,required this.discoveredBluetoothDevicesList}) : super(key: key);
  int id=0;


  @override
  State<Groupview> createState() => _Groupview();
}

class _Groupview extends State<Groupview> {
  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
        isScrollControlled: true,
      builder: (BuildContext context) {

          return select_another();// Remove padding

      },
    );
  }



  @override
  Widget build(BuildContext context) {
    List<GroupModel> tabTitlesList = widget.tabTitlesList;
    List<PopLightModel> addedList = widget.addedList;
    int groupIndex=widget.groupIndex;
    List<PopLightModel>? popList = [];

    List<ScanResult> discoveredBluetoothDevicesList =widget.discoveredBluetoothDevicesList;
    print("lrngth of list ${addedList.length}");
    print("In group view");



    return FutureBuilder<List<PopLightModel>?>(
        future: DatabaseHelper.getAllPopLights(),
    builder: (context, snapshot) {

    switch(snapshot.connectionState) {

    case ConnectionState.none:

    return Container();

    case ConnectionState.waiting:

    return Container();

    case ConnectionState.active:

    return Container();

    case ConnectionState.done:
      popList=snapshot!.data;

      return Column(
    children: [

      Container(

        height: getProportionateHeight(473.0),
        padding: EdgeInsets.fromLTRB(
            getProportionateWidth(29.0), getProportionateHeight(20),
            getProportionateWidth(31.0), getProportionateHeight(20.0)),

        child: GridView.count(

            crossAxisCount: 2,
            crossAxisSpacing: getProportionateWidth(16.0),
            mainAxisSpacing: getProportionateHeight(26.0),
            childAspectRatio: getProportionateWidth(150.0) /
                getProportionateHeight(200.0),
            padding: const EdgeInsets.all(0.0),

            children: List.generate(addedList.length, (index) =>
                GestureDetector(

                  onTap: () async {
// Stop scanning
                  print("lrngth of list ${addedList.length}");

                    print("Index: $index");

                    if (addedList[index].groupId < 1) {
                      print(
                          "less 1 before addedList[index].groupId: ${addedList[index]
                              .groupId}");
                      setState(() {
                        addedList[index].groupId =
                            tabTitlesList[groupIndex].groupId;
                      });
                      print(
                          "less 1 after addedList[index].groupId: ${addedList[index]
                              .groupId}");
                      setState(() {
                        groupIndex = addedList[index].groupId;
                      });

                    }

                    else {
                      if (addedList[index].groupId ==
                          tabTitlesList[groupIndex].groupId) {
                        await DatabaseHelper.getAllPopLights().then((value) {
                          print("Inside tap controller ");

                          for (PopLightModel model in value!) {
                            print("Inside model loop controller ");
                            print('${model.popLightId} and ${model.groupId}');
                            print('${addedList[index]
                                .popLightId} and  ${addedList[index]
                                .groupId} ');
                            if (model.popLightId ==
                                addedList[index].popLightId) {
                              if (((addedList[index].groupId == 1) ||
                                  (addedList[index].groupId > 1)) &&
                                  (model.groupId ==
                                      addedList[index].groupId)) {
                                continue;
                              }
                              else {
                                print("Unselected");
                                setState(() {
                                  addedList[index].groupId = 0;
                                });
                              }
                            }
                          }
                        });
                      }
                      else {
                        _openBottomSheet(context);
                        Fluttertoast.showToast(
                            msg: "Poplight already selected in another Group  ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    }
                  },

                  child: popList![index].groupId<=0?

                  DottedBorder(
                    borderPadding: EdgeInsets.all(1),
                    padding: EdgeInsets.all(0.5),
                    color: Colors.black,
                    strokeWidth: 2.0,
                    dashPattern: const [3, 2],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(20),
                    child: Container(
                      height: getProportionateHeight(225.0),
                      width: getProportionateWidth(165.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: addedList[index].groupId ==
                            tabTitlesList[groupIndex].groupId
                            ? highlightColor
                            : secondaryColor,
                      ),
                      child: FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                // pop light off image
                                SizedBox(
                                  height: getProportionateHeight(148.0),
                                  width: getProportionateWidth(122.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 22, top: 5),
                                    // Set your desired left padding
                                    child: Center(
                                      child: Image.asset(
                                          addedList[index].colorid),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: getProportionateHeight(10.0),
                                ),

                                // Poplight name
                                Container(
                                  width: getProportionateWidth(120.0),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(left: 27),
                                    // Set your desired left padding
                                    child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        addedList[index]
                                            .popLightName
                                            .toUpperCase(),
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: getProportionateHeight(
                                              14.0),
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: getProportionateHeight(8.0),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, PopLightMore.routeName,
                                    arguments: {
                                      "popid": addedList[index].popLightId,
                                      "disclist": discoveredBluetoothDevicesList
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: getProportionateHeight(5.0),
                                  right: getProportionateHeight(6.0),

                                ),
                                child: addedList[index].groupId ==
                                    tabTitlesList[groupIndex].groupId
                                    ? loadSVG(
                                    "assets/pop_light_more_black.svg")
                                    : loadSVG("assets/pop_light_more.svg"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ) :
                  popList![index].groupId>0?
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: Container(
                      height: getProportionateHeight(225.0),
                      width: getProportionateWidth(165.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: addedList[index].groupId ==
                            tabTitlesList[groupIndex].groupId
                            ? highlightColor
                            : secondaryColor,
                      ),
                      child: FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                // pop light off image
                                SizedBox(
                                  height: getProportionateHeight(148.0),
                                  width: getProportionateWidth(122.0),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 22, top: 5),
                                    // Set your desired left padding
                                    child: Center(
                                      child: Image.asset(
                                          addedList[index].colorid),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: getProportionateHeight(10.0),
                                ),

                                // Poplight name
                                Container(
                                  width: getProportionateWidth(120.0),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.only(left: 27),
                                    // Set your desired left padding
                                    child: Center(
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        addedList[index]
                                            .popLightName
                                            .toUpperCase(),
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: getProportionateHeight(
                                              14.0),
                                          fontWeight: FontWeight.w500,

                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: getProportionateHeight(8.0),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, PopLightMore.routeName,
                                    arguments: {
                                      "popid": addedList[index].popLightId,
                                      "disclist": discoveredBluetoothDevicesList
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: getProportionateHeight(5.0),
                                  right: getProportionateHeight(6.0),

                                ),
                                child: addedList[index].groupId ==
                                    tabTitlesList[groupIndex].groupId
                                    ? loadSVG(
                                    "assets/pop_light_more_black.svg")
                                    : loadSVG("assets/pop_light_more.svg"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  ):Row(),

                ),)
        ),
      ),

      GestureDetector(

        onTap: () async {
          print(addedList);
          for (PopLightModel model in addedList) {
            print(model.groupId);
            if (model.groupId == tabTitlesList[groupIndex].groupId) {
              model.groupId = tabTitlesList[groupIndex].groupId;
              await DatabaseHelper.updatePopLight(model);
            }
          }

          DatabaseHelper.getAllPopLights().then((updatedPopLights) {
            addedList = updatedPopLights!;
          });

          print("addedList: ${addedList.first.groupId}");

          Fluttertoast.showToast(
              msg: "Successfully Grouped...",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          setState(() {

          });
        },

        child: Container(

          width: double.infinity,
          height: getProportionateHeight(57.0),
          margin: EdgeInsets.only(left: getProportionateWidth(146.0),
              right: getProportionateWidth(146.0)),
          decoration: BoxDecoration(
              color: secondaryColor,
              border: Border.all(color: Colors.black, width: 1.0),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Shadow color
                  blurRadius: 4.0, // Spread of the shadow
                  offset: Offset(0, 4), // Offset of the shadow
                ),
              ],



              borderRadius: const BorderRadius.all(Radius.circular(12.0))
          ),
          child: const Center(child: Text("GROUP", style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600),)),

        ),
      ),
  ],
  );
    }
    });


}









}
