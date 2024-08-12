// ignore_for_file: prefer_const_constructors
import 'package:campuspro/Controllers/change_password_controller.dart';
import 'package:campuspro/Screens/Wedgets/app_rights.dart';
import 'package:campuspro/Screens/Wedgets/common_button.dart';
import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/error_commponet.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController changePasswordController =
      Get.find<ChangePasswordController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      changePasswordController.initialStateData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.loginscafoldcoolr,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomeHeight(100.h),
                Text(
                  "Change Default Password",
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                CustomeHeight(5.h),
                Text(
                  "Don't worry! Need to Update default password.",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
                CustomeHeight(30.h),
                Center(
                  child: Card(
                      child: SizedBox(
                    width: double.infinity,
                    height: 370.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomeHeight(29.h),
                          Obx(() {
                            return changePasswordController.showerrortext.value
                                ? errocommponent(
                                    fontsize: 12.sp,
                                    errorText:
                                        changePasswordController.errorText)
                                : SizedBox();
                          }),
                          Obx(() {
                            return changePasswordController.showerrortext.value
                                ? CustomeHeight(10.h)
                                : SizedBox();
                          }),
                          buildTextField(
                            hintText: "Mobile No.",
                            readOnly: true,
                            // initialValue:
                            //     changePasswordController.mobileNo.value,
                            controller:
                                changePasswordController.mobileController,
                            prefixIconData: Icons.call,
                          ),
                          CustomeHeight(4.h),
                          Obx(
                            () => buildTextField(
                                hintText: "New Password",
                                controller: changePasswordController
                                    .newPasswordController,
                                focusNode: changePasswordController.newPassNode,
                                suffixIcon: false,
                                style: TextStyle(
                                  color: changePasswordController
                                          .isNewPassFocused.value
                                      ? Colors.black
                                      : Colors.grey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                obscureText: true,
                                prefixIconData: Icons.lock,
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    changePasswordController
                                        .showNewPassError.value = '';
                                    if (value ==
                                        changePasswordController
                                            .confirmPasswordController.text) {
                                      changePasswordController
                                          .showConfirmPassError.value = '';
                                    }
                                  }
                                }),
                          ),
                          Obx(() {
                            return changePasswordController
                                    .showNewPassError.value.isNotEmpty
                                ? errocommponent(
                                    fontsize: 10.sp,
                                    errorText: changePasswordController
                                        .showNewPassError)
                                : SizedBox();
                          }),
                          CustomeHeight(4.h),
                          Obx(
                            () => buildTextField(
                                hintText: "Confirm Password",
                                controller: changePasswordController
                                    .confirmPasswordController,
                                focusNode:
                                    changePasswordController.confirmPassNode,
                                suffixIcon: true,
                                suffixCustomIcon: true,
                                customWidget: IconButton(
                                  icon: changePasswordController
                                          .confirmPassHide.value
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: () {
                                    changePasswordController
                                            .confirmPassHide.value =
                                        !changePasswordController
                                            .confirmPassHide.value;
                                  },
                                ),
                                style: TextStyle(
                                  color: changePasswordController
                                          .isconfirmPassFocused.value
                                      ? Colors.black
                                      : Colors.grey,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                obscureText: changePasswordController
                                    .confirmPassHide.value,
                                prefixIconData: Icons.lock,
                                onChanged: (value) {
                                  if (value ==
                                      changePasswordController
                                          .newPasswordController.text) {
                                    changePasswordController
                                        .showConfirmPassError.value = '';
                                  } else {
                                    changePasswordController
                                            .showConfirmPassError.value =
                                        "Password and confirm password don't match.";
                                  }
                                }),
                          ),
                          Obx(() {
                            return changePasswordController
                                    .showConfirmPassError.value.isNotEmpty
                                ? errocommponent(
                                    fontsize: 10.sp,
                                    errorText: changePasswordController
                                        .showConfirmPassError)
                                : SizedBox();
                          }),
                          CustomeHeight(13.h),
                          appCommonbutton(
                              onpressed: () {
                                if (changePasswordController
                                        .newPasswordController
                                        .text
                                        .isNotEmpty &&
                                    changePasswordController
                                        .confirmPasswordController
                                        .text
                                        .isNotEmpty &&
                                    (changePasswordController
                                            .newPasswordController.text ==
                                        changePasswordController
                                            .confirmPasswordController.text)) {
                                  changePasswordController.changeUserPassword(
                                      changePasswordController
                                          .confirmPasswordController.text);
                                }
                              },
                              text: "Change Password"),
                          CustomeHeight(8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Text(
                                  " Login ",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.underline,
                                      color: AppColors.appbuttonColor),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ),
                CustomeHeight(50.h),
                appRights(),
              ],
            ),
          ),
        ));
  }
}
