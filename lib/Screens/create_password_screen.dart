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

class CreatePassword extends StatelessWidget {
  const CreatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController =
        Get.find<ForgotPasswordController>();
    return Scaffold(
      backgroundColor: AppColors.loginscafoldcoolr,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomeHeight(100.h),
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
                          buildTextField(
                              hintText: "Create Password",
                              obscureText: false,
                              controller:
                                  forgotPasswordController.createPassword,
                              onChanged: (value) {
                                forgotPasswordController.showerrortext.value =
                                    false;
                              },
                              prefixIconData: Icons.lock),
                          CustomeHeight(10.h),
                          buildTextField(
                              hintText: "Conform Password",
                              obscureText: true,
                              controller:
                                  forgotPasswordController.conformPassword,
                              onChanged: (value) {
                                forgotPasswordController.showerrortext.value =
                                    false;
                              },
                              prefixIconData: Icons.lock),
                          Obx(() => forgotPasswordController.showerrortext.value
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
                          Obx(() => forgotPasswordController.showerrortext.value
                              ? CustomeHeight(20.h)
                              : CustomeHeight(50.h)),
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
