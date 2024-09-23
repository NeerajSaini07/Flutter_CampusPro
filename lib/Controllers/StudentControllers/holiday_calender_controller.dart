import 'dart:developer';

import 'package:campuspro/Controllers/StudentControllers/profileController.dart';
import 'package:campuspro/Modal/student_module/holiday_list_model.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Repository/StudentRepositories/holiday_repo.dart';
import 'package:get/get.dart';

class StudentHolidayAndCalendarController extends GetxController {
  //Get Holday List
  Future<List<StudentHolidayModel>> getStudentHolidayList() async {
    if (StudentDetaillist.studentdetails.isEmpty) {
      final StudentProfileController studentController =
          Get.find<StudentProfileController>();
      await studentController.getStudentDetails();
    }
    final holidayListResponse =
        await StudentHolidayRepo.getStudentHolidayListRepo(
            classId: (StudentDetaillist.studentdetails.first.classId ?? "")
                .toString());
    log(holidayListResponse.toString());
    if (holidayListResponse != null &&
        holidayListResponse['Status'] == "Cam-001") {
      List<dynamic> holidayList = holidayListResponse['Data'];
      StudentHolidaylist.stuHolidayList = holidayList
          .map((json) => StudentHolidayModel.fromJson(json))
          .toList();
      return StudentHolidaylist.stuHolidayList;
    }
    return [];
  }
}
