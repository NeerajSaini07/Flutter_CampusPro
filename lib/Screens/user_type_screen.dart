// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/shimmer_widget.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  @override
  void initState() {
    final UserTypeController userTypeController =
        Get.find<UserTypeController>();

    userTypeController.getUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserTypeController userTypeController =
        Get.find<UserTypeController>();

    final LogoutController logoutController = Get.find<LogoutController>();
    final WebController webController = Get.find<WebController>();
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Constant.userTypeBg), fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xFFD2D0D0),
                offset: Offset(-1, 0),
                blurRadius: 20,
                spreadRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomeHeight(14.h),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 30.w).copyWith(top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Choose Account",
                      style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        logoutController.userlogOut();
                      },
                      child: CircleAvatar(
                        radius: 22.w,
                        backgroundColor: AppColors.logoutBg,
                        child: Icon(
                          Icons.logout,
                          color: AppColors.logoutColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              FutureBuilder(
                future: userTypeController.getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w)
                                .copyWith(bottom: 10.h),
                            child: shimmerWidget(
                                height: 120.h,
                                width: double.infinity,
                                borderRadius: 12));
                      },
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserTypeslist.userTypesDetails =
                          snapshot.data as List<UserTypeModel>;
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: UserTypeslist.userTypesDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w)
                                .copyWith(bottom: 10.h),
                            child: InkWell(
                                onTap: () {
                                  webController.appBarName.value = "Dashboard";
                                  userTypeController.gotoDashBorad(
                                      UserTypeslist
                                          .userTypesDetails[index].dashboardUrl
                                          .toString(),
                                      {index.toString(): index});
                                },
                                child: userListCard(index)));
                      },
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.h),
                      child: Center(
                          child: Lottie.asset('assets/lottie_json/no_data.json',
                              height: MediaQuery.sizeOf(context).height * 0.3)),
                    );
                  }
                },
              ),
              // userListCard(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget userListCard(
    int index,
  ) {
    return Container(
      height: 120.h,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(width: 0.2),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding:
            EdgeInsets.only(top: 15.h, bottom: 3.h, left: 15.w, right: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              height: 100.h,
              UserTypeslist.userTypesDetails[index].logoImgPath.toString(),
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomeHeight(4.h),
                  Text(
                    UserTypeslist.userTypesDetails[index].stuEmpName.toString(),
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackcolor),
                  ),
                  CustomeHeight(4.h),
                  Text(
                    UserTypeslist.userTypesDetails[index].userName.toString(),
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primarycolor),
                  ),
                  CustomeHeight(4.h),
                  Expanded(
                    child: Text(
                      UserTypeslist.userTypesDetails[index].schoolName
                          .toString(),
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.blackcolor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
