import 'package:campuspro/Repository/forgotpassword_repository.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final RxString mobileForForgotPass = ''.obs;

  var items = [].obs;
  // RxString forgotPassMobile = ''.obs;
  RxBool showDropDown = false.obs;
  var selectedvalue = ''.obs;
  var selectedDropDownId = ''.obs;
  RxBool showerrortext = false.obs;
  RxString errorText = ''.obs;
  RxString otperrorText = ''.obs;
  RxString otpValue = ''.obs;

  // ***********************************  textediting controller ************************
  final TextEditingController mobileNumberController = TextEditingController();

  TextEditingController createPassword = TextEditingController();

  TextEditingController conformPassword = TextEditingController();

  @override
  void onClose() {
    createPassword.dispose();
    conformPassword.dispose();
    super.onClose();
  }

  initialStateData() async {
    items.value = [];
    mobileForForgotPass.value = '';
    selectedvalue.value = '';
    mobileNumberController.text = '';
    selectedDropDownId.value = '';
    showDropDown.value = false;
    showerrortext.value = false;
    errorText.value = '';
  }

  // ******************************************** method start *********************

  Future<void> forgotpassForFetchSchool() async {
    items.value = [];
    selectedDropDownId.value = "";

    await ForgotPasswordRepository.checkschool().then((value) {
      // if (mobileForForgotPass.value.isNotEmpty) {
      //   if (selectedvalue.value.isEmpty) {
      if (value != null) {
        if (value['Status'] == 'Y') {
          showerrortext.value = false;
          showDropDown.value = true;
          var data = value["Data"];
          for (var ele1 in data) {
            items.add([ele1["schoolid"], ele1["SchoolName"]]);
          }
          if (items.value.length == 1) {
            selectedDropDownId.value = items.value.first.first;
          }
          showerrortext.value = false;
        } else {
          showerrortext.value = true;
          errorText.value = value["Message"];
        }
      }
      //   }
      // }
    });
  }

  Future<dynamic> forgetPasswordForSendotp() async {
    await ForgotPasswordRepository.sendForOTP().then((value) {
      if (value != null && value['Status'] == 'Y') {
        Get.offAllNamed(Routes.opt);
      } else if (value != null && value['Status'] == 'N') {
        Get.snackbar(
          'Error',
          value["Message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(
              seconds:
                  2), // Duration for how long the snackbar will be displayed
        );

        // Delay the navigation to allow the snackbar to be shown
        Future.delayed(const Duration(seconds: 2), () {
          Get.toNamed(
              Routes.login); // Replace '/login' with your actual login route
        });
      }
    });
  }

  createpasswordFormValidate() {
    if (createPassword.text.isNotEmpty && createPassword.text.isNotEmpty) {
      savepassword();
      showerrortext.value = false;
    }
    if (createPassword.text.isEmpty) {
      showerrortext.value = true;
      errorText.value = "fill the input field";
    }
  }

  Future<dynamic> verifyOTP() async {
    await ForgotPasswordRepository.otpVerification().then((value) {
      if (value != null) {
        // print(value);
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
      showerrortext.value = true;
      errorText.value = "Password Not Match";
    }

    await ForgotPasswordRepository.changesPassword().then((value) {
      if (value != null && value['Status'] == 'Y') {
        Get.snackbar(
          'Success',
          'Password changed successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(
              seconds:
                  2), // Duration for how long the snackbar will be displayed
        );

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
