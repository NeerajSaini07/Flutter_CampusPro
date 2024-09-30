import 'package:campuspro/Controllers/StudentControllers/calendar_controller.dart';
import 'package:campuspro/Modal/student_module/calendar_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentCalendarScreen extends StatefulWidget {
  const StudentCalendarScreen({super.key});

  @override
  State<StudentCalendarScreen> createState() => _StudentCalendarScreenState();
}

class _StudentCalendarScreenState extends State<StudentCalendarScreen> {
  final StudentCalendarController calendarController =
      Get.put(StudentCalendarController());

  @override
  void initState() {
    super.initState();

    calendarController.selectedDay = DateTime.now().obs;
    calendarController.focusedDay = DateTime.now().obs;
    calendarController.studentCalendarData =
        <DateTime, Map<String, dynamic>>{}.obs;
    calendarController.eventsForDay = <DateTime, CalendarEventModel>{}.obs;
    calendarController.getStudentCalendarData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, title: "Calendar"),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6.w,
          ),
          child: Column(
            children: [
              Obx(
                () => calendarController.studentCalendarData.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                            color: AppColors.whitetextcolor,
                            boxShadow: [
                              CommonFunctions.commonsadhow(),
                            ],
                            borderRadius: BorderRadius.circular(10.r)),
                        margin: EdgeInsets.symmetric(vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w)
                                    .copyWith(top: 8.h),
                                child: Wrap(
                                  spacing: 8.w,
                                  runSpacing: 4.h,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    _chartLabel(_getColorHeading("P").first,
                                        _getColorHeading("P").last),
                                    _chartLabel(_getColorHeading("A").first,
                                        _getColorHeading("A").last),
                                    _chartLabel(_getColorHeading("L").first,
                                        _getColorHeading("L").last),
                                    _chartLabel(_getColorHeading("H").first,
                                        _getColorHeading("H").last)
                                  ],
                                ),
                              ),
                            ),
                            TableCalendar(
                              firstDay: DateTime.utc(2020, 1, 1),
                              lastDay: DateTime.utc(2030, 12, 31),
                              calendarFormat: CalendarFormat.month,
                              headerStyle: const HeaderStyle(
                                formatButtonVisible: false,
                              ),
                              focusedDay: calendarController.focusedDay.value,
                              selectedDayPredicate: (day) {
                                return calendarController.selectedDay.value
                                    .isAtSameMomentAs(day);
                              },
                              calendarStyle: const CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  shape: BoxShape.circle,
                                ),
                                selectedDecoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  shape: BoxShape.circle,
                                ),
                                markerSize: 0,
                              ),
                              onDaySelected: (selectedDay, focusedDay) {
                                calendarController
                                    .updateSelectedDay(selectedDay);
                              },
                              onPageChanged: (focusedDay) {
                                calendarController.focusedDay.value =
                                    focusedDay;
                              },
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, day, focusedDay) {
                                  return _calendarCellStyle(
                                      day, calendarController);
                                },
                                todayBuilder: (context, day, focusedDay) {
                                  return _calendarCellStyle(
                                      day, calendarController,
                                      isToday: true);
                                },
                                selectedBuilder: (context, day, focusedDay) {
                                  return _calendarCellStyle(
                                      day, calendarController,
                                      isSelected: true);
                                },
                                outsideBuilder: (context, day, focusedDay) {
                                  return const SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.8,
                        child:
                            const Center(child: CircularProgressIndicator())),
              ),
              Expanded(
                child: Obx(() {
                  var events = calendarController.eventsForDay.value;
                  if (events.isEmpty &&
                      calendarController.studentCalendarData.isNotEmpty) {
                    return const Center(child: Text('No events for this day.'));
                  } else if (events.isEmpty) {
                    return const SizedBox();
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: events.entries.toList().map((entry) {
                        return entry.value.circularDots!.isNotEmpty
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 4.w, right: 14.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          entry.key.day.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.blacktextcolor),
                                        ),
                                        Text(
                                          DateFormat('MMM').format(entry.key),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.blacktextcolor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: entry.value.circularDots!.length,
                                    separatorBuilder: (context, index) =>
                                        Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ColoredBox(
                                            color: AppColors.appbuttonColor,
                                            child: SizedBox(
                                              height: 20.h,
                                              width: 2.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    itemBuilder: (context, index) {
                                      if (entry.value.circularDots![index]
                                              .toString() ==
                                          "L") {
                                        return _calendarEventCard(
                                            type: entry
                                                .value.circularDots![index]
                                                .toString(),
                                            desc: entry.value.leave ?? "");
                                      } else if (entry
                                              .value.circularDots![index]
                                              .toString() ==
                                          "H") {
                                        return _calendarEventCard(
                                            type: entry
                                                .value.circularDots![index]
                                                .toString(),
                                            desc: entry.value.holiday ?? "");
                                      } else if (entry
                                              .value.circularDots![index]
                                              .toString() ==
                                          "E") {
                                        return _calendarEventCard(
                                            type: entry
                                                .value.circularDots![index]
                                                .toString(),
                                            desc: entry.value.event ?? "");
                                      }
                                      return _calendarEventCard(
                                          type: entry.value.circularDots![index]
                                              .toString());
                                    },
                                  ))
                                ],
                              )
                            : const SizedBox();
                      }).toList(),
                    ),
                  );
                }),
              )
            ],
          ),
        ));
  }

  Widget _chartLabel(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 5.r,
          backgroundColor: color,
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.blackcolor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _calendarCellStyle(
      DateTime day, StudentCalendarController calendarController,
      {bool isToday = false, bool isSelected = false}) {
    final List circularDots = calendarController.getCircularDotsListForDay(day);
    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: () {
        if (isToday) {
          return BoxDecoration(
            border: Border.all(
              color: AppColors.appbuttonColor,
              width: 2.0,
            ),
            shape: BoxShape.circle,
          );
        } else if (isSelected) {
          return BoxDecoration(
            border: Border.all(
              color: AppColors.appbuttonColor,
              width: 2.0,
            ),
            color: () {
              if (circularDots.isNotEmpty) {
                return _getColorHeading(circularDots.first.toString()).first;
              } else {
                return null;
              }
            }(),
            shape: BoxShape.circle,
          );
        } else if (circularDots.isNotEmpty) {
          return BoxDecoration(
            color: () {
              return _getColorHeading(circularDots.first.toString()).first;
            }(),
            shape: BoxShape.circle,
          );
        } else {
          return null;
        }
      }(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${day.day}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var item in circularDots) ...{
                Container(
                  margin: const EdgeInsets.only(top: 4.0),
                  width: 4.w,
                  height: 4.w,
                  decoration: BoxDecoration(
                    color: () {
                      return _getColorHeading(item.toString()).first;
                    }(),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
              }
            ],
          ),
        ],
      ),
    );
  }

  Widget _calendarEventCard(
      {required String type, String desc = "", double topPadding = 0}) {
    return Container(
      margin: EdgeInsets.only(top: topPadding),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      decoration: BoxDecoration(
          color: AppColors.whitetextcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              // spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border(
              left: BorderSide(
                  width: 4.w,
                  color: () {
                    return _getColorHeading(type).first;
                  }())),
          borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _getColorHeading(type).last,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blacktextcolor),
          ),
          if (desc.isNotEmpty)
            Text(
              desc,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textfieldhintstycolor),
            ),
        ],
      ),
    );
  }

  List _getColorHeading(String type) {
    switch (type) {
      case "P":
        return [AppColors.successColor, "Present"];
      case "A":
        return [AppColors.warningColor, "Absent"];
      case "L":
        return [AppColors.leavecolor, "Leave"];
      case "H":
        return [AppColors.appbuttonColor.withOpacity(0.5), "Holiday"];
      default:
        return [AppColors.logoutBg, ""];
    }
  }
}
