// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Modal/visitordata_model.dart';
import 'package:campuspro/Screens/Wedgets/bottom_bar.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/customeheight.dart';
import 'package:campuspro/Screens/Wedgets/drawer.dart';
import 'package:campuspro/Screens/Wedgets/getPass/otp.dart';
import 'package:campuspro/Screens/Wedgets/getPass/overflowButton.dart';
import 'package:campuspro/Screens/Wedgets/getPass/visitor_list_widget.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GetPassvisitorHistory extends StatefulWidget {
  const GetPassvisitorHistory({super.key});

  @override
  State<GetPassvisitorHistory> createState() => _GetPassvisitorHistoryState();
}

class _GetPassvisitorHistoryState extends State<GetPassvisitorHistory> {
  final GetPassController getPassController = Get.find<GetPassController>();

  @override
  void initState() {
    getPassController.toMeetdata();
    getPassController.PursposedataGeting();
    getPassController.showvisitorDetails.value = false;
    getPassController.visitorImage.value = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();

    final BottomBarController bottomBarController =
        Get.find<BottomBarController>();
    return Scaffold(
      appBar: customAppBar(context),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: bottomBarController.selectedBottomNavIndex.value,
          onTap: bottomBarController.onItemTappedChangeBottomNavIndex,
        ),
      ),
      drawer: AppDrawer(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(8.0.sp),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0.sp),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Visitor Entry',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(() => getPassController.showErrorfield.value
                              ? Text(
                                  getPassController.errorMessage.value,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                )
                              : SizedBox()),
                          const SizedBox(height: 10),
                          buildTextField(
                            hintText: "Phone Number",
                            maxLength: 10,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              getPassController.mobileNo.value = value;
                            },
                            prefixIconData: Icons.call,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    getPassController.visitorTyep.value =
                                        'Father';
                                    getPassController.searchvistorByMobile();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 3, 42, 61),
                                      borderRadius: BorderRadius.horizontal(),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'F',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Father',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 0),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    getPassController.visitorTyep.value =
                                        'Mother';
                                    getPassController.searchvistorByMobile();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.horizontal(),
                                    ),
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'M',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Mother',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 0),
                          GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              getPassController.visitorTyep.value = 'Other';
                              getPassController.searchvistorByMobile();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.horizontal(),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'O',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                    width: 400,
                                  ),
                                  Text(
                                    'Other',
                                    style: TextStyle(
                                      color: AppColors.blackcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    if (getPassController.showvisitorDetails.value) {
                      return ShowVisitordata(context);
                    } else if (getPassController.showOTPwidget.value) {
                      return otpModule(context);
                    } else {
                      return SizedBox();
                    }
                  })
                ],
              ),
            ),
          ),
          overflowbutton(context),
        ],
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget ShowVisitordata(BuildContext context) {
  final GetPassController getPassController = Get.find<GetPassController>();
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Visitor Image"),
            Column(
              children: [
                Center(
                    child: (() {
                  if (getPassController.visitorImage.value.isNotEmpty) {
                    return Image.file(
                        File(getPassController.visitorImage.toString()));
                  } else if (VisitorData
                      .visitorListDetails.last.imagePath!.isNotEmpty) {
                    return InkWell(
                      onTap: () {
                        getPassController.visitorImagepicker();
                      },
                      child: FadeInImage.assetNetwork(
                        image: VisitorData.visitorListDetails[0].imagePath
                            .toString(),
                        placeholder: "assets/icon/person_icon.png",
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/icon/person_icon.png");
                        },
                      ),
                    );
                  } else {
                    return Image.asset("assets/icon/person_icon.png");
                  }
                }())),
              ],
            ),
            CustomeHeight(10.h),
            const Text("Name"),
            CustomeHeight(6.h),
            buildTextField(
              hintText: "Enter Full Name",
              initialValue: VisitorData.visitorListDetails[0].name!.isNotEmpty
                  ? VisitorData.visitorListDetails[0].name
                  : '',
              onChanged: (value) {
                getPassController.FullName.value = value;
              },
              maxLength: 30,
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIconData: Icons.person,
            ),
            CustomeHeight(10.h),
            const Text("Address"),
            CustomeHeight(6.h),
            buildTextField(
              hintText: "Enter Full Address",
              onChanged: (value) {
                getPassController.adress.value = value;
              },
              maxLength: 100,
              initialValue:
                  VisitorData.visitorListDetails.last.address!.isNotEmpty
                      ? VisitorData.visitorListDetails.last.address
                      : '',
              obscureText: false,
              keyboardType: TextInputType.streetAddress,
              prefixIconData: Icons.home,
            ),
            CustomeHeight(10.h),
            const Text("To Meet"),
            CustomeHeight(6.h),
            Obx(
              () => DropdownButtonFormField<String>(
                value: getPassController.selectedOption.value.isNotEmpty
                    ? getPassController.selectedOption.value
                    : null,
                items: getPassController.toMeetOptions.value.map((value) {
                  return DropdownMenuItem<String>(
                    value: value['id'].toString(),
                    child: Text(value['name'].toString()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    log(newValue);

                    getPassController.selectedOption.value = newValue;
                    // handle value change, e.g., update state or make an API call
                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Set border radius here
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 11.w, vertical: 15.h),
                  isDense: true,
                ),
                hint: Text('Select'),
              ),
            ),
            CustomeHeight(10.h),
            const Text("Purpose"),
            CustomeHeight(6.h),
            DropdownButtonFormField<String>(
                value: getPassController.selectedPurpose.value.isNotEmpty
                    ? getPassController.selectedPurpose.value
                    : null,
                items: getPassController.purposelist.value.map((value) {
                  return DropdownMenuItem<String>(
                    value: value["id"].toString(),
                    child: Text(value["name"].toString()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    log(newValue);
                    getPassController.selectedPurpose.value = newValue;
                    // handle value change, e.g., update state or make an API call
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Set border radius here
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                  isDense: true,
                ),
                hint: Text('Select')),
            CustomeHeight(10.h),
            Text("Other"),
            buildTextField(
              hintText: "Enter Other Message",
              onChanged: (value) {
                getPassController.otherMessage.value = value;
              },
              maxLength: 80,
              initialValue: "",
              obscureText: false,
              keyboardType: TextInputType.text,
              prefixIconData: Icons.message,
            ),
            CustomeHeight(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (getPassController.visitorImage.value.isNotEmpty ||
                        VisitorData
                            .visitorListDetails.last.imagePath!.isNotEmpty) {
                      getPassController.updateVisitorDetails(context);
                    } else {
                      getPassController.visitorImagepicker();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.appbuttonColor),
                  child: Obx(() => (getPassController
                              .visitorImage.value.isNotEmpty ||
                          VisitorData
                              .visitorListDetails.last.imagePath!.isNotEmpty)
                      ? Text(
                          'Save',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp),
                        )
                      : Icon(
                          Icons.camera_enhance,
                          color: Colors.white,
                        )),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
