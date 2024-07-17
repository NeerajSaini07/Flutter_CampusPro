import 'package:campuspro/Controllers/login_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

Widget errocommponent({fontsize}) {
  final LoginController loginController = Get.find<LoginController>();
  return Text(
    loginController.formErrorText.value,
    style: TextStyle(
      fontSize: fontsize,
      fontWeight: FontWeight.w500,
      color: Colors.red,
    ),
  );
}
