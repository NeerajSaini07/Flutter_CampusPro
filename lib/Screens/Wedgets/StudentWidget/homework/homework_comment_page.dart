import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Services/downloadService/download_service.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        appBar: customAppBar(context, title: "Home Work"),
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
                              Obx(() => studentHomeWorkController
                                      .homeworkcomments.isEmpty
                                  ? Column(
                                      children: [
                                        Center(
                                          child: Text(
                                            "No Comments Found",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    )
                                  : homeworkComments(context)),
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
  final StudentClasssRoomController studentClasssRoomController =
      Get.find<StudentClasssRoomController>();
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
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              : const SizedBox(),
        ),
        Expanded(
          child: SizedBox(
            height: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    //  ***********************  because same function getting ffile for class room so  do not put file sourece into classroom variable
                    //  this is option condition
                    studentClasssRoomController.filepicforClassRoom.value =
                        false;

                    CommonFunctions.getfiles();
                  },
                  child: CircleAvatar(
                    radius: 14.r,
                    backgroundColor: AppColors.appbuttonColor,
                    child: const Icon(
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
                      hintText: 'Enter your Reply...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {
                    (studentHomeWorkController.commentfile.isEmpty &&
                            studentHomeWorkController
                                .commentcontroller.text.isEmpty)
                        ? null
                        : studentHomeWorkController
                            .addcommentsonHomeWork(index);
                  },
                  child: CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColors.appbuttonColor,
                    child: const Icon(
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
                    fontSize: 16.sp,
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
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                color: AppColors.blackcolor),
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

Widget homeworkComments(BuildContext context) {
  final StudentHomeWorkController studentHomeWorkController =
      Get.find<StudentHomeWorkController>();
  final UserTypeController userTypeController = Get.find<UserTypeController>();
  final DateFormat dateFormat = DateFormat('MMM dd yyyy hh:mma');

  bool hasTodayHeading = false;
  bool hasYesterdayHeading = false;

  return Column(
    children: List.generate(studentHomeWorkController.homeworkcomments.length,
        (index) {
      final comment = studentHomeWorkController.homeworkcomments[index];
      DateTime? commentDate;
      commentDate =
          dateFormat.parse(comment.commentDate1!.trim().replaceAll('  ', ' '));

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

      if (studentHomeWorkController.homeworkbydate.isEmpty) {
        return const Center(
          child: Text("No Comments Available"),
        );
      } else {
        List<Widget> widgets = [];

        // Add heading for "Today"
        if (isToday && !hasTodayHeading) {
          hasTodayHeading = true;
          widgets.add(
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Center(
                child: Text(
                  "Today",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.appbuttonColor),
                ),
              ),
            ),
          );
        }

        // *************** Add heading for "Yesterday" ********************
        if (isYesterday && !hasYesterdayHeading) {
          hasYesterdayHeading = true;
          widgets.add(
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Center(
                child: Text(
                  "Yesterday",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.appbuttonColor),
                ),
              ),
            ),
          );
        }

        // *********************   Add date for other comments *********************
        if (!isToday && !isYesterday) {
          if (index == 0 ||
              (index > 0 &&
                  commentDate.day !=
                      dateFormat
                          .parse(studentHomeWorkController
                              .homeworkcomments[index - 1].commentDate1!
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

        //  ******************  Comment content with **********************
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
                              color: isStudent
                                  ? AppColors.blackcolor
                                  : Colors.green,
                            ),
                          ),
                          const Spacer(),
                          if (isStudent) ...{
                            InkWell(
                              onTap: () {
                                if (studentHomeWorkController
                                        .homeworkcomments[index].replyId !=
                                    null) {
                                  studentHomeWorkController
                                      .deleteHomeworkComment(
                                          studentHomeWorkController
                                              .homeworkcomments[index].replyId!,
                                          index);
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.warningColor,
                                radius: 15.r,
                                child: const Icon(
                                  Icons.delete,
                                  color: AppColors.whitetextcolor,
                                ),
                              ),
                            )
                          },
                          SizedBox(
                            width: 8.w,
                          ),
                          Obx(() => studentHomeWorkController
                                  .homeworkcomments[index].fileUrl!.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    studentHomeWorkController.downloadFile(
                                        studentHomeWorkController
                                            .homeworkcomments[index].fileUrl!
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
      }
    }),
  );
}
