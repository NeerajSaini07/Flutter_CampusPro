import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/GetPassController/getpassController.dart';

import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/getPass/usertype_search.dart';
import 'package:campuspro/Screens/getpass/gatepass_history_list.dart';
import 'package:campuspro/Screens/getpass/history_data.dart';

import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/common_userProfile_ondashboard.dart';
import '../Wedgets/getPass/dialogbox.dart';
import '../Wedgets/getPass/gatepass_dashboard_button.dart';

class GatePassDashboard extends StatefulWidget {
  const GatePassDashboard({super.key});

  @override
  State<GatePassDashboard> createState() => _GatePassDashboardState();
}

class _GatePassDashboardState extends State<GatePassDashboard> {
  final GetPassController getPassController = Get.find<GetPassController>();

  @override
  void initState() {
    getPassController.toMeetdata();
    getPassController.PursposedataGeting();
    getPassController.showvisitorDetails.value = false;
    getPassController.visitorImage.value = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();
    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();

    final AppbarController appbarController = Get.find<AppbarController>();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          userProfileName(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0.sp),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Visitor Entry',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Obx(() => getPassController.showErrorfield.value
                              ? Text(
                                  getPassController.errorMessage.value,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                )
                              : const SizedBox()),
                          const SizedBox(height: 10),
                          buildTextField(
                            hintText: "Phone Number",
                            maxLength: 10,
                            obscureText: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]")),
                            ],
                            controller:
                                getPassController.mobilenumberController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              getPassController.showErrorfield.value = false;
                              getPassController.mobileNo.value = value;
                            },
                            prefixIconData: Icons.call,
                          ),
                          const SizedBox(height: 16),

                          //  **************** user search type ***********************************
                          userType(),
                        ],
                      ),
                    )),
                CustomeHeight(20.h),
                dashboardButton(context),
              ],
            ),
          ),
          CustomeHeight(16.h),
        ]);
  }
}

// ignore: non_constant_identifier_names
