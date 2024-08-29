import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  final AppbarController appbarController = Get.find<AppbarController>();
  final WebController webController = Get.find<WebController>();

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
          if (Constant.dashBoardUrl
              .toString()
              .contains("Studentx/Index.aspx")) {
            Get.offAndToNamed(Routes.StudentDashboad);
          } else {
            appbarController.appBarName.value = Constant.schoolName.toString();
            webController.currentUrl.value = '';
            webController.currentUrl.value = Constant.dashBoardUrl;
            selectedBottomNavIndex.value = 0;
          }

        case 1:
          Get.toNamed(Routes.userType);
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
          if (Constant.dashBoardUrl
              .toString()
              .contains("Studentx/Index.aspx")) {
            Get.offAndToNamed(Routes.StudentDashboad);
          } else {
            appbarController.appBarName.value = Constant.schoolName.toString();
            webController.currentUrl.value = '';
            webController.currentUrl.value = Constant.dashBoardUrl;
            selectedBottomNavIndex.value = 0;
          }
        case 1:
          Get.toNamed(Routes.userType);
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
}
