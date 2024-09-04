import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/GetPassController/getpassController.dart';

import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/getPass/usertype_search.dart';
import 'package:campuspro/Utilities/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/common_userProfile_ondashboard.dart';
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
    // final BottomBarController bottomBarController =
    //     Get.find<BottomBarController>();

    // final AppbarController appbarController = Get.find<AppbarController>();

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
                              InkWell(
                                  borderRadius: BorderRadius.circular(4),
                                  onTap: () {
                                    showBottomSheet(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 4, bottom: 4, left: 8, right: 8),
                                    child: ImageIcon(
                                        AssetImage(Constant.filtericon)),
                                  )),
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
                            style: TextStyle(fontSize: 16.sp),
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
              ],
            ),
          ),
          CustomeHeight(16.h),
        ]);
  }
}

void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
            child: dashboardButton(context)),
      );
    },
  );
}

// ignore: non_constant_identifier_names
