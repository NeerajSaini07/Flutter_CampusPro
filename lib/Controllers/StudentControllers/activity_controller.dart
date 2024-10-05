import 'dart:developer';

import 'package:campuspro/Modal/student_module/student_activity_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_activity_repo.dart';
import 'package:campuspro/Services/downloadService/download_service.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

enum StudentActivityApiStatus { initial, loading, success, error }

class StudentActivityController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //filter :: 1--> My School , 2--> My Class(default) , 3--> Me Only
  //My School Activity List
  RxList<StudentActivityModel> myScoolActivityList =
      <StudentActivityModel>[].obs;
  //My Class Activity List
  RxList<StudentActivityModel> myClassActivityList =
      <StudentActivityModel>[].obs;
  //Me Only Activity List
  RxList<StudentActivityModel> meOnlyActivityList =
      <StudentActivityModel>[].obs;
  //Student Activity Api Status
  var studentActivityApiStatus = StudentActivityApiStatus.initial.obs;
  RxInt activityfilter = 2.obs;
  Set<int> fetchedFilters = {};
  late TabController tabController;

  final DownloadService downloadService = Get.find<DownloadService>();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    switch (tabController.index) {
      case 0:
        if (!fetchedFilters.contains(2)) {
          getStudentActivity(filter: 2);
        }
        break;
      case 1:
        if (!fetchedFilters.contains(1)) {
          getStudentActivity(filter: 1);
        }
        break;
      case 2:
        if (!fetchedFilters.contains(3)) {
          getStudentActivity(filter: 3);
        }
        break;
    }
  }

  Future<void> getStudentActivity({required int filter}) async {
    try {
      activityfilter.value = filter;
      studentActivityApiStatus.value = StudentActivityApiStatus.loading;
      final response =
          await StudentActivityRepo.getStudentActivityRepo(filter: filter);
      log(response.toString());
      if (response['Status'] == "Cam-001" || response['Status'] == "Cam-006") {
        List<dynamic> activityData = response['Data'];
        switch (filter) {
          case 1:
            myScoolActivityList.value = activityData
                .map((json) => StudentActivityModel.fromJson(json))
                .toList();
            break;
          case 2:
            myClassActivityList.value = activityData
                .map((json) => StudentActivityModel.fromJson(json))
                .toList();
            break;
          case 3:
            meOnlyActivityList.value = activityData
                .map((json) => StudentActivityModel.fromJson(json))
                .toList();
            break;
        }
        fetchedFilters.add(filter);
        studentActivityApiStatus.value = StudentActivityApiStatus.success;
      } else if (response['Status'] == 'Cam-003') {
        Get.toNamed(Routes.userType);
      } else {
        studentActivityApiStatus.value = StudentActivityApiStatus.error;
      }
    } catch (e) {
      studentActivityApiStatus.value = StudentActivityApiStatus.error;
    }
  }

  Future<void> downloadFile(String url) async {
    await downloadService.downloadFile(url);
  }
}
