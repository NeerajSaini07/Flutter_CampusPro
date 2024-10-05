import 'package:campuspro/Controllers/datesheet_controller.dart';
import 'package:campuspro/Modal/student_module/student_datesheet_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentDateSheetScreen extends StatefulWidget {
  const StudentDateSheetScreen({super.key});

  @override
  State<StudentDateSheetScreen> createState() => _StudentDateSheetScreenState();
}

class _StudentDateSheetScreenState extends State<StudentDateSheetScreen> {
  final StudentDatesheetController studentDatesheetController =
      Get.find<StudentDatesheetController>();

  @override
  void initState() {
    super.initState();
    studentDatesheetController.fetchDatesheetsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Date Sheet"),
      body: Obx(() {
        if (studentDatesheetController.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (studentDatesheetController.filteredDateSheet.isEmpty) {
          return Center(
              child: Text(
            "No Data found",
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.headingcolor),
          ));
        }
        return ListView(
          padding: EdgeInsets.only(top: 12.h),
          children:
              studentDatesheetController.filteredDateSheet.keys.map((examDay) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    child: Text(
                      "Exam ($examDay)",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.headingcolor),
                    ),
                  ),
                  if (studentDatesheetController.filteredDateSheet[examDay] !=
                          null &&
                      studentDatesheetController
                          .filteredDateSheet[examDay]!.isNotEmpty) ...{
                    ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 14.w)
                          .copyWith(bottom: 12.h),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: studentDatesheetController
                          .filteredDateSheet[examDay]!.length,
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Divider(
                          height: 1.h,
                          thickness: 1.h,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return _dateSheetListView(studentDatesheetController
                            .filteredDateSheet[examDay]![index]);
                      },
                    )
                  }
                ],
              ),
            );
          }).toList(),
        );
      }),
    );
  }
}

Widget _dateSheetListView(Datesheetmodel datesheetData) {
  return Row(
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            (datesheetData.examDate ?? "").toString().split("-").first,
            style: TextStyle(
              height: 0,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            (datesheetData.examDate ?? "").toString().split("-")[1],
            style: TextStyle(
              height: 0,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 10.w,
      ),
      Expanded(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (datesheetData.subjectHead ?? ""),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14.sp,
                    color: AppColors.textfieldhintstycolor,
                  ),
                  Text(
                    (datesheetData.timing ?? "--"),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textfieldhintstycolor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            (datesheetData.syllabus ?? "--"),
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textfieldhintstycolor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ))
    ],
  );
}
