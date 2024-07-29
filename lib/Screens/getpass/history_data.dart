// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/getpass/history_details_page.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VisitorHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getPassController.getVisitorHistory();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text('Visitor History List'),
          backgroundColor: AppColors.primarycolor,
        ),
        body: Obx(
          () => getPassController.vistorData.value.isEmpty
              ? Center(child: Text('No data available'))
              : ListView.separated(
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => VisitorDetailScreen(
                          //       visitor: visitors,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Text(visitor.visitorName ?? "N/A"),
                      ),
                      subtitle: Text('Status: ${visitor.status}'),
                      trailing: visitor.exitTime != null &&
                              visitor.exitTime!.isNotEmpty
                          ? null
                          : ElevatedButton(
                              onPressed: () {
                                getPassController.markVisitorExitApi(index);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appbuttonColor),
                              child: Text('Exit ${visitor.exitTime}',
                                  style: TextStyle(color: Colors.white)),
                            ),
                    );
                  },
                  separatorBuilder: (BuildContext context, index) => Divider(),
                ),
        )
        // vistorData.isEmpty ? Center(child: Text('No data available')):

        // FutureBuilder<List<VisitorHistoryModal>>(
        //     future: getPassController.getVisitorHistory(),
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator());
        //       } else if (snapshot.hasError) {
        //         return Center(child: Text('Error: ${snapshot.error}'));
        //       } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        //         return Center(child: Text('No data available'));
        //       } else {
        //         return ListView.separated(
        //           itemCount: snapshot.data!.length,
        //           itemBuilder: (context, index) {
        //             final visitor = snapshot.data![index];
        //             return ListTile(
        //               leading: CircleAvatar(
        //                 radius: 28.w,
        //                 backgroundImage:
        //                     NetworkImage(visitor.visitorImagePath.toString()),
        //                 onBackgroundImageError: (error, stackTrace) {},
        //                 child: visitor.visitorImagePath!.isEmpty
        //                     ? Icon(Icons.person)
        //                     : null,
        //               ),
        //               title: GestureDetector(
        //                 onTap: () {
        //                   // Navigator.push(
        //                   //   context,
        //                   //   MaterialPageRoute(
        //                   //     builder: (context) => VisitorDetailScreen(
        //                   //       visitor: visitors,
        //                   //     ),
        //                   //   ),
        //                   // );
        //                 },
        //                 child: Text(visitor.visitorName ?? "N/A"),
        //               ),
        //               subtitle: Text('Status: ${visitor.status}'),
        //               trailing: visitor.exitTime != null &&
        //                       visitor.exitTime!.isNotEmpty
        //                   ? null
        //                   : ElevatedButton(
        //                       onPressed: () {
        //                         getPassController.markVisitorExitApi(index);
        //                       },
        //                       style: ElevatedButton.styleFrom(
        //                           backgroundColor: AppColors.appbuttonColor),
        //                       child: Text('Exit ${visitor.exitTime}',
        //                           style: TextStyle(color: Colors.white)),
        //                     ),
        //             );
        //           },
        //           separatorBuilder: (BuildContext context, index) =>
        //               Divider(),
        //         );
        //       }
        //     }),
        );
  }
}
