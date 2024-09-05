import 'package:campuspro/Controllers/EmployeeController/ProfileController.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/profileController.dart';
import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Repository/usertype_repo.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'menu_controller.dart';

class UserTypeController extends GetxController {
  var usertypeIndex;

  //var bottomIndexvalueForhelpAndSupport;
  getUsers() async {
    await getBaseUrl();
    try {
      await UserTypeRepository.getuserstypeInRepo().then((value) async {
        if (value != null) {
          List<dynamic> data = value['Data'];
          UserTypeslist.userTypesDetails =
              data.map((json) => UserTypeModel.fromJson(json)).toList();
          // await Sharedprefdata.storeStringData(Sharedprefdata.userTypeData,
          //     jsonEncode(UserTypeslist.userTypesDetails));
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  getBaseUrl() async {
    try {
      await UserTypeRepository.getbaseUrlInRepo().then((value) async {
        if (value != null) {
          await Sharedprefdata.storeStringData(
              Sharedprefdata.baseUrl, value['Data']['BaseApiUrl']);
        }
      });
    } catch (e) {
      rethrow;
    }
  }

// selecting the user typ and redirecting to web dashborad ***************
  gotoDashBorad(String url, [Map<String, int>? indexMap]) async {
    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();
    bottomBarController.checkToShowChatOption(indexMap?.values.first ?? -1);
    final FcmTokenController fcmTokenController =
        Get.find<FcmTokenController>();

    final AllEmployeeProfileController allEmployeeProfileController =
        Get.find<AllEmployeeProfileController>();

    final WebController webController = Get.find<WebController>();

    final AppbarController appbarController = Get.find<AppbarController>();
    final UserMenuController menuController = Get.find<UserMenuController>();
    final StudentProfileController studentController =
        Get.find<StudentProfileController>();

    final NotificationController notificationController =
        Get.find<NotificationController>();

    //  Putting Company Name on

    appbarController.appBarName.value = Constant.schoolName;
    Constant.dashBoardUrl = url;
    // print(Constant.dashBoardUrl);

    //  ************************  storig user details *******************

    // await getUsers();
    // **********************************  Generat fcm Token **************
    int index = indexMap?.values.first ?? -1;
//  **************************** Stroing index of the currect user  ********************************
    await Sharedprefdata.storeIntegerData(Sharedprefdata.userTypeIndex, index);
    // *****************************************************************

//  **************************** Stroing fcm token  ********************************
    await fcmTokenController.getFCMToken();
    // *****************************************************************

//  ***********************    managening the dashboard type open  ****************

    if (UserTypeslist.userTypesDetails[index].ouserType == 'S') {
      webController.showWebViewScreen.value = false;
      studentController.getStudentDetails();
    } else if (UserTypeslist.userTypesDetails[index].ouserType == 'E') {
      webController.showWebViewScreen.value = false;
      allEmployeeProfileController.usergetProfile();
    } else {
      allEmployeeProfileController.usergetProfile();
    }

    //  *************************************

    if (UserTypeslist.userTypesDetails[index].dashboardType == 'W') {
      try {
        // ********************* finding menu from user *************************************

//  *****************************************************************************

        // Modification date : 22-08 -2024
        // Purpose: storing menu in local db and get pass module included

        await menuController.getmenuFromServer(index);

        await notificationController.getNotification();

        Get.toNamed(Routes.Dashboardboard);

        usertypeIndex =
            await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

        if (UserTypeslist.userTypesDetails[index].ouserType == 'E') {
          bottomBarController.showChat.value = true;
          //bottomIndexvalueForhelpAndSupport.value = 2;
        } else {
          bottomBarController.showChat.value = false;
          // bottomIndexvalueForhelpAndSupport.value = 2;
        }
        bottomBarController.selectedBottomNavIndex.value = 0;

// ************************************************************************
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    //webController.gotoWebview(url);
    webController.currentUrl.value = url;
  }
}
