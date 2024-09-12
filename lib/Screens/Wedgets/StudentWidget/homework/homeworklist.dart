import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Modal/student_module/home_work.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/common_text_style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'reply_dialog.dart';

Widget homeWorkListdata(StudentHomeWorkController studentHomeWorkController) {
  return Obx(
    () {
      final focusedDate = studentHomeWorkController.focuseddate.value;

      final selectedDateEvents = HomeworkList.homeworkDetails.where((event) {
        return event.date != null &&
            event.date!.year == focusedDate.year &&
            event.date!.month == focusedDate.month &&
            event.date!.day == focusedDate.day;
      }).toList();

      if (selectedDateEvents.isEmpty) {
        return const Center(
          child: Text("Homework Not Found"),
        );
      }

      return ListView.builder(
        itemCount: selectedDateEvents.length,
        itemBuilder: (context, index) {
          final event = selectedDateEvents[index];
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: homeWorkCard(event, context));
        },
      );
    },
  );
}

//  *************************************  card for showing the list of data

Widget homeWorkCard(event, BuildContext context) {
  return Card(
    color: AppColors.whitetextcolor,
    margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.h),
    child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (event.teacherName.toString()),
                style: AppTextStyles.cardTitle,
              ),
              // SizedBox(width:100.w),
              Text((event.subject.toString()),
                  style: TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16.sp)),

              SizedBox(width: 120.w),
              GestureDetector(
                  onTap: () {
                    showChatScreenDialog(context);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.reply,
                      color: AppColors.appbuttonColor,
                    ),
                  ))
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            event.description.toString(),
            style: AppTextStyles.cardContent,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                event.date.toString(),
                style: AppTextStyles.cardDate,
              ),
              Container(
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
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
