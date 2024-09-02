// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Repository/forgotpassword_repository.dart';
import 'package:campuspro/Screens/Wedgets/contact_detail_popup.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final RxString mobileForForgotPass = ''.obs;

  var items = [].obs;
  RxString forgotPassMobile = ''.obs;
  RxBool showDropDown = false.obs;
  var selectedvalue = ''.obs;
  var selectedDropDownId = ''.obs;
  RxBool showerrortext = false.obs;
  RxString errorText = ''.obs;
  RxString otperrorText = ''.obs;
  RxString otpValue = ''.obs;
  RxBool passwordfielderror = false.obs;
  RxBool confrmpasserrofield = false.obs;
  RxBool globleError = false.obs;

  // ***********************************  textediting controller ************************
  TextEditingController createPassword = TextEditingController();

  TextEditingController conformPassword = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    clearvalue();
  }

  void clearvalue() {
    forgotPassMobile.value = '';
    selectedvalue.value = '';
    selectedDropDownId.value = '';
    items.value = [];
    showDropDown.value = false;
    errorText.value = '';
    mobileForForgotPass.value = '';
  }

  @override
  void onClose() {
    createPassword.dispose();
    conformPassword.dispose();
    selectedDropDownId.value = '';
    selectedvalue.value = '';
    forgotPassMobile.value = '';
    items.clear();
    super.onClose();
  }

  // ******************************************** method start *********************

  Future<void> forgotpassForFetchSchool() async {
    await ForgotPasswordRepository.checkschool().then((value) {
      if (mobileForForgotPass.value.isNotEmpty) {
        // if (selectedvalue.value.isEmpty) {
        if (value != null) {
          if (value['Status'] == 'Y') {
            showerrortext.value = false;
            showDropDown.value = true;
            var data = value["Data"];
            for (var ele1 in data) {
              items.add([ele1["schoolid"], ele1["SchoolName"]]);
            }

//  *****************************************
//  here i am define if list item length is one then make sure thet dropdown will not open and selected value is fullfile in background from hgere
// ********************************************

            if (items.length == 1) {
              String singleItemValue = items[0][1];
              if (selectedvalue.value != singleItemValue) {
                selectedvalue.value = singleItemValue;
                selectedDropDownId.value = items[0][0];
              }
              showDropDown.value = false;
            }

            showerrortext.value = false;
          } else {
            showerrortext.value = true;
            errorText.value = "Mobile Number Not Registered";
          }
        }
      }
      // }
    });
  }

  Future<dynamic> forgetPasswordForSendotp() async {
    if (errorText.value == "Mobile Number Not Registered") {
      showerrortext.value = true;
    } else if (selectedvalue.isEmpty) {
      showerrortext.value = true;
      errorText.value = "Please Select The School";
    } else {
      await ForgotPasswordRepository.sendForOTP().then((value) async {
        var data = value['Data'];
        if (value != null && value['Status'] == 'Y') {
          Get.snackbar(
            "OTP Resend",
            'OTP has been Sent On Your Mobile Numner',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          await Future.delayed(Duration(milliseconds: 1000));
          Get.toNamed(Routes.opt);
          showerrortext.value = false;
          errorText.value = "";
        } else if (data.isEmpty) {
          Get.snackbar(
            "OTP Resend Request",
            'Please wait 1 minute before Re-Sending OTP',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else if (value != null && value['Status'] == 'N') {
          if (data is List &&
              (data.first['MobileNo'] != null ||
                  data.first['MobileNo'] != null)) {
            Get.dialog(ContactDialog(
              mobileNumber: data.first['MobileNo'] ?? "",
              emailAddress: data.first['Email'] ?? "",
            ));
          } else {
            Get.snackbar(
              "OTP Error",
              value['Message'],
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        }
      });
    }
  }

  createpasswordFormValidate() {
    if (createPassword.text.isEmpty) {
      passwordfielderror.value = true;
      confrmpasserrofield.value = false;
      globleError.value = false;
      errorText.value = "Please Enter Password";
    } else if (conformPassword.text.isEmpty) {
      confrmpasserrofield.value = true;
      passwordfielderror.value = false;
      globleError.value = false;
      errorText.value = "Please Enter Confirm Password";
    } else {
      passwordfielderror.value = false;
      confrmpasserrofield.value = false;
      errorText.value = "";
      savepassword();
    }
  }

  Future<dynamic> verifyOTP() async {
    await ForgotPasswordRepository.otpVerification().then((value) {
      if (value != null) {
        if (value['Status'] == 'Y') {
          Get.toNamed(Routes.CreatePassword);
          showerrortext.value = false;
        } else {
          showerrortext.value = true;
          otperrorText.value = "Invalid OTP";
        }
      }
    });
  }

  savepassword() async {
    if (createPassword.text != conformPassword.text) {
      globleError.value = true;
      errorText.value = "Password Not Match";
    } else {
      await ForgotPasswordRepository.changesPassword().then((value) {
        if (value != null && value['Status'] == 'Y') {
          Get.snackbar('Success', 'Password changed successfully',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
              duration: const Duration(
                  seconds:
                      2) // Duration for how long the snackbar will be displayed
              );

          selectedvalue.value = '';
          selectedDropDownId.value = '';
          mobileForForgotPass.value = '';
          items.clear();

          // Delay the navigation to allow the snackbar to be shown
          Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed(
                Routes.login); // Replace '/login' with your actual login route
          });
        } else {
          showerrortext.value = true;
          errorText.value = value['Message'];
        }
      });
    }
  }
}

void showContactInfoDialog(String mobile, String email) {
  Get.defaultDialog(
    barrierDismissible: false,
    title: "Please Contact For Help",
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("It seems you don't have enough SMS balance."),
        SizedBox(height: 10),
        Text("Please contact us for help:"),
        SizedBox(height: 10),
        Text("Mobile: $mobile"),
        Text("Email: $email"),
      ],
    ),
    textConfirm: "OK",
    confirmTextColor: Colors.white,
    onConfirm: () {
      Get.back(); // Close the dialog
    },
  );
}
