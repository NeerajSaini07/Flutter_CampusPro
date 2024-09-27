// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/StudentControllers/transportdetail_controller.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportdetailScreen extends StatefulWidget {
  TransportdetailScreen({super.key});

  @override
  State<TransportdetailScreen> createState() => _TransportdetailScreenState();
}

class _TransportdetailScreenState extends State<TransportdetailScreen> {
  final _controller = Get.find<TransportdetailController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.fetchtransportData();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitetextcolor,
      appBar: customAppBar(context, title: "Transport"),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          final pickupinfo = _controller.pickinfo.isNotEmpty
              ? _controller.pickinfo.first
              : null;
          final studentinfo =
              _controller.info.isNotEmpty ? _controller.info.first : null;
          final dropinfo = _controller.dropinfoo.isNotEmpty
              ? _controller.dropinfoo.first
              : null;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (studentinfo != null)
                    buildstudentCard('Student Info', [
                      _buildRow(
                          'Admission No', studentinfo.admNo, 'Mobile No', ""),
                      _buildRow('Student Name', studentinfo.stName,
                          'Father Name', studentinfo.fatherName),
                    ]),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (pickupinfo == null && dropinfo == null)
                    _buildText('Transport facility not available',
                        isError: true),
                  if (pickupinfo != null)
                    _buildStyledCard('Pickup Route', pickupinfo.busNo, [
                      _buildRow('Pickup Route', pickupinfo.routeName,
                          'Bus Reg No', pickupinfo.regNo),
                      _buildRow('Driver Name', pickupinfo.driverName,
                          'Driver Mob No', pickupinfo.driverMobileNo),
                      _buildRow('Conductor Name', pickupinfo.conductorName,
                          'Conductor Mob No', pickupinfo.conductorMobileNo),
                    ]),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (dropinfo != null)
                    _buildStyledCard('Drop Route', "", [
                      _buildRow('Drop Route', dropinfo.routeName, 'Bus Reg No',
                          dropinfo.busNo),
                      _buildRow('Driver Name', dropinfo.driverName,
                          'Driver Mob No', dropinfo.driverMobileNo),
                      _buildRow('Conductor Name', dropinfo.conductorName,
                          'Conductor Mob No', dropinfo.conductorMobileNo),
                    ]),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildStyledCard(
      String title, String subtitle, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whitetextcolor,
          boxShadow: [
            CommonFunctions.commonsadhow(),
          ],
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appbuttonColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  margin: EdgeInsets.only(top: 1.h),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 97, 131, 245),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon/Shuttle bus.png',
                        // color: AppColors.whitetextcolor, // Path to your image
                        width: 30.w, // Set the width of the image
                        height: 30.w, // Set the height of the image
                        fit: BoxFit.contain, // Adjust the fit as needed
                      ),
                      // Icon(Icons.directions_bus,
                      //     color: AppColors.whitetextcolor, size: 20.w),
                      SizedBox(width: 2.w), // Add spacing between icon and text
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whitetextcolor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 12.h),
            ...children
          ],
        ),
      ),
    );
  }

  Widget buildstudentCard(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whitetextcolor,
          boxShadow: [
            CommonFunctions.commonsadhow(),
          ],
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.appbuttonColor,
              ),
            ),
            SizedBox(height: 8.h),
            ...children
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String leftLabel, String leftValue, String rightLabel,
      String rightValue) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: _buildTextLabelWithTap('$leftLabel:', leftValue),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildTextLabelWithTap('$rightLabel:', rightValue),
          ),
        ],
      ),
    );
  }

  Widget _buildTextLabelWithTap(String label, String value) {
    final isMobileNumber =
        RegExp(r'^\d{10}$').hasMatch(value); // Simple check for mobile number

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
        SizedBox(height: 4.h),
        GestureDetector(
          onTap: isMobileNumber ? () => _makePhoneCall(value) : null,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: isMobileNumber
                  ? Colors.blue
                  : Colors.black, // Color to indicate it's clickable
              // decoration: isMobileNumber ? TextDecoration.underline : null,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTextLabel(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400),
          overflow: TextOverflow.ellipsis, // Handle long text overflow
        ),
      ],
    );
  }

  Widget _buildText(String text, {bool isError = false}) {
    return Padding(
      padding: EdgeInsets.all(10.r),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: isError ? FontWeight.bold : FontWeight.normal,
          color: isError ? Colors.red : Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
