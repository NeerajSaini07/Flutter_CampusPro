import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';

import 'package:campuspro/Screens/Wedgets/StudentWidget/common_text_style.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/homework/homework_comment_page.dart';
import 'package:campuspro/Services/downloadService/download_service.dart';
import 'package:campuspro/Services/fileDownloadSerrvice/download.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget homeWorkListdata(StudentHomeWorkController studentHomeWorkController) {
  return Obx(
    () {
      if (studentHomeWorkController.homeworkbydate.isEmpty) {
        return const Center(
          child: Text("Homework Not Available"),
        );
      } else {
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
                        fontSize: 16.sp,
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
                          fontWeight: FontWeight.normal, fontSize: 14.sp)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() => studentHomeWorkController
                          .homeworkbydate[index].homeworkURL!.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            // downloadService.downloadFile(
                            //     studentHomeWorkController
                            //         .homeworkbydate[index].homeworkURL
                            //         .toString());
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.appbuttonColor,
                            radius: 13.r,
                            child: const Icon(
                              Icons.download,
                              color: AppColors.whitetextcolor,
                            ),
                          ),
                        )
                      : const SizedBox()),
                  SizedBox(
                    width: 20.w,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // await studentClasssRoomController
                      //     .getclassRommComments(index);
                      await studentHomeWorkController
                          .studenthomeworkReply(index);

                      Get.to(HomeworkCommets(index: index));
                      //studenthomeworkCommentsdialog(context, index);
                    },
                    child: Image.asset(
                      "assets/icon/show_message.png",
                      height: 22.h,
                      width: 22.w,
                      fit: BoxFit.contain,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: studentHomeWorkController
                            .homeworkbydate[index].homeworkMsg
                            .toString()
                            .length >
                        100
                    ? studentHomeWorkController
                        .homeworkbydate[index].homeworkMsg!
                        .substring(0, 100)
                    : studentHomeWorkController
                        .homeworkbydate[index].homeworkMsg,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackcolor),
              ),
              studentHomeWorkController.homeworkbydate[index].homeworkMsg
                          .toString()
                          .length >
                      100
                  ? TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          await studentHomeWorkController
                              .studenthomeworkReply(index);
                          Get.to(HomeworkCommets(
                            index: index,
                          ));
                        },
                      text: "  ...View More",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent))
                  : TextSpan(),
            ]),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                studentHomeWorkController.homeworkbydate[index].attDate
                    .toString(),
                style: AppTextStyles.cardDate,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
