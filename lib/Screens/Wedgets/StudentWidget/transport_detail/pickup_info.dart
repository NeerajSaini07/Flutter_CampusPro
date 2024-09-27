import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget pickupInfoWidget(pickupinfo) {
  return Card(
    color: AppColors.whitetextcolor,
    margin: EdgeInsets.all(10.r),
    child: Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pick Up Infornmation',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            'Pick Up NO: ${pickupinfo.routeName}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
          Text(
            'Bus Reg No: ${pickupinfo.regNo}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
          Text(
            'Bus No: ${pickupinfo.busNo}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
          Text(
            'Driver Name & No: ${pickupinfo.driverName}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
          Text(
            'Driver No: ${pickupinfo.driverMobileNo}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
          Text(
            'Conductor Name: ${pickupinfo.conductorName}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
          Text(
            'Conductor Mob No: ${pickupinfo.conductorMobileNo}',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    ),
  );
}
