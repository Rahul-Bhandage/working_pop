import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pop_lights_app/screens/group_tabview.dart';
import 'package:pop_lights_app/utilities/app_utils.dart';
import 'package:pop_lights_app/utilities/size_config.dart';

import '../utilities/app_colors.dart';

class LightSyncing extends StatefulWidget {

  static String routeName = "screens/light_syncing";

  const LightSyncing({Key? key}) : super(key: key);

  @override
  State<LightSyncing> createState() => _LightSyncingState();
}

class _LightSyncingState extends State<LightSyncing> {

  List<String> tabTitlesList = ["Group 1", "Group 2", "Group 3"];

  @override
  Widget build(BuildContext context) {

    return Container(

        decoration: const BoxDecoration(

            image: DecorationImage(image: AssetImage("assets/login_sign_up_background.jpg"), fit: BoxFit.cover)
        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: getProportionateHeight(83.0),),

            loadSVG("assets/click_the_lights_you_want_to_sync.svg"),

            SizedBox(height: getProportionateHeight(12.0),),

            loadSVG("assets/choose_group_text.svg"),

            SizedBox(height: getProportionateHeight(28.0),),

            DefaultTabController(
                length: 3,
                child: Expanded(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: PreferredSize(

                      preferredSize: const Size.fromHeight(10.0),

                      child: Row(

                        children: [

                          Flexible(
                            flex: 80,
                            child: SizedBox(
                              height: getProportionateHeight(25.0),
                              width: getProportionateWidth(390.0),
                              child: TabBar(
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: const BubbleTabIndicator(
                                  indicatorHeight: 25.0,
                                  indicatorColor: highlightColor,
                                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                                ),
                                tabs: List.generate(tabTitlesList.length, (index) => Text(tabTitlesList[index], style: TextStyle(color: Colors.black),),)
                              ),
                            ),
                          ),

                          Flexible(
                              flex: 20,
                              child: IconButton(onPressed: () => print("Add"), icon: const Icon(Icons.add))
                          )
                        ],
                      ),
                    ),
                    body: TabBarView(children: List.generate(tabTitlesList.length, (index) => GroupTabView(),),),
                  ),
                ),
            ),
          ],
        ),
    );
  }
}
