// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Screens/Wedgets/common_button.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Services/urlLuncher/web_url_luncher.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'common_form_component.dart';
import 'company_logo_component.dart';
import 'error_commponet.dart';

Widget loginFormCard(BuildContext context) {
  final LoginController loginController = Get.find<LoginController>();

  return Card(
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomeHeight(10.h),
          companylog(),

          CustomeHeight(20.h),
          Text("Welcome !",
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.appbuttonColor)),

          Obx(() {
            return loginController.gloableError.value
                ? errocommponent(
                    fontsize: 12.sp, errorText: loginController.formErrorText)
                : SizedBox();
          }),
          CustomeHeight(20.h),

          //buildLabels("Mobile Number"),

//  ********************************  login form  *************************************
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField(
                    hintText: "Phone Number",
                    controller: loginController.mobileNumberController,
                    maxLength: 10,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      loginController.showerror.value = false;
                      loginController.gloableError.value = false;
                      loginController.mobileNumber.value = value;
                    },
                    prefixIconData: Icons.call),

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
                      suffixIcon: true,
                      obscureText: loginController.passwordHide.value,
                      onChanged: (value) {
                        loginController.passWord.value = value;
                      },
                      prefixIconData: Icons.lock),
                ),
                CustomeHeight(16.h),
                //****************  *********  button section ******************************
                appCommonbutton(
                    onpressed: () {
                      loginController.validatePhoneNumber(context);
                    },
                    text: "Login"),
              ],
            ),
          ),

// *************************************** end login form section **************************

          CustomeHeight(12.h),
          forgotPasswordSec(),

          Spacer(),
          //  CustomeHeight(20.h),
          Expanded(
              child: Align(
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
                            color: AppColors.textfieldhintstycolor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    Text(
                      " |",
                      style: TextStyle(
                          color: AppColors.textfieldhintstycolor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300),
                    ),
                    GestureDetector(
                      onTap: () {
                        UrlLuncher.launchUrls(Constant.termAndCondition);
                      },
                      child: Text(
                        " Privacy Policy",
                        style: TextStyle(
                            color: AppColors.textfieldhintstycolor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    "© CampusPro",
                    style: TextStyle(
                        color: AppColors.textfieldhintstycolor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w300),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    ),
  );
}

Widget forgotPasswordSec() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.forgotpassword);
        },
        child: Text(
          "Forgot login ID ",
          style: TextStyle(
              color: AppColors.appbuttonColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
      Text(
        " or ",
        style: TextStyle(
            color: AppColors.appbuttonColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600),
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.forgotpassword);
        },
        child: Text(
          " Forgot Password",
          style: TextStyle(
              color: AppColors.appbuttonColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
