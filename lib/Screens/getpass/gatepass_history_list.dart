import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Screens/Wedgets/getPass/vistor_gatepass_card.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GatePassHistoryListScreen extends StatefulWidget {
  const GatePassHistoryListScreen({super.key});

  @override
  State<GatePassHistoryListScreen> createState() =>
      _GatePassHistoryListScreenState();
}

class _GatePassHistoryListScreenState extends State<GatePassHistoryListScreen> {
  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();
    final AppbarController appbarController = Get.find<AppbarController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPassController.getpassHistory();
    });
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primarycolor,
          centerTitle: false,
          title: const Text(
            'GatePass History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                appbarController.appBarName.value = Constant.schoolName;
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: Obx(
          () => getPassController.gatePassHistoryData.value.isEmpty
              ? const Center(child: Text('No data available'))
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  itemCount: getPassController.gatePassHistoryData.value.length,
                  itemBuilder: (context, index) {
                    return vistorGatepassListCardWidget(
                        context: context,
                        getPassController: getPassController,
                        index: index,
                        type: "g");
                  },
                  separatorBuilder: (BuildContext context, index) =>
                      const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ),
        ));
  }
}
