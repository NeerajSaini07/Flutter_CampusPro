import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/GetPassController/getpassController.dart';

import 'package:campuspro/Screens/Wedgets/common_form_component.dart';

import 'package:campuspro/Utilities/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/getPass/dialogbox.dart';

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

    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
                color: Colors.white,
                margin: EdgeInsets.all(8.0.sp),
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
                          Row(
                            children: [
                              Icon(
                                Icons.history,
                                size: 18.sp,
                              ),
                              SizedBox(
                                  width: 4.0
                                      .sp), // Add space between the icon and text
                              GestureDetector(
                                onTap: () {
                                  showGetpassDilaog(context);
                                },
                                child: Text(
                                  'Show History',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppColors.blackcolor),
                                ),
                              ),
                            ],
                          )
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
                          : SizedBox()),
                      const SizedBox(height: 10),
                      buildTextField(
                        hintText: "Phone Number",
                        maxLength: 10,
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        controller: getPassController.mobilenumberController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          getPassController.showErrorfield.value = false;
                          getPassController.mobileNo.value = value;
                        },
                        prefixIconData: Icons.call,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                getPassController.visitorTyep.value = 'Father';
                                getPassController.searchvistorByMobile();
                              },
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: AppColors.appbuttonColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      'Father',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 10), // Add space between containers
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                getPassController.visitorTyep.value = 'Mother';
                                getPassController.searchvistorByMobile();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: const BoxDecoration(
                                  color: AppColors.appbuttonColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      'Mother',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width: 8), // Add space between containers
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                getPassController.visitorTyep.value = 'Other';
                                getPassController.searchvistorByMobile();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: const BoxDecoration(
                                  color: AppColors.appbuttonColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5),
                                    Text(
                                      'Other',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ]),
    ));
  }
}

// ignore: non_constant_identifier_names
