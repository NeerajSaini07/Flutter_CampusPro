// ignore_for_file: unnecessary_null_in_if_null_operators, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:ffi';

import 'package:campuspro/Controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Card buildTextField({
  bool obscureText = false,
  bool? suffixIcon = false,
  int? maxLength,
  bool? suffixCustomIcon = false,
  Widget? customWidget,
  int? maxLines = 1,
  String? hintText,
  bool readOnly = false,
  TextStyle? style = const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  EdgeInsets? contentPadding = const EdgeInsets.symmetric(vertical: 14.0),
  FocusNode? focusNode,
  TextInputAction? textInputAction,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
  IconData? prefixIconData,
  TextEditingController? controller,
  List<TextInputFormatter>? inputFormatters,
  String? initialValue,
}) {
  final LoginController loginController = Get.find<LoginController>();
  return Card(
    elevation: 0.6,
    color: Colors.white,
    child: TextFormField(
      textInputAction: textInputAction,
      initialValue: initialValue,
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: style,
      onFieldSubmitted: (value) {},
      onChanged: onChanged,
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 0.2, color: Colors.grey)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 0.2, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 0.2, color: Colors.grey)),
        prefixIcon: prefixIconData != null
            ? Icon(
                prefixIconData,
                color: Color(0xff1f6089),
                size: 16.sp,
              )
            : null,
        hintText: hintText,

        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        counterText: "",
        contentPadding: contentPadding, // Adjust vertical padding
        suffixIcon: suffixIcon == true
            ? suffixCustomIcon == true
                ? customWidget
                : Obx(
                    () => IconButton(
                      icon: !loginController.passwordHide.value
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
