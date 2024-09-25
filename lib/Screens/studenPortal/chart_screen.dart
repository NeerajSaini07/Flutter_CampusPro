import 'dart:math' as math;

import 'package:campuspro/Controllers/StudentControllers/leave_controller.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BarChartSample7 extends StatefulWidget {
  const BarChartSample7({super.key});
  final shadowColor = const Color(0xFFCCCCCC);
  @override
  State<BarChartSample7> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends State<BarChartSample7> {
  final StudentLeaveController leaveController =
      Get.find<StudentLeaveController>();

  BarChartGroupData generateBarGroup(
    int x,
    double present,
    double absent,
    double leave,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        if (leave != 0)
          BarChartRodData(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.w), topRight: Radius.circular(2.w)),
            toY: leave,
            color: AppColors.appbuttonColor,
            width: 10.w,
          ),
        if (absent != 0)
          BarChartRodData(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.w), topRight: Radius.circular(2.w)),
            toY: absent,
            color: AppColors.warningColor,
            width: 10.w,
          ),
        BarChartRodData(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.w), topRight: Radius.circular(2.w)),
          toY: present,
          color: AppColors.successColor,
          width: 10.w,
        ),
      ],
      showingTooltipIndicators:
          leaveController.touchedGroupIndex.value == x ? [0] : [],
    );
  }

  @override
  void initState() {
    super.initState();
    leaveController.getStudentAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AspectRatio(
          aspectRatio: 1.4,
          child: Obx(
            () => BarChart(
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
                              color: leaveController.touchedGroupIndex.value ==
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
                barGroups:
                    leaveController.studentAttendanceChartData.entries.map((e) {
                  final index = leaveController.studentAttendanceChartData.keys
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
                    getTooltipItem: (
                      BarChartGroupData group,
                      int groupIndex,
                      BarChartRodData rod,
                      int rodIndex,
                    ) {
                      return BarTooltipItem(
                        rod.toY.toString(),
                        TextStyle(
                          fontWeight: FontWeight.w500,
                          color: rod.color,
                          fontSize: 16.sp,
                          shadows: const [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 12,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  touchCallback: (event, response) {
                    if (event.isInterestedForInteractions &&
                        response != null &&
                        response.spot != null) {
                      final touchedIndex = response.spot!.touchedBarGroupIndex;
                      leaveController.updateTouchedGroupIndex(touchedIndex);
                      final barGroup = response.spot!.touchedBarGroup;
                      final rodIndex = response.spot!.touchedRodDataIndex;
                      final rod = barGroup.barRods[rodIndex];
                      String touchedValue;
                      if (rod.color == AppColors.successColor) {
                        touchedValue = 'Present: ${rod.toY}';
                      } else if (rod.color == AppColors.warningColor) {
                        touchedValue = 'Absent: ${rod.toY}';
                      } else {
                        touchedValue = 'Leave: ${rod.toY}';
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
      floatingActionButton: Obx(() {
        return Visibility(
          visible: leaveController.touchedGroupIndex.value != -1,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: Text(leaveController.touchedValue.value),
          ),
        );
      }),
    );
  }
}
