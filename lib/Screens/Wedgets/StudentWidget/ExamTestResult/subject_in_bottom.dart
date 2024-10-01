// ignore_for_file: non_constant_identifier_names

import 'package:campuspro/Modal/student_module/exam_test_result_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AxisTitles bottomListForResultGraph(
    List<ExamTestResultModel> subject, BuildContext context) {
  return AxisTitles(
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 40.h,
      interval: 1,
      getTitlesWidget: (value, meta) {
        int index = value.toInt();

        if (index >= 0 && index < subject.length) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.16,
            child: Text(
              subject[index].subjectName,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize:
                    MediaQuery.of(context).size.width < 380 ? 10.sp : 8.sp,
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
