// ignore_for_file: unnecessary_null_in_if_null_operators, prefer_const_constructors, avoid_unnecessary_containers

import 'package:campuspro/Controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Container buildTextField({
  bool obscureText = false,
  bool? suffixIcon = false,
  int? maxLength,
  String? hintText,
  TextInputAction? textInputAction,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  IconData? prefixIconData,
  TextEditingController? controller,
  String? initialValue,
}) {
  final LoginController loginController = Get.find<LoginController>();
  return Container(
    child: Card(
      elevation: 0.5,
      child: TextFormField(
        textInputAction: textInputAction,
        initialValue: initialValue,
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        maxLength: maxLength,
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.black, // Match hint text color
          fontSize: 18.sp, // Match hint text font size
          fontWeight: FontWeight.w700, // Match hint text font weight
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          prefixIcon: prefixIconData != null ? Icon(prefixIconData) : null,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          counterText: "",
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.0), // Adjust vertical padding
          suffixIcon: suffixIcon == true
              ? Obx(
                  () => IconButton(
                    icon: loginController.passwordHide.value
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: () {
                      loginController.showHidePassword();
                    },
                  ),
                )
              : null,
        ),
      ),
    ),
  );
}

Widget buildLabels(String label) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xff515157),
          fontWeight: FontWeight.w700,
        ),
      ),
      Positioned(
        top: -4, // Adjust the position as needed
        right: -14, // Adjust the position as needed
        child: Text(
          ' *',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}
