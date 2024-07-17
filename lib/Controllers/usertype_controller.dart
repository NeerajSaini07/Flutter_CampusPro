import 'package:campuspro/Modal/drawer_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Repository/usertype_repo.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class UserTypeController extends GetxController {
  getUsers() async {
    try {
      await UserTypeRepository.getuserstypeInRepo().then((value) {
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

  gotoDashBorad(index) async {
    await getUsers();
    if (UserTypeslist.userTypesDetails[index].dashboardType == 'W') {
      try {
        await UserTypeRepository.getDrawerData(index).then((value) {
          List<dynamic> data = value['Data'];
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
  }
}
