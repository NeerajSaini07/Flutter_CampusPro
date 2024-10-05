import 'package:campuspro/Controllers/StudentControllers/activity_controller.dart';
import 'package:campuspro/Modal/student_module/student_activity_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentActivityScreen extends StatefulWidget {
  const StudentActivityScreen({super.key});

  @override
  State<StudentActivityScreen> createState() => _StudentActivityScreenState();
}

class _StudentActivityScreenState extends State<StudentActivityScreen> {
  final StudentActivityController activityController =
      Get.find<StudentActivityController>();

  @override
  void initState() {
    super.initState();
    activityController.fetchedFilters = {};
    activityController.myScoolActivityList.value = [];
    activityController.myClassActivityList.value = [];
    activityController.meOnlyActivityList.value = [];
    activityController.studentActivityApiStatus.value =
        StudentActivityApiStatus.loading;
    activityController.tabController.animateTo(0);
    activityController.getStudentActivity(filter: 2);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context,
            title: "Activity",
            tabView: true,
            tabBarWidget: TabBar(
              controller: activityController.tabController,
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Colors.white,
              unselectedLabelStyle: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(
                  text: "My Class",
                ),
                Tab(
                  text: "My School",
                ),
                Tab(
                  text: "Me Only",
                ),
              ],
            )),
        body: Obx(
          () => TabBarView(
            controller: activityController.tabController,
            children: [
              _myClassTabView(
                  activityController, activityController.activityfilter.value),
              _myMySchoolTabView(
                  activityController, activityController.activityfilter.value),
              _myMeOnlyTabView(
                  activityController, activityController.activityfilter.value),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _myClassTabView(
    StudentActivityController activityController, int filter) {
  if (filter == 2) {
    switch (activityController.studentActivityApiStatus.value) {
      case StudentActivityApiStatus.loading:
        return const Center(child: CircularProgressIndicator.adaptive());
      case StudentActivityApiStatus.success:
        return activityController.myClassActivityList.isEmpty
            ? const Center(child: Text('No data available'))
            : ListView.builder(
                itemCount: activityController.myClassActivityList.length,
                itemBuilder: (context, index) {
                  return circularListCard(
                      context,
                      activityController.myClassActivityList[index],
                      activityController);
                },
              );
      case StudentActivityApiStatus.error:
        return const Center(child: Text('An error occurred'));
      default:
        return const SizedBox();
    }
  } else {
    return activityController.myClassActivityList.isEmpty
        ? activityController.fetchedFilters.contains(2)
            ? const Center(child: Text('No data available'))
            : const Center(child: CircularProgressIndicator.adaptive())
        : ListView.builder(
            itemCount: activityController.myClassActivityList.length,
            itemBuilder: (context, index) {
              return circularListCard(
                  context,
                  activityController.myClassActivityList[index],
                  activityController);
            },
          );
  }
}

Widget _myMySchoolTabView(
    StudentActivityController activityController, int filter) {
  if (filter == 1) {
    switch (activityController.studentActivityApiStatus.value) {
      case StudentActivityApiStatus.loading:
        return const Center(child: CircularProgressIndicator.adaptive());
      case StudentActivityApiStatus.success:
        return activityController.myScoolActivityList.isEmpty
            ? const Center(child: Text('No data available'))
            : ListView.builder(
                itemCount: activityController.myScoolActivityList.length,
                itemBuilder: (context, index) {
                  return circularListCard(
                      context,
                      activityController.myScoolActivityList[index],
                      activityController);
                },
              );
      case StudentActivityApiStatus.error:
        return const Center(child: Text('An error occurred'));
      default:
        return const SizedBox();
    }
  } else {
    return activityController.myScoolActivityList.isEmpty
        ? activityController.fetchedFilters.contains(1)
            ? const Center(child: Text('No data available'))
            : const Center(child: CircularProgressIndicator.adaptive())
        : ListView.builder(
            itemCount: activityController.myScoolActivityList.length,
            itemBuilder: (context, index) {
              return circularListCard(
                  context,
                  activityController.myScoolActivityList[index],
                  activityController);
            },
          );
  }
}

Widget _myMeOnlyTabView(
    StudentActivityController activityController, int filter) {
  if (filter == 3) {
    switch (activityController.studentActivityApiStatus.value) {
      case StudentActivityApiStatus.loading:
        return const Center(child: CircularProgressIndicator.adaptive());
      case StudentActivityApiStatus.success:
        return activityController.meOnlyActivityList.isEmpty
            ? const Center(child: Text('No data available'))
            : ListView.builder(
                itemCount: activityController.meOnlyActivityList.length,
                itemBuilder: (context, index) {
                  return circularListCard(
                      context,
                      activityController.meOnlyActivityList[index],
                      activityController);
                },
              );
      case StudentActivityApiStatus.error:
        return const Center(child: Text('An error occurred'));
      default:
        return const SizedBox();
    }
  } else {
    return activityController.meOnlyActivityList.isEmpty
        ? activityController.fetchedFilters.contains(3)
            ? const Center(child: Text('No data available'))
            : const Center(child: CircularProgressIndicator.adaptive())
        : ListView.builder(
            itemCount: activityController.meOnlyActivityList.length,
            itemBuilder: (context, index) {
              return circularListCard(
                  context,
                  activityController.meOnlyActivityList[index],
                  activityController);
            },
          );
  }
}

Widget circularListCard(BuildContext context, StudentActivityModel activityData,
    StudentActivityController activityController) {
  return Container(
      decoration: BoxDecoration(
          color: AppColors.whitetextcolor,
          boxShadow: [
            CommonFunctions.commonsadhow(),
          ],
          borderRadius: BorderRadius.circular(10.r)),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    activityData.title ?? " ",
                    style: AppTextStyles.cardTitle,
                  ),
                ),
                if (activityData.fileurl != null &&
                    activityData.fileurl!.isNotEmpty)
                  InkWell(
                    onTap: () {
                      // 'https://jsoncompare.org/LearningContainer/SampleFiles/PDF/sample-pdf-download-10-mb.pdf'
                      // log(activityData.fileurl.toString());
                      // log(activityData.fileurl.toString().replaceAll(
                      //     "fmobiledev.campuspro.in/api/",
                      //     "mobiledev.campuspro.in/"));

                      activityController
                          .downloadFile(activityData.fileurl.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: AppColors.appbuttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.download,
                        size: 16.r,
                        color: AppColors.whitetextcolor,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            HtmlWidget(
              '''
                ${activityData.htmlContent ?? ""}
                ''',
              onTapUrl: (url) async {
                final Uri launchUri = Uri.parse(url.toString());
                if (await canLaunchUrl(launchUri)) {
                  await launchUrl(
                    launchUri,
                    mode: LaunchMode.externalApplication,
                  );
                }
                return true;
              },
            ),
            SizedBox(height: 8.h),
            Text(
              (activityData.dateAdded ?? " "),
              style: AppTextStyles.cardDate,
            ),
            // Row(
            //   children: [
            //     Text(
            //       (activityData.dateAdded ?? " "),
            //       style: AppTextStyles.cardDate,
            //     ),
            //     const Spacer(),
            //     activityData.isDownloaded!.value
            //         ? const SizedBox.shrink()
            //         : const SizedBox.shrink(),
            // if (activityData.fileurl != null &&
            //     activityData.fileurl!.isNotEmpty)
            //   InkWell(
            //     borderRadius: BorderRadius.circular(14.r),
            //     onTap: () {},
            //     child: Container(
            //       padding:
            //           EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            //       decoration: BoxDecoration(
            //         color: activityData.isDownloaded!.value
            //             ? Colors.green
            //             : AppColors.appbuttonColor,
            //         borderRadius: BorderRadius.circular(14.r),
            //         shape: BoxShape.rectangle,
            //       ),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Icon(
            //             activityData.isDownloaded!.value
            //                 ? Icons.check
            //                 : Icons.download,
            //             size: 16.r,
            //             color: AppColors.whitetextcolor,
            //           ),
            //           SizedBox(
            //             width: 4.w,
            //           ),
            //           Text(
            //             activityData.isDownloaded!.value
            //                 ? 'View File'
            //                 : 'Download',
            //             style:
            //                 TextStyle(fontSize: 12.sp, color: Colors.white),
            //           ),
            //         ],
            //       ),
            //     ),
            //   )
            //   ],
            // ),
          ],
        ),
      ));
}
