// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/forgotpassword_controller.dart';
import 'package:campuspro/Screens/Wedgets/app_rights.dart';
import 'package:campuspro/Screens/Wedgets/common_button.dart';
import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController =
        Get.find<ForgotPasswordController>();
    return Scaffold(
      backgroundColor: AppColors.loginscafoldcoolr,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.loginscafoldcoolr,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeHeight(50.h),
              Text(
                "Set new Password",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomeHeight(5.h),
              headingcomponent(),
              CustomeHeight(70.h),
              Center(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
                    child: SizedBox(
                      height: 250.h,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => forgotPasswordController.globleError.value
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    forgotPasswordController.errorText.value,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                )
                              : SizedBox()),
                          buildTextField(
                              hintText: "Create Password",
                              obscureText: false,
                              controller:
                                  forgotPasswordController.createPassword,
                              onChanged: (value) {
                                forgotPasswordController.globleError.value =
                                    false;
                                forgotPasswordController
                                    .passwordfielderror.value = false;
                                forgotPasswordController.showerrortext.value =
                                    false;
                                forgotPasswordController
                                    .confrmpasserrofield.value = false;
                              },
                              prefixIconData: Icons.lock),
                          Obx(() => forgotPasswordController
                                  .passwordfielderror.value
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    forgotPasswordController.errorText.value,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                )
                              : SizedBox()),
                          CustomeHeight(10.h),
                          buildTextField(
                              hintText: "Confirm Password",
                              obscureText: true,
                              controller:
                                  forgotPasswordController.conformPassword,
                              onChanged: (value) {
                                forgotPasswordController.globleError.value =
                                    false;
                                forgotPasswordController
                                    .passwordfielderror.value = false;
                                forgotPasswordController.showerrortext.value =
                                    false;
                                forgotPasswordController
                                    .confrmpasserrofield.value = false;
                              },
                              prefixIconData: Icons.lock),
                          Obx(() => forgotPasswordController
                                  .confrmpasserrofield.value
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    forgotPasswordController.errorText.value,
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                )
                              : SizedBox()),
                          CustomeHeight(20.h),
                          appCommonbutton(
                              onpressed: () {
                                forgotPasswordController
                                    .createpasswordFormValidate();
                              },
                              text: "Save"),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CustomeHeight(100.h),
              appRights(),
            ],
          ),
        ),
      ),
    );
  }

  Widget headingcomponent() {
    return Text("Create your new password to secure your account.",
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w200,
          color: Colors.white,
        ));
  }
}
