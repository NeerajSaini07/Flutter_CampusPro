import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Modal/gatepass_history_model.dart';

import 'package:campuspro/Utilities/colors.dart';
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
                    final gatePassData =
                        getPassController.gatePassHistoryData.value[index];
                    return gatePassCardView(context, gatePassData, index);
                  },
                  separatorBuilder: (BuildContext context, index) =>
                      const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ),
        ));
  }

  Widget gatePassCardView(
      BuildContext context, GatePassHistoryModel gatePassData, int index) {
    final GetPassController getPassController = Get.find<GetPassController>();
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              Row(
                children: [
                  // Replacing CircleAvatar with Container for a rectangular image
                  // Container(
                  //   width: 100.w, // Adjust width to match desired size
                  //   height: 100.w, // Adjust height to match desired size
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(6.0), // Adjust the radius as needed
                  //     image:   gatePassData.visitorImagePath!.isEmpty
                  //         ? null
                  //         : DecorationImage(
                  //             image: NetworkImage(  gatePassData.visitorImagePath.toString()),
                  //             fit: BoxFit.fill,
                  //           ),
                  //     color:   gatePassData.visitorImagePath!.isEmpty ? Colors.grey : null,
                  //   ),
                  //   child:   gatePassData.visitorImagePath!.isEmpty
                  //       ? Icon(Icons.person, size: 30.w) // Adjust icon size as needed
                  //       : null,
                  // ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tooltip(
                          decoration: const BoxDecoration(color: Colors.white),
                          triggerMode: TooltipTriggerMode.tap,
                          textStyle:
                              TextStyle(fontSize: 10.sp, color: Colors.black),
                          message: gatePassData.name ??
                              "N/A", // Full name for tooltip
                          child: Text(
                            gatePassData.name != null &&
                                    gatePassData.name!.length > 20
                                ? '${gatePassData.name!.substring(0, 20)}...'
                                : gatePassData.name ?? "N/A",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w300,
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Truncate the text if too long
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Purpose: ${gatePassData.purpose ?? "N/A"}',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        Text(
                          'Pass Type: ${gatePassData.passType}',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        Text(
                          'Entry Time: ${gatePassData.time ?? "N/A"}',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        Text(
                          'Mobile No: ${gatePassData.contactNo ?? "N/A"}',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              if (gatePassData.toTime == null || gatePassData.toTime!.isEmpty)
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      getPassController.markGatePassExitApi(index);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appbuttonColor,
                    ),
                    child: const Text(
                      'Exit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  // Obx(
  //   () => Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           if (getPassController.gatePassId.value == gatePassData.id) {
  //             getPassController.gatePassId.value = 0;
  //           } else {
  //             getPassController.gatePassId.value = gatePassData.id ?? 0;
  //           }
  //         },

  //         child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Text(
  //                       gatePassData.name ?? "N/A",
  //                       textScaler: TextScaler.noScaling,
  //                       style: TextStyle(
  //                         fontSize: 16.sp,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     CustomeHeight(2.h),
  //                     // Text(
  //                     //   'Purpose: ${gatePassData.purpose}',
  //                     //   textScaler: TextScaler.noScaling,
  //                     //   overflow: TextOverflow.ellipsis,
  //                     //   maxLines: 14,
  //                     //   style: TextStyle(
  //                     //     fontSize: 14.sp,
  //                     //     color: Colors.grey[500],
  //                     //     fontWeight: FontWeight.w500,
  //                     //   ),
  //                     // ),
  //                       headingContent(
  //                 heading: "Purpose : ",
  //                 content: gatePassData.purpose ?? "N/A"),
  //                      headingContent(
  //                 heading: "Entry Time : ",
  //                 content: gatePassData.time ?? "N/A"),
  //             headingContent(
  //                 heading: "Exit Time : ",
  //                 content: gatePassData.toTime ?? "N/A"),
  //             headingContent(
  //                 heading: "Mobile No : ",
  //                 content: gatePassData.contactNo ?? "N/A"),
  //             headingContent(
  //                 heading: "Pass Type : ",
  //                 content: gatePassData.passType ?? "N/A"),
  //                   ],
  //                 ),
  //               ),
  //               gatePassData.toTime != null && gatePassData.toTime!.isNotEmpty
  //                   ? const SizedBox.shrink()
  //                   : ElevatedButton(
  //                       onPressed: () {
  //                         getPassController.markGatePassExitApi(index);
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: AppColors.appbuttonColor),
  //                       child: const Text('Exit',
  //                           style: TextStyle(color: Colors.white)),
  //                     )
  //             ],
  //           ),
  //         ),
  //       ),
  //       Visibility(
  //         visible: getPassController.gatePassId.value == gatePassData.id,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             CustomeHeight(6.h),
  //              const Divider(
  //               height: 1,
  //               thickness: 1,
  //             ),
  //             CustomeHeight(6.h),
  //             // headingContent(
  //             //     heading: "Entry Time : ",
  //             //     content: gatePassData.time ?? "N/A"),
  //             // headingContent(
  //             //     heading: "Exit Time : ",
  //             //     content: gatePassData.toTime ?? "N/A"),
  //             // headingContent(
  //             //     heading: "Mobile No : ",
  //             //     content: gatePassData.contactNo ?? "N/A"),
  //             // headingContent(
  //             //     heading: "Pass Type : ",
  //             //     content: gatePassData.passType ?? "N/A"),
  //           ],
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}

//   Widget headingContent({required String heading, required String content}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 1.w).copyWith(bottom: 6.h),
//       child: Row(
//         children: [
//           Text(
//             heading,
//             textScaler: TextScaler.noScaling,
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.black,
//               fontWeight: FontWeight.w300,
//             ),
//           ),
//           Expanded(
//             child: Text(
//               content,
//               textScaler: TextScaler.noScaling,
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

