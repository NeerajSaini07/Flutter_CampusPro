import 'package:campuspro/Controllers/StudentControllers/activity_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class StudentActivityScreen extends StatelessWidget {
  const StudentActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentActivityController activityController =
        Get.find<StudentActivityController>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context, tabView: true),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return circularListCard(context);
              },
            ),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

Widget circularListCard(BuildContext context) {
  return Card(
    color: AppColors.whitetextcolor,
    margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
    child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.h),
          Text(
            "circularData.cirSubject ?? " "",
            style: AppTextStyles.cardTitle,
          ),
          SizedBox(height: 8.h),
          HtmlWidget(
            '''
              circularData.cirContent ?? ""
              ''',
            // onTapUrl: (url) async {
            // final Uri launchUri = Uri.parse(url.toString());
            // if (await canLaunchUrl(launchUri)) {
            //   await launchUrl(
            //     launchUri,
            //     mode: LaunchMode.externalApplication,
            //   );
            // }
            // return true;
            // },
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                "circularData.circularDate ?? " "",
                style: AppTextStyles.cardDate,
              ),
              const Spacer(),
              // circularData.isDownloaded.value
              //     ? const SizedBox.shrink()
              //     : const SizedBox.shrink(),
              // if (circularData.circularFileurl != null &&
              //     circularData.circularFileurl!.isNotEmpty)
              InkWell(
                borderRadius: BorderRadius.circular(14.r),
                onTap: () {
                  // circularController.downloadFile(circularData);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color:
                        // circularData.isDownloaded.value
                        //     ? Colors.green
                        //     :
                        AppColors.appbuttonColor,
                    borderRadius: BorderRadius.circular(14.r),
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        // circularData.isDownloaded.value
                        //     ? Icons.check
                        //     :
                        Icons.download,
                        size: 16.r,
                        color: AppColors.whitetextcolor,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        // circularData.isDownloaded.value
                        //     ? 'Completed'
                        //     :
                        'Download',
                        style: TextStyle(fontSize: 12.sp, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
