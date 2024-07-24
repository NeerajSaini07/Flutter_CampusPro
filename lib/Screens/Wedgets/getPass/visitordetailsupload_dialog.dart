import 'package:flutter/material.dart';

showuploadVisitorDialog(BuildContext context, bool success) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(success ? 'Success' : 'Failure'),
        content: Text(success
            ? 'Visitor uploaded successfully!'
            : 'Failed to upload Visitor. Please try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
