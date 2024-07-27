// ignore_for_file: prefer_const_constructors

import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisitorHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("vistor history"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today Visitor History"),
          CustomeHeight(20.h),
          ListTile(
            leading: Image.network(VisitorHistory
                .visitorHistoryListDetails.last.visitorImagePath
                .toString()),
            title: Text(VisitorHistory
                .visitorHistoryListDetails.last.visitorName
                .toString()),
            subtitle: Text(VisitorHistory
                .visitorHistoryListDetails.last.visitorAddress
                .toString()),
            trailing:
                ElevatedButton(onPressed: () {}, child: Text("View Details")),
          )
        ],
      ),
    );
  }
}
