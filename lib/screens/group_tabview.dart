import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pop_lights_app/modals/selected_status.dart';
import 'package:pop_lights_app/screens/rename_delete_create_group.dart';
import 'package:pop_lights_app/screens/user_account.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/manage_groups.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/pop_light_more.dart';
import 'package:pop_lights_app/utilities/app_colors.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

import '../modals/group_model.dart';
import '../modals/pop_lights_model.dart';
import '../modals/poplightColorList.dart';
import '../utilities/database_helper.dart';
import 'Group_view.dart';

class GroupTabView extends StatefulWidget {

  static String routeName = "screens/group_tabview";

  const GroupTabView({Key? key}) : super(key: key);

  @override
  State<GroupTabView> createState() => _GroupTabViewState();
}

class _GroupTabViewState extends State<GroupTabView> {

  List<GroupModel> tabTitlesList = [];
  List<PopLightModel> addedList = [];
  List<PopLightModel> popList = [];
  List<ScanResult> discoveredBluetoothDevicesList = [];
  List<bool> isAdded = [];
  Map<bool, PopLightModel> chosenPopLight = {};
  Map<GroupModel, List<PopLightModel>> syncedLightsMap = {};
  bool _alreadygroupedID=false;
  int tabIndex = 0;

  updateGroups() {

    DatabaseHelper.getAllGroups().then((value) {

      for (GroupModel groupModel in value!) {

        tabTitlesList.add(groupModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    discoveredBluetoothDevicesList = ModalRoute.of(context)!.settings.arguments as List<ScanResult>;
    // print(discoveredBluetoothDevicesList);


    return WillPopScope(
        onWillPop: () async {
      Navigator.pushReplacementNamed(context, UserAccount.routeName,
          arguments:  {"popid":3,"disclist":discoveredBluetoothDevicesList});
      return true;
    },
    child:Scaffold(

      backgroundColor: secondaryColor,
      appBar: AppBar(

        backgroundColor: cream,
        elevation: 0,
        // leading: GestureDetector(
        //   onTap: () =>   Navigator.pushNamed(context, UserAccount.routeName,
        //       arguments:  {"popid":0,"disclist":discoveredBluetoothDevicesList}).then((value) => setState((){})),
        //
        //     child: Container(
        //
        //       height: getProportionateHeight(21.0),
        //       width: getProportionateWidth(21.0),
        //
        //       decoration: const BoxDecoration(
        //
        //           image: DecorationImage(image: AssetImage("assets/back_eclipse.png"), fit: BoxFit.none)
        //
        //       ),
        //
        //       child: Center(child: loadSVG("assets/back_arrow.svg"),)
        //
        //   ),
        // ),

        title: Text("", style: TextStyle(color: primaryColor, fontSize: getProportionateHeight(20.0), fontWeight: FontWeight.w600),),

        centerTitle: true,
      ),

      body: FutureBuilder<List<GroupModel>?>(
        future: DatabaseHelper.getAllGroups(),
        builder: (context, snapshot) {

          switch(snapshot.connectionState) {

            case ConnectionState.none:

              return const Center(child: CircularProgressIndicator(),);

            case ConnectionState.waiting:

              return const Center(child: CircularProgressIndicator(),);

            case ConnectionState.active:

              return const Center(child: CircularProgressIndicator(),);

            case ConnectionState.done:

              tabTitlesList = snapshot.data!;

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

                        if (addedList.isEmpty) {

                          addedList = snapshot.data!;
                          popList=snapshot.data!;
                        }

                        return DefaultTabController(
                            length: tabTitlesList.length,
                            child: Builder(
                                builder: (BuildContext context) {
                                  final TabController controller = DefaultTabController.of(context);
                                  controller.addListener(() {
                                    if (controller.indexIsChanging) {

                                      print(controller.index);
                                      tabIndex = controller.index;

                                    }
                                  });


                          return Scaffold(
                            backgroundColor: cream,
                            body:Container(
                              // decoration: BoxDecoration(
                              //   image: DecorationImage(
                              //     image: AssetImage("assets/bg_img.png"),
                              //     fit: BoxFit.cover, // Adjust the fit as needed
                              //   ),
                              //
                              // ),
                              child:Column(


                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Center(
                                    child: Text("CREATE POPLIGHT \n GROUP", style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Work Sans",
                                  fontSize: getProportionateHeight(20.0),),
                                  textAlign: TextAlign.center,)),

                                SizedBox(height: getProportionateHeight(8.0),),

                                Center(child: Text(
                                  "Select the Poplights you want to control together \n and give the group a name, or skip below.",
                                  style: TextStyle(color: bntColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: getProportionateHeight(14.0),),
                                  textAlign: TextAlign.center,)),

                                SizedBox(height: getProportionateHeight(20.0),),

                                Padding(

                                  padding: EdgeInsets.only(left: getProportionateWidth(35.0),
                                      right: getProportionateWidth(15.0)),

                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [

                                      SizedBox(

                                        width: getProportionateWidth(MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.4),
                                        height: getProportionateHeight(44.0),
                                        child: ButtonsTabBar(
                                          radius: 10.0,
                                          buttonMargin: EdgeInsets.only(
                                              right: getProportionateWidth(16.0)),
                                          backgroundColor: bntColor,
                                          unselectedBackgroundColor: secondaryColor,
                                          borderWidth: 1.0,
                                          contentPadding: EdgeInsets.only(
                                              left: getProportionateWidth(12.0),
                                              right: getProportionateWidth(12.0)),
                                          borderColor: Colors.black,
                                          labelStyle: const TextStyle(
                                            color: highlightColor, fontWeight: FontWeight.w600,),
                                          unselectedLabelStyle: const TextStyle(
                                            color: Colors.black, fontWeight: FontWeight.w600,),
                                          tabs: List.generate(tabTitlesList.length, (index) =>

                                              Tab(text: tabTitlesList[index].groupName.toUpperCase(),),),

                                        ),
                                      ),


                                      SizedBox(width: getProportionateWidth(10.0),),

                                      GestureDetector(

                                        onTap: () {
                                          Navigator.pushReplacementNamed(context, RenameDeleteCreateGroup.routeName,   arguments:  {"id":tabTitlesList[tabIndex].groupId,"disclist":discoveredBluetoothDevicesList});
                                        },

                                        child: loadSVG("assets/plus_small.svg"),
                                      ),
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: TabBarView(
                                      children: List.generate(tabTitlesList.length, (index) => tabTarView(index))

                                  ),
                                ),





                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              Navigator.pushReplacementNamed(
                                                  context, UserAccount.routeName,
                                                  arguments: {
                                                    "popid": 0,
                                                    "disclist": discoveredBluetoothDevicesList
                                                  });
                                            },
                                            child: Text("Home", style: TextStyle(color: Colors.black,
                                              fontSize: getProportionateHeight(16.0),
                                              fontWeight: FontWeight.w500,
                                              decoration: TextDecoration.underline,),)
                                        ),
                                      ],
                                    )),
                                SizedBox(height: getProportionateHeight(20.0),),
                              ],
                              ),),
                          );

                                })
                        );
                    }

                  });
          }
        },
      ),
    ));
  }

  tabTarView(int groupIndex){
   return  Groupview(groupIndex: groupIndex, addedList: addedList, tabTitlesList:tabTitlesList, discoveredBluetoothDevicesList:discoveredBluetoothDevicesList);
  }
  tabTaView(int groupIndex) {

    return ListView(

      children: [

        Container(

          height: getProportionateHeight(493.0),
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

                        _alreadygroupedID = false;
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

                    child: popList[index].groupId <= 0 ? DottedBorder(
                      borderPadding: EdgeInsets.zero,
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
                        popList[index].groupId>0?
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

                    ) :
                     Row(),


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


        // SizedBox(height: getProportionateHeight(20.0),),
        //
        // Align(
        //     alignment: Alignment.bottomCenter,
        //     child: Column(
        //       children: [
        //         GestureDetector(
        //             onTap: () async {
        //               Navigator.pushReplacementNamed(
        //                   context, UserAccount.routeName,
        //                   arguments: {
        //                     "popid": 0,
        //                     "disclist": discoveredBluetoothDevicesList
        //                   });
        //             },
        //             child: Text("Home", style: TextStyle(color: Colors.black,
        //               fontSize: getProportionateHeight(16.0),
        //               fontWeight: FontWeight.w500,
        //               decoration: TextDecoration.underline,),)
        //         ),
        //       ],
        //     )),

      ],
    );
  }

}
