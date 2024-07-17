// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomeHeight(30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Choose Accoun",
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
                  backgroundColor: AppColors.loginscafoldcoolr,
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),

          FutureBuilder(
            future: userTypeController.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserTypeslist.userTypesDetails =
                      snapshot.data as List<UserTypeModel>;
                }
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: UserTypeslist.userTypesDetails.length,
                    itemBuilder: (context, index) {
                      var url = UserTypeslist
                          .userTypesDetails[index].dashboardUrl
                          .toString();
                      return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: InkWell(
                              onTap: () {
                                userTypeController.gotoDashBorad(
                                  UserTypeslist
                                      .userTypesDetails[index].dashboardUrl
                                      .toString(),
                                  {
                                    index.toString(): index
                                  }, // Passing the optional parameter as a map
                                );
                              },
                              child: userListCard(index)));
                    },
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          // userListCard(),
        ],
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
