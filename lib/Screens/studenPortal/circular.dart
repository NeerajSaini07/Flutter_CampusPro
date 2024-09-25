import 'package:campuspro/Controllers/StudentControllers/circular_controller.dart';
import 'package:campuspro/Modal/student_module/student_circular_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
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
          appBar: customAppBar(context, title: "Circular"),
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
                      circularController.downloadFile(
                          circularData.circularFileurl ?? "",
                          circularData.isDownloaded);
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
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            Text(
              'Filter Circular',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "From:",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textfieldhintstycolor),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () {
                          circularController.selectDate(context, "from");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.textfieldhintstycolor,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                    circularController.fromDate.value != null
                                        ? DateFormat('dd-MMM-yyyy').format(
                                            circularController.fromDate.value!)
                                        : 'Select Date From',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: circularController
                                                    .fromDate.value !=
                                                null
                                            ? AppColors.blackcolor
                                            : AppColors.textfieldhintstycolor)),
                              ),
                              const Icon(Icons.date_range)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "To:",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textfieldhintstycolor),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        onTap: () {
                          if (circularController.fromDate.value == null) {
                            circularController.filtererrormsg.value =
                                "Please pick a 'from date' before picking a 'to date'.";
                          } else {
                            circularController.selectDate(context, "to");
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColors.textfieldhintstycolor,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                    circularController.toDate.value != null
                                        ? DateFormat('dd-MMM-yyyy').format(
                                            circularController.toDate.value!)
                                        : 'Select Date To',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                        color: circularController
                                                    .toDate.value !=
                                                null
                                            ? AppColors.blackcolor
                                            : AppColors.textfieldhintstycolor)),
                              ),
                              const Icon(Icons.date_range)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
            CustomeHeight(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r)),
                        elevation: 0,
                        backgroundColor: AppColors.appbuttonColor),
                    onPressed: (circularController.fromDate.value != null &&
                            circularController.toDate.value != null)
                        ? () {
                            Get.back();
                            circularController.filterCircular.value = 0;
                            circularController.getStudentCircular();
                          }
                        : null,
                    child: Text(
                      'Apply Filter',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whitetextcolor),
                    ),
                  ),
                ),
                if (circularController.filterCircular.value == 0) ...{
                  SizedBox(
                    width: 8.w,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r)),
                        elevation: 0,
                        backgroundColor: AppColors.appbuttonColor),
                    onPressed: () {
                      Get.back();
                      circularController.filterCircular.value = 1;
                      circularController.getStudentCircular();
                    },
                    child: Text(
                      'Remove Filter',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.whitetextcolor),
                    ),
                  ),
                }
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      );
    },
  ).whenComplete(() {});
}
