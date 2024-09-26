import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AxisTitles bottombarlist(exannameforAllexamAnalysis) {
  return AxisTitles(
    sideTitles: SideTitles(
      reservedSize: 60.h,
      showTitles: true,
      interval: 1,
      getTitlesWidget: (value, meta) {
        int index = value.toInt();
        if (index >= 0 && index < exannameforAllexamAnalysis.length) {
          return Padding(
            padding: EdgeInsets.only(left: 10.w, top: 10.h),
            child: Transform.rotate(
              angle: -0.5,
              child: Text(
                exannameforAllexamAnalysis[index],
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.appbuttonColor),
              ),
            ),
          );
        }
        return const Text('');
      },
    ),
  );
}
