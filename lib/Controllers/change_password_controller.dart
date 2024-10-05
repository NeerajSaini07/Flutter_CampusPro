import 'package:campuspro/Controllers/logout_controller.dart';
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
  RxBool oldPassHide = true.obs;
  RxString showNewPassError = ''.obs;
  RxString showOldPassError = ''.obs;
  RxString showConfirmPassError = ''.obs;

  final FocusNode newPassNode = FocusNode();
  final FocusNode confirmPassNode = FocusNode();
  final FocusNode oldPassNode = FocusNode();
  var isOldPassFocused = false.obs;
  var isNewPassFocused = false.obs;
  var isconfirmPassFocused = false.obs;

  // ***********************************  textediting controller ************************
  TextEditingController mobileController = TextEditingController();

  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void onInit() {
    oldPassNode.addListener(() {
      isOldPassFocused.value = oldPassNode.hasFocus;
    });
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
    showOldPassError.value = "";
    showConfirmPassError.value = "";
    confirmPassHide.value = true;
    oldPassHide.value = true;
    errorText.value = '';
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
          } else if (value['Status'] == 'Cam-003') {
            Get.toNamed(Routes.userType);
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

  changeSpecificUserPassword(
      BuildContext context, String newPassword, String oldPassword) async {
    final LogoutController logoutController = Get.find<LogoutController>();
    try {
      await LoginRepository.changeSpecificUserPasswordRepo(
              newPassword, oldPassword)
          .then((value) async {
        if (value != null) {
          if (value['Status'] == 'Cam-001') {
            if (value['Data'].first['Message'].toString().toLowerCase() ==
                "success") {
              Get.snackbar(
                "Success",
                "Your password has been changed successfully.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
              logoutController.userlogOut();
            } else {
              Get.snackbar(
                "Error",
                value['Data'].first['Message'] ??
                    "An error occurred while changing your password. Please try again.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          } else if (value['Status'] == 'Cam-003') {
            Get.toNamed(Routes.userType);
          } else {
            Get.snackbar(
              "Error",
              "An error occurred while changing your password. Please try again.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
          newPasswordController.clear();
          confirmPasswordController.clear();
          oldPasswordController.clear();
          FocusScope.of(context).unfocus();
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
