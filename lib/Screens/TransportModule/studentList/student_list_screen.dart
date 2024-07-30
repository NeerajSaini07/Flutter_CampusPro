// ignore_for_file: invalid_use_of_protected_member
import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:campuspro/Controllers/transport_studentlist_controller.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TransportStudentList extends StatelessWidget {
  const TransportStudentList({super.key});

  @override
  Widget build(BuildContext context) {
    final TransportStudentListController transportStudentListController =
        Get.find<TransportStudentListController>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        centerTitle: false,
        title: const Text(
          "Student List",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        controller: transportStudentListController.scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeHeight(10.h),
              Text("Select your route and area to find your students.",
                  style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appbuttonColor)),
              CustomeHeight(20.h),
              Text("Select Bus Route : ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  )),
              CustomeHeight(6.h),
              Obx(
                () => CustomDropdown<String>(
                  hintText: 'Select Bus Route',
                  items: transportStudentListController.routeList.value
                      .map((e) => e.routeName)
                      .toList(),
                  excludeSelected: false,
                  decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(
                          width: 0.5, color: AppColors.primarycolor)),
                  onChanged: (saveData) {
                    log('changing value to: $saveData');
                    int rId = transportStudentListController.routeList.value
                        .firstWhere((route) => route.routeName == saveData)
                        .routeID;
                    transportStudentListController.setSelectedRoute(rId);
                    transportStudentListController
                        .getTransportAreaDropDown(rId);
                    transportStudentListController
                        .scrollToTop(45.h + (2 * 26.sp));
                  },
                ),
              ),
              CustomeHeight(14.h),
              Text("Choose Area : ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  )),
              CustomeHeight(6.h),
              Obx(() {
                return CustomDropdown<String>.search(
                  hintText: 'Choose Area',
                  items: transportStudentListController.areaList.value
                      .map((e) => e.areaName)
                      .toList(),
                  excludeSelected: false,
                  decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(
                          width: 0.5, color: AppColors.primarycolor)),
                  onChanged: (saveData) {
                    log('changing value to: $saveData');
                    int aId = transportStudentListController.areaList.value
                        .firstWhere((area) => area.areaName == saveData)
                        .areaID;
                    transportStudentListController.selectedAreaId(aId);
                    transportStudentListController.scrollToTop(0);
                  },
                );
              }),
              CustomeHeight(20.h),
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (transportStudentListController
                                  .selectedRouteId.value !=
                              0 &&
                          transportStudentListController.selectedAreaId.value !=
                              0) {
                        transportStudentListController
                            .getTransportStudentListDetail();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: (transportStudentListController
                                        .selectedRouteId.value !=
                                    0 &&
                                transportStudentListController
                                        .selectedAreaId.value !=
                                    0)
                            ? AppColors.primarycolor
                            : Colors.grey[350],
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Text(
                      "View Student List",
                      style: TextStyle(
                          color: (transportStudentListController
                                          .selectedRouteId.value !=
                                      0 &&
                                  transportStudentListController
                                          .selectedAreaId.value !=
                                      0)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16.sp),
                    ),
                  ),
                ),
              ),
              CustomeHeight(MediaQuery.sizeOf(context).height * 0.7),
            ],
          ),
        ),
      ),
    );
  }
}
