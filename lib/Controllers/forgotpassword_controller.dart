import 'dart:developer';

import 'package:campuspro/Repository/forgotpassword_repository.dart';
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
  final TextEditingController createPassword = TextEditingController();
  final TextEditingController conformPassword = TextEditingController();

  Future<void> forgotpass() async {
    await ForgotPasswordRepository.checkschool().then((value) {
      if (mobileForForgotPass.value.isNotEmpty) {
        if (selectedvalue.value.isEmpty) {
          if (value != null) {
            showDropDown.value = true;
            var data = value["Data"];
            for (var ele1 in data) {
              items.add([ele1["schoolid"], ele1["SchoolName"]]);
            }
          }
        } else {
          Get.toNamed(Routes.opt);
        }
      } else {}
    });
  }

  createpasswordFormValidate() {
    if (createPassword.text.isNotEmpty && createPassword.text.isNotEmpty) {
      savepassword();
    }
    if (createPassword.text.isEmpty) {
      showerrortext.value = true;
      errorText.value = "fill the input field";
    }
  }

  savepassword() {
    if (createPassword.text != conformPassword.text) {
      log("password not mach");
      showerrortext.value = true;
      errorText.value = "Password Not Match";
    }
  }
}
