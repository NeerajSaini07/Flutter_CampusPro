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
      await UserTypeRepository.getuserstypeInRepo().then((value) {
        print(value);
        if (value != null) {
          List<dynamic> data = value['Data'];
          UserTypeslist.userTypesDetails =
              data.map((json) => UserTypeModel.fromJson(json)).toList();
        }
      });
    } catch (e) {
      rethrow;
    }
  }

// selecting the user typ and redirecting to web dashborad ***************
  gotoDashBorad(String url, [Map<String, int>? indexMap]) async {
    final WebController webController = Get.find<WebController>();
    await getUsers();

    int index = indexMap?.values.first ?? -1;
//  **************************** Stroing index of the currect user  ********************************
    await Sharedprefdata.storeIntegerData(Sharedprefdata.userTypeIndex, index);
    // *****************************************************************
    if (UserTypeslist.userTypesDetails[index].dashboardType == 'W') {
      try {
        await UserTypeRepository.getDrawerData(index).then((value) {
          List<dynamic> data = value['Data'];
          print(data);
          MenuItemList.menuItemDetails =
              data.map((json) => DrawerMenu.fromJson(json)).toList();
        });
        Get.toNamed(Routes.dashboard);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }

    webController.gotoWebDashboard(url);
    webController.currentUrl.value = url;
  }
}
