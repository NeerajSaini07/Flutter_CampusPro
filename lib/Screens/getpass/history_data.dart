// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/getpass/history_details_page.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VisitorHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.loginscafoldcoolr,
        title: Text("Vistor History"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomeHeight(20.h),
            Text(
              "Today Vistor List",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 18.sp),
            ),
            CustomeHeight(20.h),
            Expanded(
              child: FutureBuilder<List<VisitorHistoryModal>>(
                future: getPassController.getVisitorHistory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var visitor = snapshot.data![index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 28.w,
                            backgroundImage: NetworkImage(
                                visitor.visitorImagePath.toString()),
                            onBackgroundImageError: (error, stackTrace) {},
                            child: visitor.visitorImagePath!.isEmpty
                                ? Icon(Icons.person)
                                : null,
                          ),
                          title: Text(
                            visitor.visitorName.toString(),
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: AppColors.appbuttonColor),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return HistoryDetails(index: index);
                                },
                              ));
                            },
                            child: Text(
                              "View",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
