// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Services/downloadService/download_service.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClassRoomComments extends StatelessWidget {
  final int index;
  const ClassRoomComments({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final StudentClasssRoomController studentClasssRoomController =
        Get.find<StudentClasssRoomController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(context, title: "Class Room"),
        body: Column(
          children: [
            Obx(
              () => studentClasssRoomController.successcommentloader.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            children: [
                              classRoomdata(index),
                              const Divider(thickness: 0.4),
                              studentClasssRoomController.commentlist.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No Comments Found",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                      ),
                                    )
                                  : commentarea(context),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            commentbox(index),
          ],
        ),
      ),
    );
  }
}

Widget commentbox(index) {
  final studentClasssRoomController = Get.find<StudentClasssRoomController>();
  return Container(
    padding: EdgeInsets.only(bottom: 20.h, left: 10.w, right: 10),
    height: 80.h,
    width: double.infinity,
    alignment: Alignment.bottomCenter,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(
          () => studentClasssRoomController.fileName.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        studentClasssRoomController.fileName.toString().length >
                                30
                            ? '${studentClasssRoomController.fileName.substring(0, 30)}...'
                            : studentClasssRoomController.fileName.toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        studentClasssRoomController.fileName.value = '';
                        studentClasssRoomController.filesource.value = '';
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ),
        Expanded(
          child: Container(
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    studentClasssRoomController.filepicforClassRoom.value =
                        true;
                    CommonFunctions.getfiles();
                  },
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: AppColors.appbuttonColor,
                    child: Icon(
                      Icons.add,
                      color: AppColors.whitetextcolor,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: studentClasssRoomController.comment,
                    focusNode: studentClasssRoomController.commentFocusNode,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      isDense: true,
                      hintText: 'Enter your Reply...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    studentClasssRoomController.filesource.value.isNotEmpty ||
                            studentClasssRoomController.comment.text.isNotEmpty
                        ? studentClasssRoomController
                            .addCommentOnClassRoom(index)
                        : null;
                  },
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColors.appbuttonColor,
                    child: Icon(
                      Icons.send,
                      color: AppColors.whitetextcolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

//  ******************************  class room data ***********************************

Widget classRoomdata(index) {
  final studentClasssRoomController = Get.find<StudentClasssRoomController>();
  return Container(
    decoration: BoxDecoration(
      color: AppColors.whitetextcolor,
      borderRadius: BorderRadius.circular(10.r),
    ),
    margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
    child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HtmlWidget(
                studentClasssRoomController.classRoomdatalist[index].subjectName
                    .toString(),
                textStyle: AppTextStyles.cardTitle,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            studentClasssRoomController.classRoomdatalist[index].cirContent
                .toString(),
            style: AppTextStyles.cardContent,
          ),
          SizedBox(height: 12.h),
        ],
      ),
    ),
  );
}

//  ************************************** comment data *********************

Widget commentarea(BuildContext context) {
  final StudentClasssRoomController studentClasssRoomController =
      Get.find<StudentClasssRoomController>();
  final UserTypeController userTypeController = Get.find<UserTypeController>();
  final DownloadService downloadService = Get.find<DownloadService>();
  final DateFormat dateFormat = DateFormat('MMM dd yyyy hh:mma');

  bool hasTodayHeading = false;
  bool hasYesterdayHeading = false;

  return Column(
    children: List.generate(
        studentClasssRoomController.commentlist.toList().length, (index) {
      final comment = studentClasssRoomController.commentlist[index];
      DateTime? commentDate;
      commentDate =
          dateFormat.parse(comment.commentDate1!.replaceAll('  ', ' '));

      final DateTime today = DateTime.now();
      final bool isToday = commentDate.day == today.day &&
          commentDate.month == today.month &&
          commentDate.year == today.year;
      final bool isYesterday =
          commentDate.day == today.subtract(const Duration(days: 1)).day &&
              commentDate.month == today.month &&
              commentDate.year == today.year;

      bool isStudent = comment.userType.toString().toLowerCase() == 's';
      Alignment commentAlignment =
          isStudent ? Alignment.centerRight : Alignment.centerLeft;

      List<Widget> widgets = [];

      if (isToday && !hasTodayHeading) {
        hasTodayHeading = true;
        widgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: Text(
                "Today",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }

      if (isYesterday && !hasYesterdayHeading) {
        hasYesterdayHeading = true;
        widgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Center(
              child: Text(
                "Yesterday",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appbuttonColor),
              ),
            ),
          ),
        );
      }

      if (!isToday && !isYesterday) {
        if (index == 0 ||
            (index > 0 &&
                commentDate.day !=
                    dateFormat
                        .parse(studentClasssRoomController
                            .commentlist[index - 1].commentDate1!
                            .trim()
                            .replaceAll('  ', ' '))
                        .day)) {
          widgets.add(
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Center(
                child: Text(
                  "${commentDate.day}-${commentDate.month}-${commentDate.year}",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.appbuttonColor),
                ),
              ),
            ),
          );
        }
      }

      widgets.add(
        Align(
          alignment: commentAlignment,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: isStudent
                    ? const Color.fromARGB(255, 243, 235, 235)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                  topRight: isStudent ? Radius.circular(8.r) : Radius.zero,
                  topLeft: isStudent ? Radius.zero : Radius.circular(8.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isStudent
                              ? UserTypeslist
                                  .userTypesDetails[
                                      userTypeController.usertypeIndex]
                                  .stuEmpName
                                  .toString()
                              : "Teacher",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color:
                                isStudent ? AppColors.blackcolor : Colors.green,
                          ),
                        ),
                        Obx(() => studentClasssRoomController
                                .commentlist[index].fileUrl!.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  downloadService.downloadFile(
                                      studentClasssRoomController
                                          .classRoomdatalist[index]
                                          .circularFileUrl
                                          .toString());
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColors.appbuttonColor,
                                  radius: 15.r,
                                  child: const Icon(
                                    Icons.download,
                                    color: AppColors.whitetextcolor,
                                  ),
                                ),
                              )
                            : const SizedBox()),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(comment.comment.toString()),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        DateFormat('hh:mm a').format(commentDate),
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      );
    }),
  );
}
