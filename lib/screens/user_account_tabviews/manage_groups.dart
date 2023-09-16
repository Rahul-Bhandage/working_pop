import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pop_lights_app/screens/share_setting.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/pop_light_more.dart';

import '../../modals/group_model.dart';
import '../../modals/pop_lights_model.dart';
import '../../modals/poplightColorList.dart';
import '../../utilities/app_colors.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/database_helper.dart';
import '../../utilities/size_config.dart';
import '../rename_delete_create_group.dart';

class ManageGroups extends StatefulWidget {
  static String routeName = "screens/user_account_tabview/manage_groups";
  List<ScanResult> BluetoothDevicesList = [];
  ManageGroups({Key? key, required this.BluetoothDevicesList}) : super(key: key);

  @override
  State<ManageGroups> createState() => _ManageGroupsState();
}

class _ManageGroupsState extends State<ManageGroups> {
  List<GroupModel> tabTitlesList = [];
  List<GroupModel>tabTitlesListtemp =[];
  List<PopLightModel> addedList = [];
  List<PopLightModel> popList = [];
  List<ScanResult> discoveredBluetoothDevicesList = [];
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    discoveredBluetoothDevicesList = widget.BluetoothDevicesList;
    print("\n\n\n\n\n\n\n\n-----inside my pop lights ----------------");
    print(discoveredBluetoothDevicesList);
    print("\n\n\n\n\n\n\n\n");
    setState(() {});
    return FutureBuilder<List<GroupModel>?>(
      future: DatabaseHelper.getAllGroups(),
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

            tabTitlesListtemp = snapshot.data!;

            return FutureBuilder<List<PopLightModel>?>(
                future: DatabaseHelper.getAllPopLights(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container();

                    case ConnectionState.waiting:
                      return Container();

                    case ConnectionState.active:
                      return Container();

                    case ConnectionState.done:
                      if (addedList.isEmpty) {
                        addedList = snapshot.data!;
                        popList = snapshot.data!;
                      }
                      for(int index=0 ; index<popList.length ;index++)
                      {
                      for(int index1=0 ; index1<tabTitlesListtemp.length ;index1++){

                          print("group name of temp ${tabTitlesListtemp[index1].groupName} ${tabTitlesListtemp[index1].groupId}");
                          print("group name of temp ${popList[index].groupId}");
                          if(popList[index].groupId>0) {
                            if (popList[index].groupId ==tabTitlesListtemp[index1].groupId && !tabTitlesList.contains(
                                    tabTitlesListtemp[index1]))
                              {
                              tabTitlesList.add(tabTitlesListtemp[index1]);
                                }
                          }
                        }}

                      return DefaultTabController(
                          length: tabTitlesList.length,
                          child: Builder(builder: (BuildContext context) {
                            final TabController controller = DefaultTabController.of(context);
                            controller.addListener(() {
                              if (controller.indexIsChanging) {
                                print(controller.index);
                                tabIndex = controller.index;
                              }
                            });

                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: getProportionateHeight(20.0)),
                                    child: SizedBox(
                                      width: getProportionateWidth(
                                          MediaQuery.of(context).size.width / 0.5),
                                      height: getProportionateHeight(44.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: getProportionateWidth(
                                                MediaQuery.of(context).size.width / 1.4),
                                            height: getProportionateHeight(44.0),
                                            child: Container(

                                              // decoration: BoxDecoration(
                                              //     boxShadow: [
                                              //       BoxShadow(
                                              //         color: Colors.black
                                              //             .withOpacity(0.2), // Shadow color
                                              //         blurRadius: 6.0, // Spread of the shadow
                                              //         offset:
                                              //         Offset(1, 0), // Offset of the shadow
                                              //       ),
                                              //     ]
                                              // ),
                                              child: Center(
                                                child: ButtonsTabBar(
                                                  radius: 10.0,
                                                  buttonMargin: EdgeInsets.only(
                                                      right: getProportionateWidth(16.0)),
                                                  backgroundColor: highlightColor,
                                                  unselectedBackgroundColor: secondaryColor,
                                                  borderWidth: 2.0,
                                                  contentPadding: EdgeInsets.only(
                                                      left: getProportionateWidth(18.0),
                                                      right: getProportionateWidth(12.0)),
                                                  borderColor: Colors.black,
                                                  labelStyle: const TextStyle(
                                                    color: bntColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  unselectedLabelStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  tabs: List.generate(
                                                    tabTitlesList.length,
                                                    (index) => Tab(
                                                      text:
                                                          tabTitlesList[index].groupName.toUpperCase(),
                                                    ),
                                                  ),
                                                ),
                                              ),


                                            ),
                                          ),
                                          SizedBox(
                                            width: getProportionateWidth(1.0),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context, ShareSetting.routeName, arguments: {
                                                "id": tabTitlesList[tabIndex].groupId,
                                                "disclist": discoveredBluetoothDevicesList
                                              });
                                            },
                                            child:loadSVG("assets/plus_small.svg"),

                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                        children: List.generate(
                                            tabTitlesList.length, (index) => tabTarView(index))),
                                  ),
                                ],
                              ),
                            );
                          }));
                  }
                });
        }
      },
    );
  }

  tabTarView(int groupIndex) {
    for (PopLightModel model in addedList) {
      print("model.groupId: ${model.groupId}");
    }

    return ListView(
      children: [
        Container(
            height: getProportionateHeight(493.0),
            padding: EdgeInsets.fromLTRB(getProportionateWidth(31.0), getProportionateHeight(20),
                getProportionateWidth(31.0), getProportionateHeight(20.0)),
            child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: getProportionateWidth(12.0),
                mainAxisSpacing: getProportionateHeight(12.0),
                childAspectRatio: getProportionateWidth(150.0) / getProportionateHeight(200.0),
                children: List.generate(
                    addedList.length,
                    (index) => GestureDetector(
                          onTap: () {
                            print("Index: $index");
                          },
                          child: popList[index].groupId <= 0
                                ?  DottedBorder(
                            borderPadding: EdgeInsets.zero,
                            padding: EdgeInsets.all(0.5),
                            color: Colors.black,
                            strokeWidth: 2.5,
                            dashPattern: const [3, 2],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(20),
                            child: Container(
                              height: getProportionateHeight(225.0),
                              width: getProportionateWidth(165.0),
                              decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        // pop light off image
                                        SizedBox(
                                          height: getProportionateHeight(148.0),
                                          width: getProportionateWidth(122.0),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 22,
                                                top: 5), // Set your desired left padding
                                            child: Center(
                                              child: Image.asset(addedList[index].colorid),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: getProportionateHeight(1.0),
                                        ),

                                        // Poplight name
                                        Container(
                                          width:MediaQuery.of(context).size.width*0.5,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                27), // Set your desired left padding


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
                                                  fontSize: getProportionateHeight(14.0),
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
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                      Navigator.pushReplacementNamed(
                                          context, PopLightMore.routeName,
                                          arguments:  {"popid":addedList[index].popLightId,"disclist":discoveredBluetoothDevicesList});
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: getProportionateHeight(15.0),
                                        right:getProportionateHeight(6.0),
                                      ),
                                      child: loadSVG("assets/pop_light_more.svg"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )

                              :  Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.0),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.9,
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

                          )
                        ))))
      ],
    );
  }
}
