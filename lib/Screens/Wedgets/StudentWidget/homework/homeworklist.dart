import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';

import 'package:campuspro/Screens/Wedgets/StudentWidget/common_text_style.dart';
import 'package:campuspro/Services/fileDownloadSerrvice/download.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../classoom/reply_dialog.dart';
import 'comment.dart';

Widget homeWorkListdata(StudentHomeWorkController studentHomeWorkController) {
  return Obx(
    () {
      if (studentHomeWorkController.homeworkbydate.isEmpty) {
        return const Center(
          child: Text("Homework Not Available"),
        );
      } else {
        // Display list of events
        return ListView.builder(
          itemCount: studentHomeWorkController.homeworkbydate.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: homeWorkCard(index, context),
            );
          },
        );
      }
    },
  );
}

//  *************************************  card for showing the list of data

Widget homeWorkCard(index, BuildContext context) {
  final StudentHomeWorkController studentHomeWorkController =
      Get.find<StudentHomeWorkController>();

  final DownloadService downloadService = Get.find<DownloadService>();
  return Card(
    color: AppColors.whitetextcolor,
    margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
    child: Padding(
      padding: EdgeInsets.all(6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                      (studentHomeWorkController.homeworkbydate[index].name
                          .toString()),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: AppColors.blackcolor,
                      )),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                      (studentHomeWorkController
                          .homeworkbydate[index].subjectName
                          .toString()),
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16.sp)),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  // await studentClasssRoomController
                  //     .getclassRommComments(index);
                  await studentHomeWorkController.studenthomeworkReply(index);
                  studenthomeworkCommentsdialog(context, index);
                },
                child: Image.asset(
                  "assets/icon/show_message.png",
                  height: 20.h,
                  width: 20.w,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            studentHomeWorkController.homeworkbydate[index].homeworkMsg
                .toString(),
            style: AppTextStyles.cardContent,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                studentHomeWorkController.homeworkbydate[index].attDate
                    .toString(),
                style: AppTextStyles.cardDate,
              ),
              studentHomeWorkController
                      .homeworkbydate[index].homeworkURL!.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        downloadService.downloadFile(studentHomeWorkController
                            .homeworkbydate[index].homeworkURL
                            .toString());
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          color: AppColors.appbuttonColor,
                          borderRadius: BorderRadius.circular(14.r),
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.download,
                              size: 16.r,
                              color: AppColors.whitetextcolor,
                            ),
                            Text(
                              'Download',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    ),
  );
}
