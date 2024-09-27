import 'package:campuspro/Controllers/StudentControllers/profileController.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/student_module/student_profile_model.dart';
import 'package:campuspro/Modal/student_module/student_remark_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentProfileController profileController =
        Get.find<StudentProfileController>();
    final UserTypeController userTypeController =
        Get.find<UserTypeController>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: customAppBar(context,
            showProfile: false,
            title: "Profile",
            tabView: true,
            tabBarWidget: PreferredSize(
              preferredSize: Size.fromHeight(100.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: () {
                            if (StudentDetaillist.studentdetails.isNotEmpty) {
                              if (StudentDetaillist
                                  .studentdetails.first.imageUrl
                                  .toString()
                                  .contains("https")) {
                                return NetworkImage(
                                  StudentDetaillist
                                      .studentdetails.first.imageUrl
                                      .toString(),
                                );
                              } else {
                                return null;
                              }
                            }
                            return null;
                          }(),
                          child: (StudentDetaillist.studentdetails.isNotEmpty &&
                                  StudentDetaillist
                                      .studentdetails.first.imageUrl
                                      .toString()
                                      .contains("https"))
                              ? null
                              : Image.asset(Constant.usericon),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                UserTypeslist
                                        .userTypesDetails[
                                            userTypeController.usertypeIndex]
                                        .stuEmpName ??
                                    "N/A",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                UserTypeslist
                                        .userTypesDetails[
                                            userTypeController.usertypeIndex]
                                        .userName ??
                                    "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    controller: profileController.tabController,
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
                        text: "Profile",
                      ),
                      Tab(
                        text: "Remarks",
                      ),
                    ],
                  ),
                ],
              ),
            )),
        body: TabBarView(
          controller: profileController.tabController,
          children: [
            _studentProfileView(context, profileController),
            _studentRemarkView(context, profileController)
          ],
        ),
      ),
    );
  }

  Widget _studentProfileView(
      BuildContext context, StudentProfileController profileController) {
    return FutureBuilder<List<StudentProfileModel>>(
      future: profileController.getStudentProfileData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          final profileData = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h)
                      .copyWith(bottom: 25.h),
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h)
                      .copyWith(bottom: 16.h),
                  decoration: BoxDecoration(
                      color: AppColors.whitetextcolor,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tileContentWidget(
                          "Admission No : ", profileData.first.admNo ?? "N/A"),
                      _tileContentWidget("Class : ", () {
                        if (profileData.first.classSection != null &&
                            profileData.first.classSection!.isNotEmpty) {
                          return "${profileData.first.className ?? "N/A"} - ${profileData.first.classSection ?? "N/A"}";
                        } else {
                          return profileData.first.className ?? "N/A";
                        }
                      }()),
                      _tileContentWidget(
                          "Gender : ", profileData.first.gender ?? "N/A"),
                      _tileContentWidget(
                          "DOB : ", profileData.first.dobNew ?? "N/A"),
                      _tileContentWidget("Father's Name : ",
                          profileData.first.fatherName ?? "N/A"),
                      _tileContentWidget("Mother's Name : ",
                          profileData.first.motherName ?? "N/A"),
                      _tileContentWidget(
                          "Mobile No : ", profileData.first.mobileNo ?? "N/A"),
                      _tileContentWidget("Guardian's Mobile : ",
                          profileData.first.guardianMobileNo ?? "N/A"),
                      _tileContentWidget(
                          "Email-Id : ", profileData.first.email ?? "N/A"),
                      _tileContentWidget(
                          "Category : ", profileData.first.category ?? "N/A"),
                      _tileContentWidget("Nationality : ",
                          profileData.first.nationality ?? "N/A"),
                      _tileContentWidget(
                          "Religion : ", profileData.first.religion ?? "N/A"),
                      _tileContentWidget("Blood Group : ",
                          profileData.first.bloodGroup ?? "N/A"),
                      // _tileContentWidget(
                      //     "PEN : ", profileData.first.admNo ?? "N/A"),
                      // _tileContentWidget(
                      //     "SRN No : ", profileData.first.admNo ?? "N/A"),
                      _tileContentWidget(
                          "Family ID : ", profileData.first.familyID ?? "N/A"),
                      _tileContentWidget("Aadhar No : ",
                          profileData.first.studentAadharNo ?? "N/A"),
                      Text(
                        "Present Address :- ",
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.appbuttonColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      _tileContentWidget("Address : ",
                          profileData.first.prsntAddress ?? "N/A"),
                      _tileContentWidget("Area / Village : ",
                          profileData.first.village ?? "N/A"),
                      _tileContentWidget(
                          "Post Office : ", profileData.first.pO ?? "N/A"),
                      _tileContentWidget(
                          "City : ", profileData.first.pCity ?? "N/A"),
                      _tileContentWidget(
                          "State : ", profileData.first.pState ?? "N/A"),
                      _tileContentWidget(
                          "Pin Code : ", profileData.first.presZip ?? "N/A"),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _studentRemarkView(
      BuildContext context, StudentProfileController profileController) {
    return FutureBuilder<List<StudentRemarkModel>>(
      future: profileController.getStudentRemarkData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          final remarkData = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            itemCount: remarkData.length,
            itemBuilder: (context, index) {
              return _remarkListCardView(remarkData[index]);
            },
          );
        }
      },
    );
  }

  Widget _remarkListCardView(StudentRemarkModel remarkData) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w).copyWith(bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
              color: AppColors.whitetextcolor,
              border: Border(
                  left:
                      BorderSide(color: AppColors.appbuttonColor, width: 2.w)),
              borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Given By : ",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600)),
                        TextSpan(
                          text: remarkData.empName ?? "",
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey,
                        size: 16.sp,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        remarkData.addedOnDate ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 6.h,
              ),
              Wrap(
                spacing: 8.w,
                runSpacing: 4.h,
                alignment: WrapAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                            color: AppColors.leavecolor, width: 0.5)),
                    child: Text(
                      remarkData.remark ?? "",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  if (remarkData.extraRemark != null &&
                      remarkData.extraRemark!.isNotEmpty)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                              color: AppColors.leavecolor, width: 0.5)),
                      child: Text(
                        remarkData.extraRemark ?? "",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.blackcolor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tileContentWidget(
    String title,
    String content,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              content,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackcolor,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
