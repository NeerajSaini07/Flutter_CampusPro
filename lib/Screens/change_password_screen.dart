// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:campuspro/Controllers/change_password_controller.dart';
import 'package:campuspro/Screens/Wedgets/app_rights.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/common_button.dart';
import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/error_commponet.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  final bool isdefaultChangePass;
  const ChangePasswordScreen({super.key, this.isdefaultChangePass = true});

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
      if (widget.isdefaultChangePass) {
        changePasswordController.newPassNode.requestFocus();
      } else {
        changePasswordController.oldPassNode.requestFocus();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          appBar: (widget.isdefaultChangePass)
              ? null
              : customAppBar(context, title: "Change Password"),
          backgroundColor:
              (widget.isdefaultChangePass) ? AppColors.loginscafoldcoolr : null,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isdefaultChangePass) ...{
                    CustomeHeight(100.h),
                    Text(
                      "Change Default Password",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      "Don't worry! Need to Update default password.",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w200,
                          color: Colors.white),
                    ),
                    CustomeHeight(30.h),
                  },
                  if (widget.isdefaultChangePass) ...{
                    Center(
                      child: Card(
                          child: SizedBox(
                        width: double.infinity,
                        height: 370.h,
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: _textFieldWidget()),
                      )),
                    ),
                  } else ...{
                    _textFieldWidget()
                  },
                  CustomeHeight(50.h),
                  if (widget.isdefaultChangePass) appRights(),
                ],
              ),
            ),
          )),
    );
  }

  Widget _textFieldWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomeHeight(29.h),
        Obx(() {
          return changePasswordController.showerrortext.value
              ? errocommponent(
                  fontsize: 12.sp,
                  errorText: changePasswordController.errorText)
              : SizedBox();
        }),
        Obx(() {
          return changePasswordController.showerrortext.value
              ? CustomeHeight(10.h)
              : SizedBox();
        }),
        buildTextField(
          hintText: "Mobile No.",
          style: TextStyle(fontSize: 16.sp),
          readOnly: true,
          // initialValue:
          //     changePasswordController.mobileNo.value,
          controller: changePasswordController.mobileController,
          prefixIconData: Icons.call,
        ),
        CustomeHeight(4.h),
        //Old Password
        if (!widget.isdefaultChangePass) ...{
          Obx(
            () => buildTextField(
                hintText: "Old Password",
                controller: changePasswordController.oldPasswordController,
                focusNode: changePasswordController.oldPassNode,
                suffixIcon: true,
                suffixCustomIcon: true,
                customWidget: IconButton(
                  icon: changePasswordController.oldPassHide.value
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: () {
                    changePasswordController.oldPassHide.value =
                        !changePasswordController.oldPassHide.value;
                  },
                ),
                style: TextStyle(
                  color: changePasswordController.isOldPassFocused.value
                      ? Colors.black
                      : Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                obscureText: changePasswordController.oldPassHide.value,
                prefixIconData: Icons.lock,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    changePasswordController.showOldPassError.value = '';
                  }
                }),
          ),
          Obx(() {
            return changePasswordController.showOldPassError.value.isNotEmpty
                ? errocommponent(
                    fontsize: 10.sp,
                    errorText: changePasswordController.showOldPassError)
                : SizedBox();
          }),
        },
        //New Password
        Obx(
          () => buildTextField(
              hintText: "New Password",
              controller: changePasswordController.newPasswordController,
              focusNode: changePasswordController.newPassNode,
              suffixIcon: false,
              style: TextStyle(
                color: changePasswordController.isNewPassFocused.value
                    ? Colors.black
                    : Colors.grey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              obscureText: true,
              prefixIconData: Icons.lock,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  changePasswordController.showNewPassError.value = '';
                  if (value ==
                      changePasswordController.confirmPasswordController.text) {
                    changePasswordController.showConfirmPassError.value = '';
                  }
                }
              }),
        ),
        Obx(() {
          return changePasswordController.showNewPassError.value.isNotEmpty
              ? errocommponent(
                  fontsize: 10.sp,
                  errorText: changePasswordController.showNewPassError)
              : SizedBox();
        }),
        CustomeHeight(4.h),
        Obx(
          () => buildTextField(
              hintText: "Confirm Password",
              controller: changePasswordController.confirmPasswordController,
              focusNode: changePasswordController.confirmPassNode,
              suffixIcon: true,
              suffixCustomIcon: true,
              customWidget: IconButton(
                icon: changePasswordController.confirmPassHide.value
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
                onPressed: () {
                  changePasswordController.confirmPassHide.value =
                      !changePasswordController.confirmPassHide.value;
                },
              ),
              style: TextStyle(
                color: changePasswordController.isconfirmPassFocused.value
                    ? Colors.black
                    : Colors.grey,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              obscureText: changePasswordController.confirmPassHide.value,
              prefixIconData: Icons.lock,
              onChanged: (value) {
                if (value ==
                    changePasswordController.newPasswordController.text) {
                  changePasswordController.showConfirmPassError.value = '';
                } else {
                  changePasswordController.showConfirmPassError.value =
                      "Password and confirm password don't match.";
                }
              }),
        ),
        Obx(() {
          return changePasswordController.showConfirmPassError.value.isNotEmpty
              ? errocommponent(
                  fontsize: 10.sp,
                  errorText: changePasswordController.showConfirmPassError)
              : SizedBox();
        }),
        CustomeHeight(13.h),
        appCommonbutton(
            onpressed: () {
              if (widget.isdefaultChangePass) {
                if (changePasswordController
                    .newPasswordController.text.isEmpty) {
                  changePasswordController.showNewPassError.value =
                      "Please enter your new password";
                } else if (changePasswordController
                        .confirmPasswordController.text.isEmpty &&
                    (changePasswordController.newPasswordController.text !=
                        changePasswordController
                            .confirmPasswordController.text)) {
                  changePasswordController.showConfirmPassError.value =
                      "Password and confirm password don't match.";
                } else {
                  changePasswordController.changeUserPassword(
                      changePasswordController.confirmPasswordController.text);
                }
              } else {
                if (changePasswordController
                    .oldPasswordController.text.isEmpty) {
                  changePasswordController.showOldPassError.value =
                      "Please enter your old password";
                } else if (changePasswordController
                    .newPasswordController.text.isEmpty) {
                  changePasswordController.showNewPassError.value =
                      "Please enter your new password";
                } else if (changePasswordController
                        .confirmPasswordController.text.isEmpty &&
                    (changePasswordController.newPasswordController.text !=
                        changePasswordController
                            .confirmPasswordController.text)) {
                  changePasswordController.showConfirmPassError.value =
                      "Password and confirm password don't match.";
                } else {
                  changePasswordController.changeSpecificUserPassword(
                      context,
                      changePasswordController.confirmPasswordController.text,
                      changePasswordController.oldPasswordController.text);
                }
              }
            },
            text: "Change Password"),
        if (widget.isdefaultChangePass) ...{
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
        }
      ],
    );
  }
}
