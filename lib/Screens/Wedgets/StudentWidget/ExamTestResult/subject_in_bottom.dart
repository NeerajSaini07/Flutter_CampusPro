// ignore_for_file: non_constant_identifier_names

import 'package:campuspro/Modal/student_module/exam_test_result_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AxisTitles bottomListForResultGraph(List<ExamTestResultModel> subject) {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 30.h,
      interval: 1,
      getTitlesWidget: (value, meta) {
        int index = value.toInt();

        if (index >= 0 && index < subject.length) {
          return Container(
            alignment: Alignment.center,
            width: 60,
            child: Text(
              subject[index].subjectName,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.appbuttonColor,
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    ),
  );
}
