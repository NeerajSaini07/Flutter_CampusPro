// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Screens/getpass/history_details_page.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/common_appbar.dart';

class VisitorHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getPassController.getVisitorHistory();
    });
    return Scaffold(
        appBar: customAppBar(context),
        body: Obx(
          () => getPassController.vistorData.value.isEmpty
              ? Center(child: Text('No data available'))
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  itemCount: getPassController.vistorData.value.length,
                  itemBuilder: (context, index) {
                    final visitor = getPassController.vistorData.value[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 28.w,
                        backgroundImage:
                            NetworkImage(visitor.visitorImagePath.toString()),
                        onBackgroundImageError: (error, stackTrace) {},
                        child: visitor.visitorImagePath!.isEmpty
                            ? Icon(Icons.person)
                            : null,
                      ),
                      title: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryDetails(
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Text(visitor.visitorName ?? "N/A"),
                      ),
                      subtitle: Text('Address: ${visitor.visitorAddress}'),
                      trailing: visitor.exitTime != null &&
                              visitor.exitTime!.isNotEmpty
                          ? null
                          : ElevatedButton(
                              onPressed: () {
                                getPassController.markVisitorExitApi(index);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appbuttonColor),
                              child: Text('Exit',
                                  style: TextStyle(color: Colors.white)),
                            ),
                    );
                  },
                  separatorBuilder: (BuildContext context, index) => Divider(),
                ),
        ));
  }
}
