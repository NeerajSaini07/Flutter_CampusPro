import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Wedgets/common_appbar.dart';
import 'fullscreenImage.dart';

class VisitorHistoryPage extends StatelessWidget {
  const VisitorHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();

    final AppbarController appbarController = Get.find<AppbarController>();

    return WillPopScope(
      onWillPop: () async {
        appbarController.appBarName.value = Constant.schoolName;
        return true;
      },
      child: Scaffold(
        appBar: customAppBar(context),
        body: Obx(
          () => getPassController.vistorData.value.isEmpty
              ? const Center(child: Text('No data available'))
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  itemCount: getPassController.vistorData.value.length,
                  itemBuilder: (context, index) {
                    final visitor = getPassController.vistorData.value[index];

                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(6.w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // Replacing CircleAvatar with Container for a rectangular image
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return FullScreenImage(
                                            image: visitor.visitorImagePath,
                                          );
                                        },
                                      ));
                                    },
                                    child: Container(
                                      width: 100
                                          .w, // Adjust width to match desired size
                                      height: 100
                                          .w, // Adjust height to match desired size
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            6.0), // Adjust the radius as needed
                                        image: visitor.visitorImagePath!.isEmpty
                                            ? null
                                            : DecorationImage(
                                                image: NetworkImage(visitor
                                                    .visitorImagePath
                                                    .toString()),
                                                fit: BoxFit.fill,
                                              ),
                                        color: visitor.visitorImagePath!.isEmpty
                                            ? Colors.grey
                                            : null,
                                      ),
                                      child: visitor.visitorImagePath!.isEmpty
                                          ? Icon(Icons.person,
                                              size: 30
                                                  .w) // Adjust icon size as needed
                                          : null,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Tooltip(
                                          decoration: BoxDecoration(
                                              color: Colors.white),
                                          triggerMode: TooltipTriggerMode.tap,
                                          textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.black),
                                          message: visitor.visitorName ??
                                              "N/A", // Full name for tooltip
                                          child: Text(
                                            visitor.visitorName != null &&
                                                    visitor.visitorName!
                                                            .length >
                                                        20
                                                ? '${visitor.visitorName!.substring(0, 20)}...'
                                                : visitor.visitorName ?? "N/A",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            overflow: TextOverflow
                                                .ellipsis, // Truncate the text if too long
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text('ID: ${visitor.id ?? "N/A"}'),
                                        Text(
                                            'Address: ${visitor.visitorAddress}'),
                                        Text(
                                            'Entry Time: ${visitor.entryTime ?? "N/A"}'),
                                        Text(
                                            'Exit Time: ${visitor.exitTime ?? "N/A"}'),
                                        Text(
                                            'Mobile No: ${visitor.number ?? "N/A"}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              if (visitor.exitTime == null ||
                                  visitor.exitTime!.isEmpty)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      getPassController
                                          .markVisitorExitApi(index);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.appbuttonColor,
                                    ),
                                    child: Text(
                                      'Exit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, index) => Divider(),
                ),
        ),
      ),
    );
  }
}
