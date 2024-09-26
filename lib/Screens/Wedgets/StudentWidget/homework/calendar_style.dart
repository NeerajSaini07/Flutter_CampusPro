import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget calendarCellStyle(DateTime day,
    {required bool isToday, required bool isSelected}) {
  return Container(
    margin: EdgeInsets.all(4.w),
    decoration: BoxDecoration(
      color: isSelected ? Colors.orangeAccent : (isToday ? Colors.white : null),
      border: isToday && !isSelected
          ? Border.all(
              color: AppColors.appbuttonColor,
              width: 2.w,
            )
          : null,
      shape: BoxShape.circle,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${day.day}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight:
                isSelected || isToday ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
