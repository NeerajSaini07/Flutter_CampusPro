import 'dart:developer';
import 'package:campuspro/Modal/student_module/notification_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Repository/student_module_repository.dart';
import 'package:get/get.dart';

class StudentModuleController extends GetxController {
  RxBool studentDetailsSet = false.obs;
  RxBool notificationStatus = false.obs;

  getStudentDetails() async {
    await StudentModuleRepository.studentDetailRepo().then((value) {
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

  getNotification() async {
    await StudentModuleRepository.notificationRepo().then((value) {
      log(value.toString());
      if (value['Status'] == "Cam-001") {
        List<dynamic> notificationData = value['Data'];
        NotificationList.notificationList = notificationData
            .map((json) => NotificationModel.fromJson(json))
            .toList();
        notificationStatus.value = true;
      } else {
        NotificationList.notificationList = [];
        notificationStatus.value = false;
      }
    });
  }
}
