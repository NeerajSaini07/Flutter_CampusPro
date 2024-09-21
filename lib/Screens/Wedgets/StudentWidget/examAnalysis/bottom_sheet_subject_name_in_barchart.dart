// ignore_for_file: non_constant_identifier_names

import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AxisTitles bottom_list_for_barchart() {
  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 34.h,
      interval: 1,
      getTitlesWidget: (value, meta) {
        int index = value.toInt();
        if (index >= 0 &&
            index < exameAnalysisController.singleExamDataList.length) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exameAnalysisController.singleExamDataList[index].subjectName,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appbuttonColor),
              ),
              Text(
                "(${exameAnalysisController.singleExamDataList[index].exam})",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appbuttonColor),
              ),
            ],
          );
        }
        return const Text('');
      },
    ),
  );
}
