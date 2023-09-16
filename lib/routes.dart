

  //
  import 'package:flutter/material.dart';
  import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pop_lights_app/screens/Having%20trouble.dart';
  import 'package:pop_lights_app/screens/Msg_Navigator.dart';
  import 'package:pop_lights_app/screens/adjust_settings/adjust_settings_home.dart';
import 'package:pop_lights_app/screens/adjust_settings/disconnection_page.dart';
import 'package:pop_lights_app/screens/adjust_settings/scan_file.dart';
import 'package:pop_lights_app/screens/adjust_settings/scan_for_devices.dart';
  import 'package:pop_lights_app/screens/delete_group.dart';
  import 'package:pop_lights_app/screens/delete_poplight.dart';
  import 'package:pop_lights_app/screens/deleted_successfully.dart';
  import 'package:pop_lights_app/screens/group_tabview.dart';
  import 'package:pop_lights_app/screens/home_screen.dart';
  import 'package:pop_lights_app/screens/pop_light_controll_center.dart';
  import 'package:pop_lights_app/screens/rename_delete_create_group.dart';
  import 'package:pop_lights_app/screens/share_setting.dart';
  import 'package:pop_lights_app/screens/sign_in_sign_up/sign_in_screen.dart';
  import 'package:pop_lights_app/screens/sign_in_sign_up/sign_up_screen.dart';
  import 'package:pop_lights_app/screens/sign_in_sign_up/splash_screen2.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/app_about.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/delete_grp_success.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/error_msg.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/manage_groups.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/my_pop_lights.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/pop_light_more.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/remove_from_grp_successfull.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/remove_pop_light.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/rename_pop_light.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/rename_successful.dart';
import 'package:pop_lights_app/screens/user_account_tabviews/select_another.dart';
  import 'package:pop_lights_app/screens/user_account_tabviews/unsync_successful.dart';

  import 'screens/light_syncing.dart';
  import 'screens/sign_in_sign_up/splash_screen.dart';
  import 'screens/user_account.dart';

  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    SplashScreen2.routeName: (BuildContext context) => const SplashScreen2(),
    SplashScreen.routeName: (BuildContext context) => const SplashScreen(),
    SignInScreen.routeName: (BuildContext context) => const SignInScreen(),
    SignUpScreen.routeName: (BuildContext context) => const SignUpScreen(),
    HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
    UserAccount.routeName: (BuildContext context) => const UserAccount(),
    LightSyncing.routeName: (BuildContext context) => const LightSyncing(),
    PopLightsControlCenter.routeName: (BuildContext context) => const PopLightsControlCenter(),
    GroupTabView.routeName: (BuildContext context) => const GroupTabView(),
    DeletePopLight.routeName: (BuildContext context) => const DeletePopLight(),
    PopLightMore.routeName: (BuildContext context) => PopLightMore(),
    RenamePopLight.routeName: (BuildContext context) => const RenamePopLight(),
    RenameDeleteCreateGroup.routeName: (BuildContext context) => const RenameDeleteCreateGroup(),
    DeleteGroup.routeName: (BuildContext context) => const DeleteGroup(),
    RemovePopLight.routeName: (BuildContext context) => const RemovePopLight(),
    HavingTrouble.routeName: (BuildContext context) => const HavingTrouble(),
    scanScreen.routeName: (BuildContext context) => const scanScreen(),
    ScanDevices.routeName: (BuildContext context) => const ScanDevices(),
    AdjustSettingsHome.routeName: (BuildContext context) => const AdjustSettingsHome(),
    AppAbout.routeName: (BuildContext context) => const AppAbout(),
    Messenger.routeName: (BuildContext context) => const Messenger(),
    RenamedSuccessfully.routeName:(BuildContext context) => const RenamedSuccessfully(),
    RemoveSuccessfully.routeName:(BuildContext context) => const RemoveSuccessfully(),
    unsyncedSuccessfully.routeName:(BuildContext context) => const unsyncedSuccessfully(),
    Error_msg .routeName:(BuildContext context) => const Error_msg(),
    deletedSuccessfully.routeName:(BuildContext context) => const deletedSuccessfully(),
    ShareSetting.routeName:(BuildContext context) => const ShareSetting(),
    select_another.routeName:(BuildContext context) => const select_another(),
    DisconnectDevices.routeName:(BuildContext context) => const DisconnectDevices(),
    // ManageGroups.routeName:(BuildContext context) => const ManageGroups(),
    // MyPopLights.routeName:(BuildContext context) => const  MyPopLights(BluetoothDevicesList: []),


  };
