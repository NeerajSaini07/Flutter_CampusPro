// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void idProvebottom(BuildContext context) {
  final GetPassController getPassController = Get.find<GetPassController>();
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Take a photo'),
            onTap: () async {
              Navigator.pop(context);
              getPassController.imagesource.value = 'Cemra';
              getPassController.idProofVerify(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Choose from gallery'),
            onTap: () async {
              Navigator.pop(context);
              getPassController.imagesource.value = 'Gellery';
              getPassController.idProofVerify(context);
            },
          ),
        ],
      );
    },
  );
}
