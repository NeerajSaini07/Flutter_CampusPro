import 'dart:developer';

import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Modal/student_module/classromm_comment_model.dart';
import 'package:campuspro/Modal/student_module/homeworkdatamodel.dart';
import 'package:campuspro/Modal/student_module/homeworkbydate.dart';
import 'package:campuspro/Repository/StudentRepositories/homeworkRepo.dart';
import 'package:campuspro/Services/downloadService/download_service.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentHomeWorkController extends GetxController {
  final DownloadService downloadService = Get.find<DownloadService>();
  var calendarFormat = CalendarFormat.week.obs;
  var focuseddate = DateTime.now().obs;
  RxBool tableRefresh = false.obs;
  var selectedDay = DateTime.now().obs;
  var commentfile = ''.obs;
  var filename = ''.obs;
  var showfileoncomment = false.obs;
  var successcommentloader = false.obs;
  final FocusNode commentFocusNode = FocusNode();
  var homeworkdatelist = <HomeworkModel>[].obs;
  var homeworkbydate = <HomeWorkByDateModel>[].obs;
  var homeworkcomments = <ClassRoomCommentModel>[].obs;

  final TextEditingController commentcontroller = TextEditingController();
  final FcmTokenController fcmTokenController = Get.find<FcmTokenController>();

  markgreenhomedate() async {
    final FcmTokenController fcmTokenController =
        Get.find<FcmTokenController>();
    await HomeWorkRepository.gethomedate().then((value) {
      if (value != null) {
        if (value['Status'] == "Cam-001") {
          List<dynamic> homeworklistdata = value['Data1'];
          // **************  for storing the data for showing notification on dshboiard *********
          homeworkdatelist.value = homeworklistdata
              .map((json) => HomeworkModel.fromJson(json))
              .toList();

          //  ************************  if token expire **************************
        } else if (value['Status'] == "Cam-003") {
          fcmTokenController.getFCMToken();
          markgreenhomedate();
        } else {
          homeworkdatelist.clear();
        }
      } else {
        homeworkdatelist.clear();
      }
    });
  }

  //  *******************  current date homework ********************

  gethomeworkbydate() async {
    tableRefresh.value = true;
    await HomeWorkRepository.gethomeworkdatabydatesheet().then((value) {
      if (value != null) {
        if (value['Status'] == "Cam-001") {
          List<dynamic> currenthomework = value['Data'];
          // **************  for storing the data for showing notification on dshboiard *********
          homeworkbydate.value = currenthomework
              .map((json) => HomeWorkByDateModel.fromJson(json))
              .toList();

          tableRefresh.value = false;

          //  ************************  if token expire **************************
        } else if (value['Status'] == "Cam-003") {
          // fcmTokenController.getFCMToken();
          // markgreenhomedate();
        } else {
          homeworkbydate.clear();
          tableRefresh.value = false;
        }
      }
    });
  }

  //  *************************************************  student home work Comment *******************************

  studenthomeworkReply(index) async {
    successcommentloader.value = true;
    await HomeWorkRepository.gethomeworkComment(index).then((value) {
      if (value != null) {
        if (value['Status'] == "Cam-001") {
          List<dynamic> commentdata = value['Data'];
          homeworkcomments.value = commentdata
              .map((json) => ClassRoomCommentModel.fromJson(json))
              .toList();

          successcommentloader.value = false;
        } else if (value['Status'] == 'Cam-003') {
          // fcmTokenController.getFCMToken();
          studenthomeworkReply(index);
          successcommentloader.value = false;
        } else {
          homeworkcomments.clear();
          successcommentloader.value = false;
        }
      }
    });
  }

  //  ********************************************  add comment ************************

  addcommentsonHomeWork(index) async {
    await HomeWorkRepository.addcommentsonHomeWork(index).then((value) {
      if (value != null) {
        if (value['Status'] == 'Cam-001') {
          showfileoncomment.value = false;
          commentcontroller.clear();
          filename.value = '';
          commentfile.value = '';
          Get.snackbar(
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: AppColors.whitetextcolor,
              "Homework Reply",
              "Your Reply has been succesfully Submitted");
          studenthomeworkReply(index);
        } else if (value['Status'] == 'Cam-006') {
          commentcontroller.clear();
          filename.value = '';
          showfileoncomment.value = false;
          commentcontroller.clear();
          studenthomeworkReply(index);
          Get.snackbar(
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: AppColors.whitetextcolor,
              "Homework Reply",
              "Your Reply has been succesfully Submitted");
        } else {
          commentcontroller.clear();
          Get.snackbar(
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: AppColors.blackcolor,
              "Homework Reply",
              "Your Reply  Not Submitted");
        }
      }
    });
  }

  //  ********************************************  delete comment ************************
  deleteHomeworkComment(int commentId) async {
    final response = await HomeWorkRepository.addcommentsonHomeWork(commentId);
    log(response.toString());
    if (response != null && response['Status'] == "Cam-001") {
      CommonFunctions.showSuccessSnackbar(
          "Success", "The reply has been successfully deleted.");
    } else {
      CommonFunctions.showSuccessSnackbar(
          "Error", "Failed to delete the reply. Please try again.");
    }
  }

  Future<void> downloadFile(String url) async {
    await downloadService.downloadFile(url);
  }
}
