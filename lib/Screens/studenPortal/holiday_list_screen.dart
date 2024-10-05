import 'package:campuspro/Controllers/StudentControllers/holiday_calender_controller.dart';
import 'package:campuspro/Modal/student_module/holiday_list_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HolidayListScreen extends StatelessWidget {
  const HolidayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentHolidayAndCalendarController holidayController =
        Get.find<StudentHolidayAndCalendarController>();
    return Scaffold(
        appBar: customAppBar(context, title: "Holidays"),
        body: FutureBuilder<List<StudentHolidayModel>>(
          future: holidayController.getStudentHolidayList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (snapshot.hasError) {
              return const Center(child: Text('An error occurred'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              final holidayData = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ColoredBox(
                    color: Colors.blueGrey.withOpacity(0.2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Enjoy your ${holidayData.length} holidays this academic year!",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.appbuttonColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 12.w),
                      itemCount: holidayData.length,
                      itemBuilder: (context, index) {
                        return _holidayListCard(
                            date: holidayData[index].date ?? "",
                            title: holidayData[index].title ?? "");
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }

  Widget _holidayListCard({required String date, required String title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border(
                          left: BorderSide(
                              width: 3.w, color: AppColors.leavecolor)),
                      color: AppColors.leavecolor.withOpacity(0.5),
                    ),
                    child: Column(
                      children: [
                        Text(
                          CommonFunctions.formatDateString(date).first,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appbuttonColor),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          CommonFunctions.formatDateString(date).last,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.appbuttonColor),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.appbuttonColor),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Divider(
                            height: 2.h,
                            thickness: 1.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            date,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textfieldhintstycolor),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
