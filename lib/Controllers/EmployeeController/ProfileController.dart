// ignore_for_file: avoid_print

import 'package:campuspro/Modal/employee_module/employee_info.dart';
import 'package:campuspro/Repository/EmployeeRepo/profile_repository.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';

class AllEmployeeProfileController extends GetxController {
  usergetProfile() async {
    try {
      await EmployeeProfileRepository.getEmployeeProfileDetails().then((value) {
        if (value['Status'] == 'Cam-001') {
          List<dynamic> data = value['Data'];
          EmployeeDetailList.employeeDetails =
              data.map((json) => EmployeeDetailModel.fromJson(json)).toList();
        } else if (value['Status'] == 'Cam-003') {
          Get.toNamed(Routes.userType);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
