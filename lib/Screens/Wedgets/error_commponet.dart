import 'package:flutter/material.dart';

Widget errocommponent({fontsize, errorText}) {
  return Text(
    errorText.value,
    style: TextStyle(
      fontSize: fontsize,
      fontWeight: FontWeight.w500,
      color: Colors.red,
    ),
  );
}
