import 'package:campuspro/Controllers/StudentControllers/circular_controller.dart';
import 'package:campuspro/Modal/student_module/student_circular_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/error_commponet.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentCircularScreen extends StatefulWidget {
  const StudentCircularScreen({super.key});

  @override
  State<StudentCircularScreen> createState() => _StudentCircularScreenState();
}

class _StudentCircularScreenState extends State<StudentCircularScreen> {
  CircularController circularController = Get.find<CircularController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      circularController.getStudentCircular();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: customAppBar(context),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        controller: circularController.searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Circular...',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.h, horizontal: 8.w),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: AppColors.appbuttonColor),
                          ),
                          suffixIcon: const Icon(Icons.search),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: const BorderSide(
                                color: AppColors.appbuttonColor),
                          ),
                        ),
                        onChanged: (value) {
                          circularController.searchQuery.value = value;
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        circularController.searchQuery.value = "";
                        circularController.searchController.text = "";
                        _showFilterOptions(context, circularController);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.r),
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icon/filter.png',
                              color: AppColors.blackcolor, // Path to your image
                              width: 30.w, // Set the width of the image
                              height: 30.w, // Set the height of the image
                              fit: BoxFit.contain, // Adjust the fit as needed
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (circularController.searchQuery.value.trim().isEmpty) {
                    switch (circularController.status.value) {
                      case CircularStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                      case CircularStatus.success:
                        final circularData =
                            circularController.originalCircularList;
                        return circularData.isEmpty
                            ? const Center(child: Text('No data available'))
                            : ListView.builder(
                                itemCount: circularData.length,
                                itemBuilder: (context, index) {
                                  return circularListCard(circularData[index],
                                      context, circularController);
                                },
                              );
                      case CircularStatus.error:
                        return const Center(child: Text('An error occurred'));
                      default:
                        return const SizedBox();
                    }
                  } else {
                    return circularController.filteredCircularList.isEmpty
                        ? const Center(child: Text('No data available'))
                        : ListView.builder(
                            itemCount:
                                circularController.filteredCircularList.length,
                            itemBuilder: (context, index) {
                              return circularListCard(
                                  circularController
                                      .filteredCircularList[index],
                                  context,
                                  circularController);
                            },
                          );
                  }
                }),
              ),
            ],
          )),
    );
  }
}

Widget circularListCard(StudentCircularModel circularData, BuildContext context,
    CircularController circularController) {
  return Obx(
    () => Card(
      color: AppColors.whitetextcolor,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Text(
              circularData.cirSubject ?? "",
              style: AppTextStyles.cardTitle,
            ),
            SizedBox(height: 8.h),
            HtmlWidget(
              '''
              ${circularData.cirContent ?? ""}
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
            Row(
              children: [
                Text(
                  circularData.circularDate ?? "",
                  style: AppTextStyles.cardDate,
                ),
                Text(
                  " (${circularData.cirNo})",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.appbuttonColor,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                circularData.isDownloaded.value
                    ? const SizedBox.shrink()
                    : const SizedBox.shrink(),
                if (circularData.circularFileurl != null &&
                    circularData.circularFileurl!.isNotEmpty)
                  InkWell(
                    borderRadius: BorderRadius.circular(14.r),
                    onTap: () {
                      circularController.downloadFile(circularData);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: circularData.isDownloaded.value
                            ? Colors.green
                            : AppColors.appbuttonColor,
                        borderRadius: BorderRadius.circular(14.r),
                        shape: BoxShape.rectangle,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            circularData.isDownloaded.value
                                ? Icons.check
                                : Icons.download,
                            size: 16.r,
                            color: AppColors.whitetextcolor,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            circularData.isDownloaded.value
                                ? 'Completed'
                                : 'Download',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.white),
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
    ),
  );
}

void _showFilterOptions(
    BuildContext context, CircularController circularController) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 25.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Filter',
              style: AppTextStyles.filterTextStyle.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  'Date',
                  style: AppTextStyles.filterOptionTextStyle,
                ),
                const Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h), // Better padding for buttons
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    circularController.selectDate(context, "from");
                  },
                  icon: Icon(
                    Icons.date_range,
                    size: 14.sp,
                    color: AppColors.blackcolor,
                  ),
                  label: Obx(
                    () => Text(
                        circularController.fromDate.value != null
                            ? DateFormat('dd-MMM-yyyy')
                                .format(circularController.fromDate.value!)
                            : 'From',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackcolor)),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white70,
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 8.h), // Consistent button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    if (circularController.fromDate.value == null) {
                      circularController.filtererrormsg.value =
                          "Please pick a 'from date' before picking a 'to date'.";
                    } else {
                      circularController.selectDate(context, "to");
                    }
                  },
                  icon: Icon(
                    Icons.date_range,
                    size: 14.sp,
                    color: AppColors.blackcolor,
                  ),
                  label: Obx(
                    () => Text(
                        circularController.toDate.value != null
                            ? DateFormat('dd-MMM-yyyy')
                                .format(circularController.toDate.value!)
                            : 'To',
                        style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackcolor)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Obx(() {
              return circularController.filtererrormsg.value.isNotEmpty
                  ? errocommponent(
                      fontsize: 12.sp,
                      errorText: circularController.filtererrormsg)
                  : const SizedBox();
            }),
            SizedBox(height: 20.h),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (circularController.fromDate.value != null &&
                        circularController.toDate.value != null) {
                      Get.back();
                      circularController.filterCircular.value = 0;
                      circularController.getStudentCircular();
                    } else {
                      circularController.filtererrormsg.value =
                          "Please select from date and to date";
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appbuttonColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
                if (circularController.filterCircular.value == 0) ...{
                  SizedBox(
                    width: 8.w,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      circularController.filterCircular.value = 1;
                      circularController.getStudentCircular();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appbuttonColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Remove Filter',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                }
              ],
            ),
          ],
        ),
      );
    },
  );
}
