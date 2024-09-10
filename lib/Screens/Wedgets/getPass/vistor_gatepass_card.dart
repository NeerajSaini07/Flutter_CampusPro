import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Screens/getpass/fullscreenImage.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget vistorGatepassListCardWidget(
    {required BuildContext context,
    required GetPassController getPassController,
    required int index,
    String type = "v"}) {
  dynamic visitor;
  if (type == "v") {
    visitor = getPassController.vistorData.value[index];
  } else {
    visitor = getPassController.gatePassHistoryData.value[index];
  }
  return Card(
    color: Colors.white,
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    ),
    elevation: 1,
    child: Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image Part
              ClipRRect(
                borderRadius: BorderRadius.circular(6.w),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return FullScreenImage(
                          image: type == "v"
                              ? visitor.visitorImagePath
                              : visitor.imagePath.toString(),
                        );
                      },
                    ));
                  },
                  child: (type == "v"
                          ? visitor.visitorImagePath!.isEmpty
                          : visitor.imagePath.isEmpty)
                      ? Image.asset(
                          'assets/icon/person_icon.png',
                          width: 100.w,
                          height: 100.w,
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          type == "v"
                              ? visitor.visitorImagePath!.toString()
                              : visitor.imagePath.toString(),
                          fit: BoxFit.fill,
                          width: 100.w,
                          height: 100.w,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/icon/person_icon.png',
                              fit: BoxFit.fill,
                              width: 100.w,
                              height: 100.w,
                            );
                          },
                        ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text.rich(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: type == "v"
                                ? visitor.visitorName ?? "N/A"
                                : visitor.name ?? "N/A",
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: type != "v"
                                ? visitor.passType.toString().toLowerCase() ==
                                        "student"
                                    ? " (${visitor.studentEmployeeName.toString().capitalizeFirst})"
                                    : ""
                                : "",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.appbuttonColor),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: type == "v"
                                ? visitor.visitorAddress ?? "N/A"
                                : visitor.purpose ?? "N/A",
                            style: TextStyle(
                                fontSize: type == "v" ? 8.sp : 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                          ),
                          TextSpan(
                            text: type == "v"
                                ? ""
                                : ' (${visitor.passType ?? "N/A"})',
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.appbuttonColor),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(2.r),
                      onTap: () {
                        if (type == "v") {
                          CommonFunctions.makePhoneCall(
                              visitor.number.toString());
                        } else {
                          CommonFunctions.makePhoneCall(
                              visitor.contactNo.toString());
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 4.h)
                            .copyWith(left: 2.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.call,
                              color: AppColors.appbuttonColor,
                              size: 14.sp,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              type == "v"
                                  ? (visitor.number ?? "N/A")
                                  : (visitor.contactNo ?? "N/A"),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4.w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _entryExitTimeWidget(
                            time: type == "v"
                                ? (visitor.entryTime ?? "N//A").split(' ').last
                                : (visitor.time ?? "N//A"),
                            icon: Icons.arrow_forward,
                            color: Colors.green[200]!),
                        ((type == "v"
                                    ? visitor.exitTime == null
                                    : visitor.toTime == null) ||
                                (type == "v"
                                    ? visitor.exitTime!.isEmpty
                                    : visitor.toTime.isEmpty))
                            ? ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w)
                                            .copyWith(right: 10.w),
                                    backgroundColor: AppColors.appbuttonColor),
                                label: Text(
                                  "Click to exit",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                icon: Container(
                                  padding: EdgeInsets.all(2.sp),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green[200],
                                      border: Border.all(
                                          width: 1.sp, color: Colors.white)),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  if (type == "v") {
                                    getPassController.markVisitorExitApi(index);
                                  } else {
                                    getPassController
                                        .markGatePassExitApi(index);
                                  }
                                },
                              )
                            : _entryExitTimeWidget(
                                time: type == "v"
                                    ? (visitor.exitTime ?? "N//A")
                                        .split(' ')
                                        .last
                                    : visitor.toTime ?? "N/A",
                                icon: Icons.arrow_back,
                                color: Colors.red[200]!),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _entryExitTimeWidget(
    {required String time, required IconData icon, required Color color}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        padding: EdgeInsets.all(4.sp),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(width: 1.sp, color: AppColors.appbuttonColor)),
        child: Icon(
          icon,
          size: 10.sp,
          color: AppColors.appbuttonColor,
        ),
      ),
      SizedBox(
        width: 4.w,
      ),
      Text(
        time,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
            color: AppColors.appbuttonColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600),
      ),
    ],
  );
}
