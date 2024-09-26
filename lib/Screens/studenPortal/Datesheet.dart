// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, deprecated_member_use

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/datesheet_controller.dart';
import 'package:campuspro/Modal/student_module/student_datesheet_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:get/get.dart';

class Datesheet extends StatelessWidget {
  const Datesheet({super.key});
  @override
  Widget build(BuildContext context) {
    AppbarController appbarController = Get.find<AppbarController>();
    BottomBarController bottomBarController = Get.find<BottomBarController>();

    return WillPopScope(
        onWillPop: () async {
          bottomBarController.selectedBottomNavIndex.value = 0;
          appbarController.appBarName.value = Constant.schoolName;
          return true;
        },
        // final StudentClasssRoomController classsRoomController =
        //     Get.find<StudentClasssRoomController>();
        child: Scaffold(
          appBar: customAppBar(context),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomeHeight(20.h),
                Expanded(child: DatesheetList()),
              ],
            ),
          ),
        ));
  }
}

@override
Widget DatesheetList() {
  return FutureBuilder<List<Datesheetmodel>>(
      future: fetchdatesheetData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available.'));
        } else {
          List<Datesheetmodel> datesheetlist = snapshot.data!;
          return ListView.builder(
              itemCount: datesheetlist.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(5.0),
                  child: Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    datesheetlist[index].timing.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        datesheetlist[index].shift.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      Text(
                                        datesheetlist[index].exam.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                datesheetlist[index].subjectHead.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                datesheetlist[index].syllabus.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                datesheetlist[index].examDate.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
      });
}

Future<List<Datesheetmodel>> fetchdatesheetData() async {
  final StudentDatesheetController studentDatesheetController =
      Get.find<StudentDatesheetController>();
  studentDatesheetController.datesheetsData();

  await Future.delayed(Duration(seconds: 1));

  // Simulate a delay
  return Datesheetl.datesheetlist;
}
