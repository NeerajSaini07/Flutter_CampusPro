import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
import 'package:campuspro/Modal/student_module/exam_test_result_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget studentMarksdetails() {
  final ExamTestExamResultController examResultController =
      Get.find<ExamTestExamResultController>();
  // Filter data based on Subassessment
  List<ExamTestResultModel> subM = [];
  List<ExamTestResultModel> subG = [];
  if (examResultController.testMarksResultList.isNotEmpty) {
    for (var item in examResultController.testMarksResultList) {
      if (item.subAssessment == "M") {
        subM.add(item);
      } else if (item.subAssessment == "G") {
        subG.add(item);
      }
    }
  }
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (subM.isNotEmpty) ...{
        buildTableM(
          subM,
        ),
      },
      if (subG.isNotEmpty) ...{
        SizedBox(
          height: 16.h,
        ),
        buildTableM(subG, isThisGradeTable: true),
      }
    ],
  );
  return Container(
    height: examResultController.testMarksResultList.length <= 1
        ? 100.h
        : (examResultController.testMarksResultList.length * 41.h) + 40.h,
    decoration: BoxDecoration(border: Border.all(width: 0.1)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 30.h,
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColors.appbuttonColor),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Subject",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whitetextcolor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Max Marks",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whitetextcolor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whitetextcolor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Grade",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whitetextcolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: examResultController.testMarksResultList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        examResultController
                            .testMarksResultList[index].subjectName
                            .toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackcolor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        examResultController.testMarksResultList[index].maxMarks
                            .toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackcolor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        examResultController.testMarksResultList[index].total
                            .toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackcolor,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        examResultController.testMarksResultList[index].grades
                            .toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackcolor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildTableM(List<ExamTestResultModel> data,
    {bool isThisGradeTable = false}) {
  data.sort((a, b) => a.displayOrderNo.compareTo(b.displayOrderNo));
  return DataTable(
    headingRowColor: MaterialStateProperty.all(AppColors.appbuttonColor),
    headingTextStyle: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: AppColors.whitetextcolor,
    ),
    headingRowHeight: 32.sp,
    dataRowMinHeight: 32.sp,
    dataRowMaxHeight: 45.sp,
    dataTextStyle: TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.blackcolor,
    ),
    horizontalMargin: 10.w,
    columnSpacing: 4.w,
    border: TableBorder.symmetric(outside: const BorderSide(width: 0.1)),
    columns: [
      const DataColumn(label: Text('Subject')),
      if (!isThisGradeTable) ...{
        const DataColumn(label: Text('Max Marks')),
        const DataColumn(label: Text('Total')),
      },
      const DataColumn(label: Text('Grade')),
    ],
    rows: data
        .map((item) => DataRow(cells: [
              DataCell(ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: Get.width * (!isThisGradeTable ? 0.25 : 0.5),
                    minWidth: Get.width * (!isThisGradeTable ? 0.25 : 0.5)),
                child: Text(
                  maxLines: 2,
                  item.subjectName.toString(),
                ),
              )),
              if (!isThisGradeTable) ...{
                DataCell(ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: Get.width * 0.25, minWidth: Get.width * 0.25),
                  child: Text(
                    maxLines: 2,
                    item.maxMarks.toString(),
                  ),
                )),
                DataCell(ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: Get.width * 0.15, minWidth: Get.width * 0.15),
                    child: Text(maxLines: 2, item.total.toString()))),
              },
              DataCell(ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: Get.width * (!isThisGradeTable ? 0.15 : 0.3),
                      minWidth: Get.width * (!isThisGradeTable ? 0.15 : 0.3)),
                  child: Text(maxLines: 2, item.grades.toString()))),
            ]))
        .toList(),
  );
}
