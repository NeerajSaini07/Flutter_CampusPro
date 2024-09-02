// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unused_local_variable, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:campuspro/Screens/Wedgets/bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
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
          Get.back();
          return true;
        } else {
          appbarController.appBarName.value = Constant.schoolName;
          webController.generateWebUrl('Index.aspx', 'Dashboard');
          return false;
        }
      },
      child: Scaffold(
          appBar: customAppBar(context),
          bottomNavigationBar: Obx(
            () => customBottomNavBar(
                bottomBarController.selectedBottomNavIndex.value,
                bottomBarController.onItemTappedChangeBottomNavIndex),
          ),
          drawer: AppDrawer(context),
          body: Obx(() => bottomBarController
              .getScreens()[bottomBarController.selectedBottomNavIndex.value])),
    );
  }
}
