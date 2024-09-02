// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:developer';
import 'dart:io';
import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Modal/visitordata_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/customeheight.dart';
import '../Wedgets/getPass/idproofwidget.dart';

class VisitorDetialsPage extends StatelessWidget {
  const VisitorDetialsPage({super.key});

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
        body: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Obx(
                      () => Container(
                        width: 200.w,
                        height: 200.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: (() {
                              if (getPassController
                                  .visitorImage.value.isNotEmpty) {
                                // Use FileImage to create an ImageProvider from a file
                                return FileImage(
                                  File(getPassController.visitorImage
                                      .toString()),
                                );
                              } else if (VisitorData.visitorListDetails.last
                                  .imagePath!.isNotEmpty) {
                                // Use NetworkImage to create an ImageProvider from a URL
                                return NetworkImage(VisitorData
                                    .visitorListDetails[0].imagePath
                                    .toString());
                              } else {
                                // Use AssetImage to create an ImageProvider from an asset
                                return const AssetImage(
                                    "assets/icon/person_icon.png");
                              }
                            }()) as ImageProvider<Object>, // Ensure type safety
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            showimagepickerOption(
                              context,
                              () => getPassController
                                  .visitorImagepicker(), // Pass it as a callback
                            );
                          },
                          child:
                              Container(), // You can add additional child content here if needed
                        ),
                      ),
                    ),
                  ),
                  CustomeHeight(10.h),
                  lable("Full Name"),
                  CustomeHeight(6.h),
                  buildTextField(
                    hintText: "Enter Full Name",
                    initialValue:
                        VisitorData.visitorListDetails[0].name!.isNotEmpty
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
                  lable("Address"),
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
                  lable("To Meet"),
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
                          borderRadius: BorderRadius.circular(
                              15.0), // Set border radius here
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 11.w, vertical: 15.h),
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
                          borderRadius: BorderRadius.circular(
                              15.0), // Set border radius here
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 15.h),
                        isDense: true,
                      ),
                      hint: Text('Select')),
                  CustomeHeight(10.h),
                  Text("Other"),
                  buildTextField(
                    hintText: "  ",
                    onChanged: (value) {
                      getPassController.otherMessage.value = value;
                    },
                    maxLength: 80,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                  ),
                  CustomeHeight(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (getPassController.visitorImage.value.isNotEmpty ||
                              VisitorData.visitorListDetails.last.imagePath!
                                  .isNotEmpty) {
                            getPassController.updateVisitorDetails(context);
                          } else {
                            showimagepickerOption(context, () {
                              getPassController.idProofVerify(context);
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appbuttonColor),
                        child: Obx(() =>
                            (getPassController.visitorImage.value.isNotEmpty ||
                                    VisitorData.visitorListDetails.last
                                        .imagePath!.isNotEmpty)
                                ? Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.sp),
                                  )
                                : const Icon(
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
        ),
      ),
    );
  }

  Widget lable(lablename) {
    return Text("${lablename}",
        style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.blackcolor));
  }
}
