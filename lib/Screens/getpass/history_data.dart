import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Screens/Wedgets/getPass/vistor_gatepass_card.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Wedgets/common_appbar.dart';

class VisitorHistoryPage extends StatelessWidget {
  const VisitorHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();

    final AppbarController appbarController = Get.find<AppbarController>();

    return WillPopScope(
      onWillPop: () async {
        appbarController.appBarName.value = Constant.schoolName;
        return true;
      },
      child: Scaffold(
        appBar: customAppBar(context),
        body: Obx(
          () => getPassController.vistorData.value.isEmpty
              ? const Center(child: Text('No data available'))
              : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  itemCount: getPassController.vistorData.value.length,
                  itemBuilder: (context, index) {
                    return vistorGatepassListCardWidget(
                        context: context,
                        getPassController: getPassController,
                        index: index,
                        type: "v");
                  },
                ),
        ),
      ),
    );
  }
}
