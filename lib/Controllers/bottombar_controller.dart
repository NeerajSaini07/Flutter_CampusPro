import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';

import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';

import 'package:get/get.dart';

class BottomBarController extends GetxController {
  final AppbarController appbarController = Get.find<AppbarController>();
  final WebController webController = Get.find<WebController>();

  RxInt selectedBottomNavIndex = 0.obs;
  void onItemTappedChangeBottomNavIndex(int index) async {
    webController.currentUrl.value = Constant.dashBoardUrl;
    Get.offAllNamed(Routes.webview);

    switch (index) {
      case 0:
        Get.offAllNamed(Routes.webview);
        appbarController.appBarName.value = Constant.schoolName.toString();
        webController.currentUrl.value = Constant.dashBoardUrl;

      case 1:
        Get.offAllNamed(Routes.userType);
        selectedBottomNavIndex.value = 0;

      case 2:
        // Get.offAllNamed(Routes.userType);
        webController.generateWebUrl(
            Constant.chatBoatUrl, Constant.chatBoatName);
        selectedBottomNavIndex.value = 0;
      case 3:
        // Get.offAllNamed(Routes.userType);

        appbarController.appBarName.value = "Help & Support";
        webController.currentUrl.value =
            "https: //demo.eiterp.com/Help-Support.aspx";
        Get.offAllNamed(Routes.webview);

      default:
        selectedBottomNavIndex.value = index;
    }
  }
}