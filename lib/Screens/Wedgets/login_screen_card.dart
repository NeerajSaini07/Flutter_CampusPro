// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:campuspro/Controllers/forgotpassword_controller.dart';
import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_button.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Services/urlLuncher/web_url_luncher.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'common_form_component.dart';
import 'company_logo_component.dart';
import 'error_text.dart';

Widget loginFormCard(BuildContext context) {
  final LoginController loginController = Get.find<LoginController>();
  return GestureDetector(
    onTap: () {
      FocusScope.of(context).requestFocus(FocusNode());
    },
    child: Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomeHeight(10.h),
            companylog(),
            CustomeHeight(24.h),
            Text("Welcome !",
                style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.appbuttonColor)),

            Obx(() {
              return loginController.gloableError.value
                  ? errocommponent(fontsize: 12.sp)
                  : SizedBox();
            }),
            CustomeHeight(24.h),

            //buildLabels("Mobile Number"),

            //  ********************************  login form  *************************************
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => buildTextField(
                        hintText: "Phone Number",
                        controller: loginController.mobileNumberController,
                        maxLength: 10,
                        focusNode: loginController.phoneNode,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          color: loginController.isPhoneFocused.value
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        onChanged: (value) {
                          loginController.showerror.value = false;
                          loginController.gloableError.value = false;
                          loginController.mobileNumber.value = value;
                        },
                        prefixIconData: Icons.call),
                  ),

                  //  buildLabels("Password"),
                  Obx(() {
                    return loginController.showerror.value
                        ? errocommponent(fontsize: 10.sp)
                        : SizedBox();
                  }),
                  CustomeHeight(4.h),
                  Obx(
                    () => buildTextField(
                        hintText: "Password",
                        controller: loginController.passwordController,
                        focusNode: loginController.passNode,
                        suffixIcon: true,
                        style: TextStyle(
                          color: loginController.isPassFocused.value
                              ? Colors.black
                              : Colors.grey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        obscureText: !loginController.passwordHide.value,
                        onChanged: (value) {
                          loginController.passWord.value = value;
                        },
                        prefixIconData: Icons.lock),
                  ),
                  CustomeHeight(20.h),
                  //***************************  button section ******************************
                  appCommonbutton(
                      onpressed: () {
                        loginController.validatePhoneNumber(context);
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      text: "Login"),
                ],
              ),
            ),

            // *************************************** end login form section **************************

            CustomeHeight(14.h),
            forgotPasswordSec(),

            Spacer(),
            CustomeHeight(20.h),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          UrlLuncher.launchUrls(Constant.termAndCondition);
                        },
                        child: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                              color: AppColors.blacktextcolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                      Text(
                        " |",
                        style: TextStyle(
                            color: AppColors.blacktextcolor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w200),
                      ),
                      GestureDetector(
                        onTap: () {
                          UrlLuncher.launchUrls(Constant.termAndCondition);
                        },
                        child: Text(
                          " Privacy Policy",
                          style: TextStyle(
                              color: AppColors.blacktextcolor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w200),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      "© CampusPro",
                      style: TextStyle(
                          color: AppColors.blacktextcolor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w200),
                    ),
                  )
                ],
              ),
            ),
            CustomeHeight(14.h),
          ],
        ),
      ),
    ),
  );
}

Widget forgotPasswordSec() {
  return Align(
    alignment: Alignment.centerRight,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes.forgotpassword);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Forgot login ID ",
                style: TextStyle(
                    color: AppColors.primarytextcolor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                " or ",
                style: TextStyle(
                    color: AppColors.primarytextcolor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                " Password ?",
                style: TextStyle(
                    color: AppColors.primarytextcolor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
