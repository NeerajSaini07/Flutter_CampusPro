import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

BarChartGroupData displayescoreWidgets(x, obtainmarks, maxmarks) {
  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();
  return BarChartGroupData(
    showingTooltipIndicators: [0, 1],
    x: x,
    barRods: [
      BarChartRodData(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(2.r),
          topLeft: Radius.circular(2.r),
        ),
        toY: obtainmarks,
        color: exameAnalysisController.colorplateforsingleexam[0],
        width: 18.w,
      ),
      BarChartRodData(
        toY: maxmarks,
        color: exameAnalysisController.colorplateforsingleexam[2],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(2.r),
          topLeft: Radius.circular(2.r),
        ),
        width: 18.w,
      ),
    ],
  );
}
