import 'dart:developer';
import 'package:campuspro/Modal/student_module/notification_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_profile_repository.dart';
import 'package:get/get.dart';

class StudentProfileController extends GetxController {
  RxBool studentDetailsSet = false.obs;

  getStudentDetails() async {
    await StudentProfileRepo.studentDetailRepo().then((value) {
      log(value.toString());
      if (value['Status'] == "Cam-001") {
        List<dynamic> studentData = value['Data'];
        StudentDetaillist.studentdetails = studentData
            .map((json) => StudentDetailModel.fromJson(json))
            .toList();
        studentDetailsSet.value = true;
      } else {
        StudentDetaillist.studentdetails = [];
        studentDetailsSet.value = false;
      }
    });
  }
}
