import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:campuspro/Controllers/StudentControllers/leave_controller.dart';
import 'package:campuspro/Modal/student_module/leave_request_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/error_commponet.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentLeaveDetailScreen extends StatefulWidget {
  const StudentLeaveDetailScreen({super.key});

  @override
  State<StudentLeaveDetailScreen> createState() =>
      _StudentLeaveDetailScreenState();
}

class _StudentLeaveDetailScreenState extends State<StudentLeaveDetailScreen> {
  final StudentLeaveController leaveController =
      Get.find<StudentLeaveController>();

  BarChartGroupData generateBarGroup(
    int x,
    double present,
    double absent,
    double leave,
  ) {
    return BarChartGroupData(
      showingTooltipIndicators: [0, 1, 2],
      x: x,
      barRods: [
        if (leave != 0)
          BarChartRodData(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.r), topRight: Radius.circular(2.r)),
            toY: leave,
            color: AppColors.leavecolor,
            width: 20.w,
          ),
        if (absent != 0)
          BarChartRodData(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.r), topRight: Radius.circular(2.r)),
            toY: absent,
            color: AppColors.warningColor,
            width: 20.w,
          ),
        BarChartRodData(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.r), topRight: Radius.circular(2.r)),
          toY: present,
          color: AppColors.successColor,
          width: 20.w,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    leaveController.getStudentAttendanceData();
    leaveController.getStudentLeaveRequestList();
    leaveController.clearTextFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: "Leave Details",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w)
              .copyWith(top: 12.h, bottom: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _attendanceGraphSection(context),
              SizedBox(
                height: 10.h,
              ),
              _attendanceAskForLeaveSection(context),
              SizedBox(
                height: 10.h,
              ),
              _attendanceLeaveRequestSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chartLabel(Color color, String label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h).copyWith(right: 8.w),
      child: Row(
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
      ),
    );
  }

  Widget _attendanceChartViewWidget() {
    return Obx(
      () => Scrollbar(
        thumbVisibility: leaveController.studentAttendanceChartData.length <= 4
            ? false
            : true,
        controller: leaveController.scrollController,
        radius: Radius.circular(20.r),
        thickness: 6.h,
        child: SingleChildScrollView(
          controller: leaveController.scrollController,
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: SizedBox(
              width: leaveController.studentAttendanceChartData.length <= 4
                  ? MediaQuery.sizeOf(context).width * 0.9
                  : MediaQuery.sizeOf(context).width *
                      (leaveController.studentAttendanceChartData.length *
                          0.225),
              height: MediaQuery.sizeOf(context).height * .3,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  borderData: FlBorderData(
                    show: true,
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: AppColors.blackcolor.withOpacity(0.2),
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBelowEverything: true,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 18.w,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          final monthYear = leaveController
                              .studentAttendanceChartData.keys
                              .toList()[index];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              monthYear.split(' ')[0],
                              style: TextStyle(
                                color:
                                    leaveController.touchedGroupIndex.value ==
                                            index
                                        ? Colors.blue
                                        : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColors.blackcolor.withOpacity(0.2),
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: leaveController.studentAttendanceChartData.entries
                      .map((e) {
                    final index = leaveController
                        .studentAttendanceChartData.keys
                        .toList()
                        .indexOf(e.key);
                    final data = e.value;
                    return generateBarGroup(
                      index,
                      data!['Y']!.toDouble(),
                      data['N']!.toDouble(),
                      data['L']!.toDouble(),
                    );
                  }).toList(),
                  maxY: 30,
                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) => Colors.transparent,
                      tooltipMargin: 0,
                      tooltipPadding: EdgeInsets.zero,
                      getTooltipItem: (
                        BarChartGroupData group,
                        int groupIndex,
                        BarChartRodData rod,
                        int rodIndex,
                      ) {
                        return BarTooltipItem(
                          rod.toY.toString(),
                          TextStyle(
                            fontWeight: FontWeight.w700,
                            color: rod.color,
                            fontSize: 10.sp,
                            // shadows: const [
                            //   Shadow(
                            //     color: Colors.black26,
                            //     blurRadius: 12,
                            //   )
                            // ],
                          ),
                        );
                      },
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        final touchedIndex =
                            response.spot!.touchedBarGroupIndex;
                        leaveController.updateTouchedGroupIndex(touchedIndex);
                        final barGroup = response.spot!.touchedBarGroup;
                        final rodIndex = response.spot!.touchedRodDataIndex;
                        final rod = barGroup.barRods[rodIndex];
                        final monthYear = leaveController
                            .studentAttendanceChartData.keys
                            .toList()[touchedIndex];
                        String touchedValue;
                        if (rod.color == AppColors.successColor) {
                          touchedValue = "$monthYear\nPresent: ${rod.toY}";
                        } else if (rod.color == AppColors.warningColor) {
                          touchedValue = '$monthYear\nAbsent: ${rod.toY}';
                        } else {
                          touchedValue = '$monthYear\nLeave: ${rod.toY}';
                        }
                        leaveController.updateTouchedValue(touchedValue);
                      } else {
                        leaveController.resetTouchedGroupIndex();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _leaveRequestListCardView(StudentLeaveRequestModel requestData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
              color: AppColors.whitetextcolor,
              border: Border(
                  left: BorderSide(
                      color: (() {
                        if (requestData.leaveStatus.toString().toLowerCase() ==
                            "pending") {
                          return AppColors.leavecolor;
                        } else if (requestData.leaveStatus
                                .toString()
                                .toLowerCase() ==
                            "accepted") {
                          return AppColors.successColor;
                        }
                        return AppColors.warningColor;
                      }()),
                      width: 3.w)),
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${requestData.leaveType} Leave",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.appbuttonColor),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  if (requestData.leaveStatus!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                      child: ColoredBox(
                        color: (() {
                          if (requestData.leaveStatus
                                  .toString()
                                  .toLowerCase() ==
                              "pending") {
                            return AppColors.leavecolor;
                          } else if (requestData.leaveStatus
                                  .toString()
                                  .toLowerCase() ==
                              "accepted") {
                            return AppColors.successColor;
                          }
                          return AppColors.warningColor;
                        }()),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 2.h),
                          child: Text(
                            requestData.leaveStatus
                                    .toString()
                                    .capitalizeFirst ??
                                "",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.whitetextcolor),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey,
                    size: 16.sp,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    (() {
                      if (requestData.fromDate!.isNotEmpty &&
                          requestData.toDate!.isNotEmpty) {
                        if (requestData.fromDate == requestData.toDate) {
                          return "${requestData.fromDate}";
                        }
                        return "${requestData.fromDate} - ${requestData.toDate}";
                      } else if (requestData.fromDate!.isNotEmpty) {
                        return "${requestData.fromDate}";
                      } else {
                        return "--";
                      }
                    }()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Text(
                    (() {
                      if (requestData.fromDate!.isNotEmpty &&
                          requestData.toDate!.isNotEmpty) {
                        if (requestData.fromDate == requestData.toDate) {
                          return "1 Day";
                        }
                        return "${CommonFunctions.calculateDaysBetween(startDateStr: requestData.fromDate!, endDateStr: requestData.toDate!) + 1} Days";
                      } else {
                        return "--";
                      }
                    }()),
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _attendanceGraphSection(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attendance Graph',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            _chartLabel(AppColors.successColor, "Present"),
            _chartLabel(AppColors.warningColor, "Absent"),
            _chartLabel(AppColors.leavecolor, "Leave"),
            const Spacer(),
            Obx(
              () => Visibility(
                visible: leaveController.touchedGroupIndex.value != -1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                      color: AppColors.appbuttonColor,
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Text(
                    leaveController.touchedValue.value,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whitetextcolor),
                  ),
                ),
              ),
            ),
          ],
        ),
        _attendanceChartViewWidget(),
      ],
    );
  }

  Widget _attendanceLeaveRequestSection(BuildContext context) {
    return Obx(() {
      if (leaveController.stuLeaveRequestList.isNotEmpty) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Requested Leave Status',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            if (leaveController.stuLeaveRequestList.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: leaveController.stuLeaveRequestList.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 12.h,
                ),
                itemBuilder: (context, index) {
                  return _leaveRequestListCardView(
                      leaveController.stuLeaveRequestList[index]);
                },
              )
          ],
        );
      } else {
        return const SizedBox();
      }
    });
  }

  Widget _attendanceAskForLeaveSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ask For Leave',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        //Drop Down Widget
        dropDownTextField(),
        //from and to date widget
        fromAndToDateTextField(),
        //Description TextField
        descriptionTextField(),
        SizedBox(
          height: 8.h,
        ),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)),
                elevation: 0,
                backgroundColor: AppColors.appbuttonColor),
            onPressed: () {
              if (leaveController.validatingTextField()) {
                FocusScope.of(context).unfocus();
                leaveController.applyforStudentLeave();
              }
            },
            child: Obx(
              () => leaveController.circularProgress.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: SizedBox(
                          height: 14.sp,
                          width: 14.sp,
                          child: const CircularProgressIndicator()),
                    )
                  : Text(
                      'Apply Leave',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whitetextcolor),
                    ),
            ),
          ),
        )
      ],
    );
  }

  Widget labelTextForTextField(String label,
      {double bottomSpacing = 0, double topSpacing = 0}) {
    return Padding(
      padding:
          EdgeInsets.only(left: 4.w, bottom: bottomSpacing, top: topSpacing),
      child: Text(label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          )),
    );
  }

  Widget fromAndToDateTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  labelTextForTextField("From : ",
                      bottomSpacing: 2.h, topSpacing: 6.h),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      leaveController.selectDate(context, "from");
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: AppColors.whitetextcolor,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            width: 0.5,
                            color: AppColors.appbuttonColor,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                                leaveController.fromDate.value != null
                                    ? DateFormat('dd-MMM-yyyy')
                                        .format(leaveController.fromDate.value!)
                                    : 'Select Date From',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color:
                                        leaveController.fromDate.value != null
                                            ? AppColors.blackcolor
                                            : AppColors.textfieldhintstycolor)),
                          ),
                          const Icon(Icons.date_range)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  labelTextForTextField("To : ",
                      bottomSpacing: 2.h, topSpacing: 6.h),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.r),
                    onTap: () {
                      if (leaveController.fromDate.value == null) {
                        leaveController.dateErrormsg.value =
                            "Please pick a 'from date' before picking a 'to date'.";
                      } else {
                        leaveController.selectDate(context, "to");
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.whitetextcolor,
                          border: Border.all(
                            width: 0.5,
                            color: AppColors.appbuttonColor,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                                leaveController.toDate.value != null
                                    ? DateFormat('dd-MMM-yyyy')
                                        .format(leaveController.toDate.value!)
                                    : 'Select Date To',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: leaveController.toDate.value != null
                                        ? AppColors.blackcolor
                                        : AppColors.textfieldhintstycolor)),
                          ),
                          const Icon(Icons.date_range)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Obx(() {
          return leaveController.dateErrormsg.value.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: errocommponent(
                      fontsize: 12.sp, errorText: leaveController.dateErrormsg),
                )
              : const SizedBox();
        }),
      ],
    );
  }

  Widget dropDownTextField() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelTextForTextField("Leave Type :", topSpacing: 10.h),
          CustomDropdown<String>(
            hintText: 'Select Leave Type',
            items: leaveController.leaveType.value,
            initialItem: leaveController.selectedLeaveType.value.isEmpty
                ? null
                : (leaveController.selectedLeaveType.value == "S"
                    ? leaveController.leaveType.value[0]
                    : leaveController.leaveType.value[1]),
            excludeSelected: false,
            closedHeaderPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: CustomDropdownDecoration(
                hintStyle: TextStyle(
                    fontSize: 14.sp, color: AppColors.textfieldhintstycolor),
                closedBorderRadius: BorderRadius.circular(8.r),
                closedBorder:
                    Border.all(width: 0.5, color: AppColors.primarycolor)),
            onChanged: (saveData) {
              log('changing value to: $saveData');
              if (saveData.toString().toLowerCase() == "sick leave") {
                leaveController.selectedLeaveType.value = "S";
              } else {
                leaveController.selectedLeaveType.value = "U";
              }
              leaveController.leaveTypeErrormsg.value = "";
            },
          ),
          if (leaveController.leaveTypeErrormsg.value.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: errocommponent(
                  fontsize: 12.sp,
                  errorText: leaveController.leaveTypeErrormsg),
            )
        ],
      ),
    );
  }

  Widget descriptionTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelTextForTextField("Description : ",
            topSpacing: 6.h, bottomSpacing: 2.h),
        TextField(
          textInputAction: TextInputAction.send,
          maxLines: 3,
          controller: leaveController.descriptionController,
          decoration: InputDecoration(
            fillColor: AppColors.whitetextcolor,
            filled: true,
            hintText: 'Description',
            hintStyle: TextStyle(
                fontSize: 14.sp, color: AppColors.textfieldhintstycolor),
            labelStyle: TextStyle(
              fontSize: 14.sp,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  const BorderSide(color: AppColors.primarycolor, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  const BorderSide(color: AppColors.primarycolor, width: 0.5),
            ),
          ),
          onChanged: (value) {
            leaveController.descriptionErrormsg.value = "";
          },
          onSubmitted: (value) {
            if (leaveController.validatingTextField()) {
              log(leaveController.toDate.value.toString());
              log(leaveController.fromDate.value.toString());
              log(leaveController.selectedLeaveType.value.toString());
              log(leaveController.descriptionController.text.toString());
            }
          },
        ),
        Obx(() {
          return leaveController.descriptionErrormsg.value.isNotEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: errocommponent(
                      fontsize: 12.sp,
                      errorText: leaveController.descriptionErrormsg),
                )
              : const SizedBox();
        }),
      ],
    );
  }
}
