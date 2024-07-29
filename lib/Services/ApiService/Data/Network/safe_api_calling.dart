import 'package:campuspro/main.dart';
import 'package:flutter/material.dart';

void showAlertDialog(String title, String content) {
  showDialog(
    context: navigatorKey.currentState!.overlay!.context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
//   try {
//     return await apiCall();
//   } on AppExceptions catch (e) {
//     showAlertDialog("Error", e.toString());
//     rethrow;
//   } catch (e) {
//     showAlertDialog("Error", "An unexpected error occurred: $e");
//     rethrow;
//   }
// }
