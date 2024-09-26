import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Modal/student_module/classromm_comment_model.dart';
import 'package:campuspro/Modal/student_module/homeworkdatamodel.dart';
import 'package:campuspro/Modal/student_module/homeworkbydate.dart';
import 'package:campuspro/Repository/StudentRepositories/homeworkRepo.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:path/path.dart' as path;

class StudentHomeWorkController extends GetxController {
  var calendarFormat = CalendarFormat.week.obs;
  var focuseddate = DateTime.now().obs;
  RxBool tableRefresh = false.obs;
  var selectedDay = DateTime.now().obs;
  var homeworkloader = false.obs;
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
    final FcmTokenController fcmTokenController =
        Get.find<FcmTokenController>();
    homeworkloader.value = true;
    await HomeWorkRepository.gethomeworkdatabydatesheet().then((value) {
      print(value);
      if (value != null) {
        if (value['Status'] == "Cam-001") {
          List<dynamic> currenthomework = value['Data'];
          // **************  for storing the data for showing notification on dshboiard *********
          homeworkbydate.value = currenthomework
              .map((json) => HomeWorkByDateModel.fromJson(json))
              .toList();

          homeworkloader.value = false;

          //  ************************  if token expire **************************
        } else if (value['Status'] == "Cam-003") {
          fcmTokenController.getFCMToken();
          markgreenhomedate();
        } else {
          homeworkbydate.clear();
          homeworkloader.value = false;
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
          Get.snackbar(
              backgroundColor: Colors.green,
              colorText: AppColors.blackcolor,
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
              backgroundColor: Colors.green,
              colorText: AppColors.blackcolor,
              "Homework Reply",
              "Your Reply has been succesfully Submitted");
        } else {
          commentcontroller.clear();
          Get.snackbar(
              backgroundColor: Colors.red,
              colorText: AppColors.blackcolor,
              "Homework Reply",
              "Your Reply  Not Submitted");
        }
      }
    });
  }
}
