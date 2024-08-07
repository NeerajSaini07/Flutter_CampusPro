// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/logout_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/custom_width.dart';
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
  Widget build(BuildContext context) {
    final UserTypeController userTypeController =
        Get.find<UserTypeController>();
    final LogoutController logoutController = Get.find<LogoutController>();
    // final WebController webController = Get.find<WebController>();
    final AppbarController appbarController = Get.find<AppbarController>();
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Constant.userTypeBg), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 18.w).copyWith(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Choose Account",
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
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
                  ),
                ],
              ),
            ),
            Expanded(
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
                margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomeHeight(18.h),

                    FutureBuilder(
                      future: userTypeController.getUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18.w)
                                            .copyWith(bottom: 20.h),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                flex: 3,
                                                child: shimmerWidget(
                                                    height: 70.h,
                                                    width: MediaQuery.sizeOf(
                                                            context)
                                                        .width,
                                                    borderRadius: 12)),
                                            customWidth(20.w),
                                            Expanded(
                                                flex: 7,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          shimmerWidget(
                                                              height: 15.sp,
                                                              width: MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width,
                                                              borderRadius: 5),
                                                          CustomeHeight(4.h),
                                                          shimmerWidget(
                                                              height: 14.sp,
                                                              width: MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width,
                                                              borderRadius: 5),
                                                          CustomeHeight(4.h),
                                                          shimmerWidget(
                                                              height: 12.sp,
                                                              width: MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width,
                                                              borderRadius: 5),
                                                        ],
                                                      ),
                                                    ),
                                                    customWidth(10.w),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 18,
                                                      color: Colors.grey,
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Spacer(
                                              flex: 3,
                                            ),
                                            customWidth(20.w),
                                            Expanded(
                                              flex: 7,
                                              child: shimmerWidget(
                                                  height: 1,
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                          .width,
                                                  borderRadius: 0),
                                            )
                                          ],
                                        )
                                      ],
                                    ));
                              },
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasData) {
                            UserTypeslist.userTypesDetails =
                                snapshot.data as List<UserTypeModel>;
                          }
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: UserTypeslist.userTypesDetails.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18.w)
                                            .copyWith(bottom: 20.h),
                                    child: InkWell(
                                        onTap: () async {
                                          // ***************************  calling method for passing url index and page name  with cotext  *********************
                                          //
                                          //
                                          //url: for webview routing ;
                                          //pagename : for flutter dashboard routing
                                          // index : fopr finding  user data
                                          //
                                          final pagename = UserTypeslist
                                              .userTypesDetails[index].ouserType
                                              .toString();
                                          appbarController.appBarName.value =
                                              Constant.schoolName.toString();
                                          await userTypeController
                                              .gotoDashBorad(
                                            UserTypeslist
                                                .userTypesDetails[index]
                                                .dashboardUrl
                                                .toString(),
                                            {index.toString(): index},
                                          );
                                        },
                                        child: userListCard(index)));
                              },
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: Center(
                                child: Lottie.asset(
                                    'assets/lottie_json/no_data.json',
                                    height: MediaQuery.sizeOf(context).height *
                                        0.3)),
                          );
                        }
                      },
                    ),
                    // userListCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget userListCard(
    int index,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.15),
                    borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage.assetNetwork(
                    image: UserTypeslist.userTypesDetails[index].logoImgPath
                        .toString(),
                    placeholder: Constant.applogoImage,
                  ),
                ),
              ),
            ),
            customWidth(20.w),
            Expanded(
                flex: 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            UserTypeslist.userTypesDetails[index].stuEmpName
                                .toString(),
                            maxLines: 1,
                            textScaler: TextScaler.noScaling,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blackcolor),
                          ),
                          Text(
                            UserTypeslist.userTypesDetails[index].userName
                                .toString(),
                            maxLines: 1,
                            textScaler: TextScaler.noScaling,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primarycolor),
                          ),
                          Text(
                            UserTypeslist.userTypesDetails[index].schoolName
                                .toString(),
                            maxLines: 1,
                            textScaler: TextScaler.noScaling,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.grey,
                    )
                  ],
                ))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spacer(
              flex: 3,
            ),
            customWidth(20.w),
            Expanded(
                flex: 7,
                child: Divider(
                  height: 1,
                  thickness: 1,
                ))
          ],
        )
      ],
    );
  }
}
