import 'package:campuspro/Repository/login_repository.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxString mobileNo = ''.obs;
  RxBool showerrortext = false.obs;
  RxString errorText = ''.obs;
  RxBool confirmPassHide = true.obs;
  RxString showNewPassError = ''.obs;
  RxString showConfirmPassError = ''.obs;

  final FocusNode newPassNode = FocusNode();
  final FocusNode confirmPassNode = FocusNode();
  var isNewPassFocused = false.obs;
  var isconfirmPassFocused = false.obs;

  // ***********************************  textediting controller ************************
  TextEditingController mobileController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    newPassNode.addListener(() {
      isNewPassFocused.value = newPassNode.hasFocus;
    });
    confirmPassNode.addListener(() {
      if (confirmPassNode.hasFocus && newPasswordController.text.isEmpty) {
        showNewPassError.value = "Please enter your new password";
        newPassNode.requestFocus();
      }
      isconfirmPassFocused.value = confirmPassNode.hasFocus;
    });
    super.onInit();
  }

  @override
  void onClose() {
    newPassNode.dispose();
    confirmPassNode.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  initialStateData() async {
    mobileNo.value = await Sharedprefdata.getStrigData(Sharedprefdata.mobile);
    mobileController.text = mobileNo.value;
    newPasswordController.text = "";
    confirmPasswordController.text = "";
    showNewPassError.value = "";
    showConfirmPassError.value = "";
    confirmPassHide.value = true;
    errorText.value = '';
    newPassNode.requestFocus();
  }

  changeUserPassword(String newPassword) async {
    try {
      await LoginRepository.changeUserPasswordRepo(newPassword)
          .then((value) async {
        if (value != null) {
          if (value['Status'] == 'Cam-001') {
            Get.snackbar(
              "Success",
              "Your password has been changed successfully.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else {
            Get.snackbar(
              "Error",
              "An error occurred while changing your password. Please try again.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
          Get.offAllNamed(Routes.login);
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
