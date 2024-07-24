import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/drawer_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Repository/usertype_repo.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserTypeController extends GetxController {
  getUsers() async {
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

// selecting the user typ and redirecting to web dashborad ***************
  gotoDashBorad(String url, [Map<String, int>? indexMap]) async {
    final FcmTokenController fcmTokenController =
        Get.find<FcmTokenController>();

    final WebController webController = Get.find<WebController>();

    //  ************************  storig user details *******************

    await getUsers();

    int index = indexMap?.values.first ?? -1;
//  **************************** Stroing index of the currect user  ********************************
    await Sharedprefdata.storeIntegerData(Sharedprefdata.userTypeIndex, index);
    // *****************************************************************

//  **************************** Stroing fcm token  ********************************
    await fcmTokenController.getFCMToken();
    // *****************************************************************

    if (UserTypeslist.userTypesDetails[index].dashboardType == 'W') {
      try {
        // ********************* finding menu from user *************************************
        await UserTypeRepository.getDrawerData(index).then((value) {
          List<dynamic> data = value['Data'];
          MenuItemList.menuItemDetails =
              data.map((json) => DrawerMenu.fromJson(json)).toList();
        });

// ************************************************************************
        Get.offAllNamed(Routes.webview);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    webController.gotoWebview(url);
    webController.currentUrl.value = url;
  }
}
