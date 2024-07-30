// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Screens/getpass/gatepass_history_list.dart';
import 'package:campuspro/Screens/getpass/history_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future showGetpassDilaog(BuildContext context) {
  final GetPassController getPassController = Get.find<GetPassController>();
  return showDialog(
    context: context,
    useSafeArea: true,
    builder: (BuildContext context) {
      return AlertDialog(
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal()),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        insetPadding: EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 80.h),
        backgroundColor: Colors.white,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Builder(
              builder: (context) {
                return SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Adjust according to your content
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          // getPassController.getpassHistory();
                          Get.back();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GatePassHistoryListScreen();
                          }));
                          // shoGetPasslist();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Use primary for background color
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 16.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          "Show Today's Gates Pass History",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          getPassController.showvisitorDetails.value = false;
                          await Future.delayed(Duration(microseconds: 10));
                          getPassController.showvisitoryHistory.value = false;
                          getPassController.showOTPwidget.value = false;
                          Get.back();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return VisitorHistoryPage();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue, // Use primary for background color
                          padding: EdgeInsets.symmetric(
                            horizontal: 34.w,
                            vertical: 16.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          "Show Today's Visitor History",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: -70,
              right: 0,
              child: IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ImageIcon(
                    AssetImage(
                      "assets/images/close.png",
                    ),
                    color: Colors.red,
                    size: 35.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
