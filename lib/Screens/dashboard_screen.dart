// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:campuspro/Screens/Wedgets/bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final WebController webController = Get.find<WebController>();
  final AppbarController appbarController = Get.find<AppbarController>();

  @override
  Widget build(BuildContext context) {
    late InAppWebViewController webViewController;

    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();

    final UserTypeController userTypeController =
        Get.find<UserTypeController>();

    return WillPopScope(
      onWillPop: () async {
        if (appbarController.appBarName.value == Constant.schoolName) {
          appbarController.appBarName.value = Constant.schoolName;
          return true;
        } else {
          bottomBarController.selectedBottomNavIndex.value = 0;
          // webController.generateWebUrl('Index.aspx', 'Dashboard');
          webController.showWebViewScreen.value = false;
          return false;
        }
      },
      child: Scaffold(
          appBar: customAppBar(context, title: Constant.schoolName),
          bottomNavigationBar: Obx(
            () => customBottomNavBar(
                bottomBarController.selectedBottomNavIndex.value,
                bottomBarController.onItemTappedChangeBottomNavIndex),
          ),
          drawer: UserTypeslist
                      .userTypesDetails[userTypeController.usertypeIndex]
                      .ouserType
                      .toString() ==
                  "G"
              ? null
              : AppDrawer(context),
          body: Obx(() => bottomBarController
              .getScreens()[bottomBarController.selectedBottomNavIndex.value])),
    );
  }
}
