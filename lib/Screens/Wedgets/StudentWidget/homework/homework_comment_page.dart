import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common_appbar.dart';

class HomeworkCommets extends StatelessWidget {
  final int index;
  const HomeworkCommets({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final StudentHomeWorkController studentHomeWorkController =
        Get.find<StudentHomeWorkController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customAppBar(context),
        body: Column(
          children: [
            Obx(
              () => studentHomeWorkController.successcommentloader.value
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            children: [
                              Homeworkdata(index),
                              const Divider(thickness: 0.4),
                              homeworkComments(),
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
  final StudentHomeWorkController studentHomeWorkController =
      Get.find<StudentHomeWorkController>();
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
          () => studentHomeWorkController.filename.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        studentHomeWorkController.filename.toString().length >
                                30
                            ? '${studentHomeWorkController.filename.substring(0, 30)}...'
                            : studentHomeWorkController.filename.toString(),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        studentHomeWorkController.filename.value = '';
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
                    studentHomeWorkController.getfiles();
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
                    controller: studentHomeWorkController.commentcontroller,
                    focusNode: studentHomeWorkController.commentFocusNode,
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      isDense: true,
                      hintText: 'Enter your comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    studentHomeWorkController.addcommentsonHomeWork(index);
                  },
                  child: CircleAvatar(
                    radius: 20.r,
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

//  ********************************************************

Widget Homeworkdata(index) {
  final StudentHomeWorkController studentHomeWorkController =
      Get.find<StudentHomeWorkController>();

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
                  (studentHomeWorkController.homeworkbydate[index].subjectName
                      .toString()),
                  style: TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16.sp)),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            studentHomeWorkController.homeworkbydate[index].homeworkMsg
                .toString(),
            style: AppTextStyles.cardContent,
          ),
          SizedBox(height: 12.h),
          Text(
            studentHomeWorkController.homeworkbydate[index].attDate.toString(),
            style: AppTextStyles.cardContent,
          ),
        ],
      ),
    ),
  );
}

//  ***************************************  homework comment area **************************

Widget homeworkComments() {
  final StudentHomeWorkController studentHomeWorkController =
      Get.find<StudentHomeWorkController>();

  final UserTypeController userTypeController = Get.find<UserTypeController>();

  return Padding(
    padding: EdgeInsets.only(left: 20.w),
    child: Column(
      children: List.generate(studentHomeWorkController.homeworkcomments.length,
          (index) {
        final comment = studentHomeWorkController.homeworkcomments[index];
        if (studentHomeWorkController.homeworkbydate.isEmpty) {
          return const Center(
            child: Text("Not Comments Avaliable"),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 235, 235),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        comment.userType.toString().toLowerCase() == 's'
                            ? Text(
                                UserTypeslist
                                    .userTypesDetails[
                                        userTypeController.usertypeIndex]
                                    .stuEmpName
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blackcolor,
                                ),
                              )
                            : Text(
                                "Teacher",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              ),
                        Obx(() => studentHomeWorkController
                                .homeworkcomments[index].fileUrl!.isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: AppColors.appbuttonColor,
                                radius: 15.r,
                                child: const Icon(
                                  Icons.download,
                                  color: AppColors.whitetextcolor,
                                ),
                              )
                            : const SizedBox())
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(comment.comment.toString()),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    ),
  );
}
