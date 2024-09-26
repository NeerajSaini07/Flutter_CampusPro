import 'package:campuspro/Modal/student_module/exam_analysis_session_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AxisTitles bottombarlist(List<ExamnameModel> exannameforAllexamAnalysis) {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      interval: 1,
      getTitlesWidget: (value, meta) {
        int index = value.toInt();
        if (index >= 0 && index < exannameforAllexamAnalysis.length) {
          return Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(
              exannameforAllexamAnalysis[index]
                  .exam, // Assuming 'exam' is the field that contains the exam name
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.appbuttonColor),
            ),
          );
        }
        return Text('');
      },
    ),
  );
}
