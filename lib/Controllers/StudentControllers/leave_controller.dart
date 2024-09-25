import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Modal/student_module/leave_request_model.dart';
import 'package:campuspro/Modal/student_module/student_attendance_model.dart';
import 'package:campuspro/Repository/StudentRepositories/leave_repo.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentLeaveController extends GetxController {
  List<StudentAttendanceModel> stuAttendanceList = [];
  RxList<StudentLeaveRequestModel> stuLeaveRequestList =
      <StudentLeaveRequestModel>[].obs;
  var studentAttendanceChartData = <String, Map<String, int>?>{}.obs;
  RxInt touchedGroupIndex = (-1).obs;
  var touchedValue = ''.obs;
  //Ask for Leave
  RxList<String> leaveType = ["Sick Leave", "Urgent Leave"].obs;
  var toDate = Rx<DateTime?>(null);
  var fromDate = Rx<DateTime?>(null);
  RxString selectedLeaveType = "".obs;
  RxString leaveTypeErrormsg = "".obs;
  RxString dateErrormsg = "".obs;
  RxString descriptionErrormsg = "".obs;
  RxBool circularProgress = false.obs;
  final TextEditingController descriptionController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void updateTouchedGroupIndex(int index) {
    touchedGroupIndex.value = index;
  }

  void resetTouchedGroupIndex() {
    touchedGroupIndex.value = -1;
    touchedValue.value = '';
  }

  void updateTouchedValue(String value) {
    touchedValue.value = value;
  }

  //Get Student Attendance Data

  getStudentAttendanceData() async {
    final response = await StudentLeaveRepo.getStudentAttendanceDataRepo();
    log(response.toString());
    if (response != null && response['Status'] == "Cam-001") {
      List<dynamic> attendanceList = response['Data'];
      StudentAttendanceList.studentAttendanceList = attendanceList
          .map((json) => StudentAttendanceModel.fromJson(json))
          .toList();
      stuAttendanceList = StudentAttendanceList.studentAttendanceList;
      processData(stuAttendanceList);
    } else if (response != null && response['Status'] == "Cam-003") {
      final FcmTokenController fcmTokenController =
          Get.find<FcmTokenController>();
      await fcmTokenController.getFCMToken();
      getStudentAttendanceData();
    } else {
      stuAttendanceList = [];
    }
  }

  processData(List<StudentAttendanceModel> attListData) {
    Map<String, Map<String, int>> groupData = {};

    for (StudentAttendanceModel item in attListData) {
      if (item.attDate!.isNotEmpty) {
        DateTime date = DateFormat('dd-MM-yyyy').parse(item.attDate!);
        String monthYear = DateFormat('MMM yyyy').format(date);
        String attStatus = item.attStatus!.toString().trim();
        if (!groupData.containsKey(monthYear)) {
          groupData[monthYear] = {"Y": 0, "N": 0, "L": 0, "M": 0};
        }
        groupData[monthYear]![attStatus] =
            groupData[monthYear]![attStatus]! + 1;
      }
    }
    log(sortDataByMonthYear(groupData).toString());
    studentAttendanceChartData.value = sortDataByMonthYear(groupData);
  }

  Map<String, Map<String, int>?> sortDataByMonthYear(
      Map<String, Map<String, int>> data) {
    final dateFormat = DateFormat('MMM yyyy');
    final sortedKeys = data.keys.toList()
      ..sort((a, b) {
        final dateA = dateFormat.parse(a);
        final dateB = dateFormat.parse(b);
        return dateA.compareTo(dateB);
      });
    final sortedData = {for (var key in sortedKeys) key: data[key]};
    return sortedData;
  }

  //Get Student Leave Request Status
  getStudentLeaveRequestList() async {
    final response = await StudentLeaveRepo.getStudentLeaveRequestListRepo();
    log(response.toString());
    if (response != null && response['Status'] == "Cam-001") {
      List<dynamic> leaveRequestList = response['Data'];
      StudentLeaveRequestList.studentLeaveRequestList = leaveRequestList
          .map((json) => StudentLeaveRequestModel.fromJson(json))
          .toList();
      stuLeaveRequestList.value =
          StudentLeaveRequestList.studentLeaveRequestList;
    } else if (response != null && response['Status'] == "Cam-003") {
      final FcmTokenController fcmTokenController =
          Get.find<FcmTokenController>();
      await fcmTokenController.getFCMToken();
      getStudentLeaveRequestList();
    } else {
      stuAttendanceList = [];
    }
  }

  //Clearing TestFields
  void clearTextFields() {
    toDate.value = null;
    fromDate.value = null;
    descriptionController.clear();
    selectedLeaveType.value = "";
    leaveTypeErrormsg.value = "";
    dateErrormsg.value = "";
    descriptionErrormsg.value = "";
  }

  //Select from Date and toDate
  Future<void> selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: type == "to"
          ? (toDate.value ?? DateTime.now())
          : (fromDate.value ?? DateTime.now()),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (type == "to") {
      if (picked != null && picked != toDate.value) {
        if (picked.isAfter(fromDate.value!) ||
            picked.isAtSameMomentAs(fromDate.value!)) {
          toDate.value = picked;
          dateErrormsg.value = '';
        } else {
          dateErrormsg.value =
              'To date should be greater than or equal to from date';
        }
      }
    } else {
      if (picked != null && picked != fromDate.value) {
        fromDate.value = picked;
        dateErrormsg.value = '';
        toDate.value = null;
      }
    }
  }

  //Checking All TextFields are filled or not (Error are Shown if any)
  bool validatingTextField() {
    if (selectedLeaveType.value.isEmpty) {
      leaveTypeErrormsg.value = "Please select leave type.";
      dateErrormsg.value = "";
      descriptionErrormsg.value = "";
      return false;
    } else if (fromDate.value == null) {
      dateErrormsg.value = "Please select from date";
      leaveTypeErrormsg.value = "";
      descriptionErrormsg.value = "";
      return false;
    } else if (toDate.value == null) {
      dateErrormsg.value = "Please select to date";
      leaveTypeErrormsg.value = "";
      descriptionErrormsg.value = "";
      return false;
    } else if (descriptionController.text.trim().isEmpty) {
      dateErrormsg.value = "";
      leaveTypeErrormsg.value = "";
      descriptionErrormsg.value = "Please write description";
      return false;
    } else {
      dateErrormsg.value = "";
      leaveTypeErrormsg.value = "";
      descriptionErrormsg.value = "";
      return true;
    }
  }

  applyforStudentLeave() async {
    circularProgress.value = true;
    final classTeacherResponse = await StudentLeaveRepo.getClassTeacherRepo();
    log(classTeacherResponse.toString());
    if (classTeacherResponse != null &&
        classTeacherResponse['Status'] == "Cam-001") {
      try {
        if (classTeacherResponse['Data'].first['EmpId'] != null &&
            classTeacherResponse['Data'].first['EmpId'].toString().isNotEmpty) {
          final response = await StudentLeaveRepo.applyStudentLeaveRepo(
              destinationId:
                  classTeacherResponse['Data'].first['EmpId'].toString());
          log(response.toString());
          if (response != null && response['Status'] == "Cam-001") {
            CommonFunctions.showSuccessSnackbar("Leave Request Submitted",
                "Your leave request has been successfully processed.");
            getStudentLeaveRequestList();
          } else if (response != null && response['Status'] == "Cam-003") {
            final FcmTokenController fcmTokenController =
                Get.find<FcmTokenController>();
            await fcmTokenController.getFCMToken();
            CommonFunctions.showErrorSnackbar("Request Error",
                "There was an error processing your leave request. Please check your inputs and try again.");
          } else {
            CommonFunctions.showErrorSnackbar("Request Error",
                "There was an error processing your leave request. Please check your inputs and try again.");
          }
          clearTextFields();
        }
      } catch (e) {
        log(e.toString());
      }
    } else {
      CommonFunctions.showErrorSnackbar(
          "Request Error", "There was an error processing your leave request.");
    }
    clearTextFields();
    circularProgress.value = false;
  }
}
