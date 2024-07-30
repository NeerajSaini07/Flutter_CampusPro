// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:campuspro/Screens/Wedgets/custom_width.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryDetails extends StatelessWidget {
  final index;
  const HistoryDetails({required this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primarycolor,
        centerTitle: false,
        title: const Text(
          "Vistor Detail",
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          12), // Adjust this for rounded corners
                      child: Image.network(
                        VisitorHistory
                            .visitorHistoryListDetails[index].visitorImagePath
                            .toString(),
                        width: 160, // Adjust width as needed
                        height: 160, // Adjust height as needed
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CustomeHeight(8.h),
                  Text(
                    VisitorHistory.visitorHistoryListDetails[index].visitorName
                        .toString(),
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    VisitorHistory.visitorHistoryListDetails[index].id
                        .toString(),
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              CustomeHeight(16.h),
              buildInfoCard(
                Icons.location_on,
                'Address',
                VisitorHistory.visitorHistoryListDetails[index].visitorAddress
                    .toString(),
              ),
              buildInfoCard(
                  Icons.phone,
                  'Mobile No',
                  VisitorHistory.visitorHistoryListDetails[index].number
                      .toString()),
              buildInfoCard(
                  Icons.access_time,
                  'Entry Time',
                  VisitorHistory.visitorHistoryListDetails[index].entryTime
                      .toString()),
              buildInfoCard(
                  Icons.exit_to_app,
                  'Exit Time',
                  VisitorHistory.visitorHistoryListDetails[index].exitTime
                      .toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(IconData icon, String label, String value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.w),
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.appbuttonColor),
              customWidth(8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    CustomeHeight(4.h),
                    Text(
                      value,
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
