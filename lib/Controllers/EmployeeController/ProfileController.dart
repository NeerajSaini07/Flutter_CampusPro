// ignore_for_file: avoid_print

import 'package:campuspro/Repository/EmployeeRepo/profile_repository.dart';
import 'package:get/get.dart';

class AllEmployeeProfileController extends GetxController {
  usergetProfile() async {
    print("profile calling");
    try {
      await EmployeeProfileRepository.getEmployeeProfileDetails().then((value) {
        print(value);
      });
    } catch (e) {
      print(e);
    }
  }
}
