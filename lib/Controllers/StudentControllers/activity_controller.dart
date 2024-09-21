import 'dart:developer';

import 'package:campuspro/Repository/StudentRepositories/student_activity_repo.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class StudentActivityController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStudentCircular();
  }

  Future getStudentCircular() async {
    try {
      final response = await StudentActivityRepo.getStudentActivity();
      log(response.toString());
      List<dynamic> circularData = response['Data'];
    } catch (e) {}
  }
}
