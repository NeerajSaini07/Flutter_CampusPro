import 'dart:developer';
import 'dart:io';

import 'package:campuspro/Modal/student_module/student_circular_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_circular_repo.dart';
import 'package:campuspro/Services/downloadService/download_service.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CircularStatus { initial, loading, success, error }

class CircularController extends GetxController {
  final DownloadService downloadService = Get.find<DownloadService>();
  var toDate = Rx<DateTime?>(null);
  var fromDate = Rx<DateTime?>(null);
  RxString filtererrormsg = "".obs;
  RxInt filterCircular = 1.obs;
  var status = CircularStatus.loading.obs;

  //Searching
  RxString searchQuery = "".obs;
  RxList<StudentCircularModel> originalCircularList =
      <StudentCircularModel>[].obs;
  RxList<StudentCircularModel> filteredCircularList =
      <StudentCircularModel>[].obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    filterCircular.value = 1;
    searchQuery.value = "";
    ever(searchQuery, (_) => searchCircularList());
  }

  Future<List<StudentCircularModel>> getStudentCircular() async {
    status.value = CircularStatus.loading;
    try {
      final response = await StudentCircularRepo.getStudentCircular();
      if (response != null && response['Status'] == 'Cam-001') {
        List<dynamic> circularData = response['Data'];
        StudentCircularList.studentCircularList = circularData
            .map((json) => StudentCircularModel.fromJson(json))
            .toList();
        log(circularData.toString());
        // await changeDownloadStatus();
        originalCircularList.value = StudentCircularList.studentCircularList;
        toDate.value = null;
        fromDate.value = null;
        status.value = CircularStatus.success;
        return StudentCircularList.studentCircularList;
      } else if (response['Status'] == 'Cam-001') {
        Get.toNamed(Routes.userType);
      }
      return StudentCircularList.studentCircularList;
    } catch (e) {
      status.value = CircularStatus.error;
      return [];
    }
  }

  void searchCircularList() {
    if (searchQuery.isEmpty) {
      filteredCircularList.value = originalCircularList;
    } else {
      try {
        final regex = RegExp(searchQuery.value, caseSensitive: false);
        filteredCircularList.value = originalCircularList
            .where((circular) =>
                regex.hasMatch(circular.cirSubject ?? '') ||
                regex.hasMatch(circular.cirNo ?? ''))
            .toList();
      } catch (e) {
        filteredCircularList.value = [];
      }
    }
  }

  //Select Date
  Future<void> selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: type == "to"
          ? (toDate.value ?? DateTime.now())
          : (fromDate.value ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (type == "to") {
      if (picked != null && picked != toDate.value) {
        if (picked.isAfter(fromDate.value!) ||
            picked.isAtSameMomentAs(fromDate.value!)) {
          toDate.value = picked;
          filtererrormsg.value = '';
        } else {
          filtererrormsg.value =
              'To date should be greater than or equal to from date';
        }
      }
    } else {
      if (picked != null && picked != fromDate.value) {
        fromDate.value = picked;
        filtererrormsg.value = '';
        toDate.value = null;
      }
    }
  }

  Future<void> downloadFile(String url) async {
    await downloadService.downloadFile(url);
  }

  // Future<void> changeDownloadStatus() async {
  //   for (StudentCircularModel item in StudentCircularList.studentCircularList) {
  //     String fileName = item.circularFileurl!.split('/').last;
  //     try {
  //       final directory = await downloadService.getDownloadDirectory();
  //       final filePath = path.join(directory.path, fileName);
  //       if (await File(filePath).exists()) {
  //         item.isDownloaded.value = true;
  //       }
  //     } catch (e) {
  //       item.isDownloaded.value = false;
  //     }
  //   }
  // }
}
