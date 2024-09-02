// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/getpass/dashboard.dart';
import 'package:campuspro/Screens/user_type_screen.dart';
import 'package:campuspro/Screens/web_view_page.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/help_and_support_screen.dart';
import '../Screens/studenPortal/dashboard.dart';

class BottomBarController extends GetxController {
  final AppbarController appbarController = Get.find<AppbarController>();
  final WebController webController = Get.find<WebController>();
  final UserTypeController userTypeController = Get.find<UserTypeController>();
  RxInt selectedBottomNavIndex = 0.obs;
  RxBool showChat = false.obs;

  void checkToShowChatOption(int index) async {
    if (UserTypeslist.userTypesDetails[index].ouserType
            .toString()
            .toLowerCase() ==
        "e") {
      showChat.value = true;
    } else {
      showChat.value = false;
    }
  }

  void onItemTappedChangeBottomNavIndex(int index) async {
    webController.currentUrl.value = Constant.dashBoardUrl;
    if (showChat.value) {
      switch (index) {
        case 0:
          if (webController.currentUrl.value == Constant.dashBoardUrl) {
            webController.currentUrl.value = '';
            Future.delayed(Duration(milliseconds: 100), () {
              webController.currentUrl.value = Constant.dashBoardUrl;
              appbarController.appBarName.value =
                  Constant.schoolName.toString();
            });
          } else {
            // If the URL is different, set it normally
            appbarController.appBarName.value = Constant.schoolName.toString();
            webController.currentUrl.value = Constant.dashBoardUrl;
          }
          selectedBottomNavIndex.value = 0;
          break;
        // if (Constant.dashBoardUrl
        //     .toString()
        //     .contains("Studentx/Index.aspx")) {
        //   Get.offAndToNamed(Routes.StudentDashboad);
        // } else {
        //   appbarController.appBarName.value = Constant.schoolName.toString();
        //   webController.currentUrl.value = '';
        //   webController.currentUrl.value = Constant.dashBoardUrl;
        //   selectedBottomNavIndex.value = 0;
        // }

        case 1:
          Get.offAllNamed(Routes.userType);
          appbarController.appBarName.value = Constant.schoolName.toString();
          selectedBottomNavIndex.value = 0;
        case 2:
          appbarController.appBarName.value = "Chat";
          webController.currentUrl.value = '';
          webController.generateWebUrl(
              Constant.chatBoatUrl, Constant.chatBoatName);
          selectedBottomNavIndex.value = 2;
        case 3:
          appbarController.appBarName.value = "Help & Support";
          selectedBottomNavIndex.value = 3;
        default:
          selectedBottomNavIndex.value = index;
      }
    } else {
      switch (index) {
        case 0:

          // if (Constant.dashBoardUrl
          //     .toString()
          //     .contains("Studentx/Index.aspx")) {
          //   Get.offAndToNamed(Routes.StudentDashboad);
          // } else {
          appbarController.appBarName.value = Constant.schoolName.toString();
          // if (webController.currentUrl.value == Constant.dashBoardUrl) {
          //   webController.currentUrl.value = '';
          //   Future.delayed(Duration(milliseconds: 100), () {
          //     appbarController.appBarName.value =
          //         Constant.schoolName.toString();
          //     webController.currentUrl.value = Constant.dashBoardUrl;
          //   });
          // } else {
          //   // If the URL is different, set it normally
          //   appbarController.appBarName.value = Constant.schoolName.toString();
          //   webController.currentUrl.value = Constant.dashBoardUrl;
          // }
          webController.showWebViewScreen.value = false;
          selectedBottomNavIndex.value = 0;
          break;

        // }
        case 1:
          Get.offAllNamed(Routes.userType);
          appbarController.appBarName.value = Constant.schoolName.toString();
          selectedBottomNavIndex.value = 0;
        case 2:
          appbarController.appBarName.value = "Help & Support";
          webController.currentUrl.value = '';
          selectedBottomNavIndex.value = 2;

        default:
          selectedBottomNavIndex.value = index;
      }
    }
  }

  List<Widget> getScreens() {
    String userType = UserTypeslist
        .userTypesDetails[userTypeController.usertypeIndex].ouserType
        .toString();
    List<Widget> screens = [];

    // Add different screens based on the user type
    if (userType == 'S') {
      screens.add(Obx(() => webController.showWebViewScreen.value
          ? WebViewDashboardPage()
          : StudentDashboad()));
    } else if (userType == 'G') {
      screens.add(GatePassDashboard());
    } else {
      screens.add(WebViewDashboardPage());
    }

    // Add common screens
    screens.addAll([
      UserTypeScreen(),
    ]);

    // Conditionally add screens based on additional logic
    if (showChat.value) {
      screens.add(WebViewDashboardPage());
    }

    // Add remaining common screens
    screens.add(HelpAndSupportScreen());

    return screens;
  }
}
