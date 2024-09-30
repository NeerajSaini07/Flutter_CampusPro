import 'dart:developer';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/student_module/student_profile_model.dart';
import 'package:campuspro/Modal/student_module/student_remark_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool studentDetailsSet = false.obs;
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  getStudentDetails() async {
    await StudentProfileRepo.studentDetailRepo().then((value) {
      if (value['Status'] == "Cam-001") {
        List<dynamic> studentData = value['Data'];
        log(studentData.toString());
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

  Future<List<StudentProfileModel>> getStudentProfileData() async {
    final response = await StudentProfileRepo.getStudentProfileRepo();
    log(response.toString());
    if (response != null && response['Status'] == "Cam-001") {
      List<dynamic> profileList = response['Data'];
      StudentProfileList.studentProfileList = profileList
          .map((json) => StudentProfileModel.fromJson(json))
          .toList();
      return StudentProfileList.studentProfileList;
    } else {
      return [];
    }
  }

  Future<List<StudentRemarkModel>> getStudentRemarkData() async {
    final response = await StudentProfileRepo.getStudentRemarkRepo();
    log(response.toString());
    if (response != null && response['Status'] == "Cam-001") {
      List<dynamic> remarkList = response['Data'];
      StudentRemarkList.studentRemarkList =
          remarkList.map((json) => StudentRemarkModel.fromJson(json)).toList();
      return StudentRemarkList.studentRemarkList;
    } else {
      return [];
    }
  }
}
