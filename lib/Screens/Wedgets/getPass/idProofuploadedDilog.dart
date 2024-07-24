// ignore_for_file: file_names

import 'package:flutter/material.dart';

showUploadDialog(BuildContext context, bool success) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(success ? 'Success' : 'Failure'),
        content: Text(success
            ? 'ID Proof uploaded successfully!'
            : 'Failed to upload ID Proof. Please try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
