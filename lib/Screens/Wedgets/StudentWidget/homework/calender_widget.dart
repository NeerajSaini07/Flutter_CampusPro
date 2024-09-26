import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:table_calendar/table_calendar.dart';

import 'calendar_style.dart';

Widget buildCalendar(StudentHomeWorkController studentHomeWorkController) {
  return Obx(
    () {
      return TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2050, 12, 31),
        focusedDay: studentHomeWorkController.focuseddate.value,
        calendarFormat: studentHomeWorkController.calendarFormat.value,
        selectedDayPredicate: (day) {
          studentHomeWorkController.gethomeworkbydate();
          return isSameDay(studentHomeWorkController.selectedDay.value, day);
        },
        onFormatChanged: (format) {
          studentHomeWorkController.calendarFormat.value = format;
        },
        eventLoader: (day) {
          return studentHomeWorkController.homeworkdatelist.where((event) {
            if (event.date != null) {
              try {
                final dateParts = event.date!.split(' , ');
                if (dateParts.length == 2) {
                  final monthDayParts = dateParts[0].split(' ');
                  final year = int.parse(dateParts[1].trim());
                  final month = int.parse(monthDayParts[0].trim());
                  final dayOfMonth = int.parse(monthDayParts[1].trim());
                  DateTime eventDate = DateTime(year, month, dayOfMonth);
                  return eventDate.year == day.year &&
                      eventDate.month == day.month &&
                      eventDate.day == day.day;
                } else {
                  return false;
                }
              } catch (e) {
                return false;
              }
            }
            return false;
          }).toList();
        },
        onPageChanged: (focusedDay) {
          studentHomeWorkController.focuseddate.value = focusedDay;
        },
        onDaySelected: (date, focusedDay) {
          if (!isSameDay(studentHomeWorkController.selectedDay.value, date)) {
            studentHomeWorkController.gethomeworkbydate();
            studentHomeWorkController.tableRefresh.value =
                !studentHomeWorkController.tableRefresh.value;
            studentHomeWorkController.selectedDay.value = date;
            studentHomeWorkController.focuseddate.value = focusedDay;
          }
        },
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, day, focusedDay) {
            return calendarCellStyle(
              day,
              isToday: isSameDay(day, DateTime.now()),
              isSelected:
                  isSameDay(day, studentHomeWorkController.selectedDay.value),
            );
          },
          selectedBuilder: (context, day, focusedDay) {
            return calendarCellStyle(
              day,
              isToday: isSameDay(day, DateTime.now()),
              isSelected: true,
            );
          },
          todayBuilder: (context, day, focusedDay) {
            return calendarCellStyle(
              day,
              isToday: true,
              isSelected:
                  isSameDay(day, studentHomeWorkController.selectedDay.value),
            );
          },
        ),
        calendarStyle: CalendarStyle(
          markersMaxCount: 1,
          selectedDecoration: BoxDecoration(
            color: AppColors.warningColor,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            border: Border.all(width: 1.5.w, color: AppColors.appbuttonColor),
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
      );
    },
  );
}
