// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:campuspro/Controllers/GetPassController/getpassController.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Modal/visitordata_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/Wedgets/common_form_component.dart';
import 'package:campuspro/Screens/Wedgets/error_text.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Wedgets/customeheight.dart';

class VisitorDetialsPage extends StatelessWidget {
  const VisitorDetialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GetPassController getPassController = Get.find<GetPassController>();

    final AppbarController appbarController = Get.find<AppbarController>();
    return WillPopScope(
      onWillPop: () async {
        appbarController.appBarName.value = Constant.schoolName;
        getPassController.mobileNo.value = '';
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: customAppBar(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _profileIcon(context, getPassController),
                        CustomeHeight(10.h),
                        buildTextField(
                          hintText: "Enter Full Name",
                          initialValue:
                              VisitorData.visitorListDetails[0].name!.isNotEmpty
                                  ? VisitorData.visitorListDetails[0].name
                                  : '',
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              getPassController.errorMessageVisitorName.value =
                                  '';
                              getPassController.FullName.value = value;
                            } else {
                              getPassController.FullName.value = '';
                            }
                          },
                          style: TextStyle(fontSize: 16.sp),
                          maxLength: 30,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIconData: Icons.person,
                        ),
                        Obx(() {
                          return getPassController
                                  .errorMessageVisitorName.value.isNotEmpty
                              ? errorWidget(
                                  errorText: getPassController
                                      .errorMessageVisitorName.value)
                              : const SizedBox();
                        }),
                        CustomeHeight(12.h),
                        buildTextField(
                          hintText: "Enter Full Address",
                          onChanged: (value) {
                            if (value.trim().isNotEmpty) {
                              getPassController.adress.value = value;
                              getPassController
                                  .errorMessageVisitorAddress.value = '';
                            } else {
                              getPassController.adress.value = '';
                            }
                          },
                          maxLength: 100,
                          style: TextStyle(fontSize: 16.sp),
                          initialValue: VisitorData
                                  .visitorListDetails.last.address!.isNotEmpty
                              ? VisitorData.visitorListDetails.last.address
                              : '',
                          obscureText: false,
                          keyboardType: TextInputType.streetAddress,
                          prefixIconData: Icons.home,
                        ),
                        Obx(() {
                          return getPassController
                                  .errorMessageVisitorAddress.value.isNotEmpty
                              ? errorWidget(
                                  errorText: getPassController
                                      .errorMessageVisitorAddress.value)
                              : const SizedBox();
                        }),
                        CustomeHeight(12.h),
                        Obx(
                          () => DropdownButtonFormField<String>(
                            value: getPassController
                                    .selectedOption.value.isNotEmpty
                                ? getPassController.selectedOption.value
                                : null,
                            items: getPassController.toMeetOptions.value
                                .map((value) {
                              return DropdownMenuItem<String>(
                                value: value['id'].toString(),
                                child: Text(value['name'].toString()),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                log(newValue);
                                getPassController
                                    .errorMessageVisitortooMeet.value = '';
                                getPassController.selectedOption.value =
                                    newValue;
                                // handle value change, e.g., update state or make an API call
                              }
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      width: 0.2, color: Colors.grey)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      width: 0.2, color: Colors.grey)),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 11.w, vertical: 15.h),
                              isDense: true,
                            ),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            hint: Text(
                              'Select Too Meet',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return getPassController
                                  .errorMessageVisitortooMeet.value.isNotEmpty
                              ? errorWidget(
                                  errorText: getPassController
                                      .errorMessageVisitortooMeet.value)
                              : const SizedBox();
                        }),
                        CustomeHeight(12.h),
                        DropdownButtonFormField<String>(
                          value:
                              getPassController.selectedPurpose.value.isNotEmpty
                                  ? getPassController.selectedPurpose.value
                                  : null,
                          items:
                              getPassController.purposelist.value.map((value) {
                            return DropdownMenuItem<String>(
                              value: value["id"].toString(),
                              child: Text(value["name"].toString()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              log(newValue);
                              getPassController
                                  .errorMessageVisitorPurpose.value = '';
                              getPassController.selectedPurpose.value =
                                  newValue;
                              if (getPassController.purposelist.value
                                      .firstWhere((element) =>
                                          element['id'] == newValue)['name'] ==
                                  "Other") {
                                getPassController.showPurposeTxtField.value =
                                    true;
                              } else {
                                getPassController.showPurposeTxtField.value =
                                    false;
                              }
                              // handle value change, e.g., update state or make an API call
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 0.2, color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    width: 0.2, color: Colors.grey)),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 11.w, vertical: 15.h),
                            isDense: true,
                          ),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          hint: Text(
                            'Select Purpose',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Obx(() {
                          return getPassController
                                  .errorMessageVisitorPurpose.value.isNotEmpty
                              ? errorWidget(
                                  errorText: getPassController
                                      .errorMessageVisitorPurpose.value)
                              : const SizedBox();
                        }),
                        CustomeHeight(12.h),
                        Obx(
                          () => (getPassController.showPurposeTxtField.value)
                              ? buildTextField(
                                  hintText: "Other Purpose",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  onChanged: (value) {
                                    if (value.trim().isNotEmpty) {
                                      getPassController.otherMessage.value =
                                          value;
                                      getPassController
                                          .errorMessageVisitorPurposetxt
                                          .value = '';
                                    } else {
                                      getPassController.otherMessage.value = '';
                                    }
                                  },
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 14.w),
                                  maxLines: 2,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                )
                              : const SizedBox(),
                        ),
                        Obx(() {
                          return getPassController.errorMessageVisitorPurposetxt
                                  .value.isNotEmpty
                              ? errorWidget(
                                  errorText: getPassController
                                      .errorMessageVisitorPurposetxt.value)
                              : const SizedBox();
                        }),
                        CustomeHeight(10.h),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 10.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (getPassController.checkVistorDetailForm()) {
                          if (getPassController.visitorImage.value.isNotEmpty ||
                              VisitorData.visitorListDetails.last.imagePath!
                                  .isNotEmpty) {
                            getPassController.updateVisitorDetails(context);
                          } else {
                            await getPassController.visitorImagepicker();
                            getPassController.updateVisitorDetails(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.w)),
                          backgroundColor: AppColors.appbuttonColor),
                      child:
                          Obx(() => (getPassController.visitorFormLoader.value)
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.sp),
                                )),
                    ),
                  ),
                ),
              ],
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

  Widget _profileIcon(
      BuildContext context, GetPassController getPassController) {
    return Center(
      child: Obx(
        () => Stack(
          children: [
            Container(
              width: 150.w,
              height: 150.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: (() {
                    if (getPassController.visitorImage.value.isNotEmpty) {
                      // Use FileImage to create an ImageProvider from a file
                      return FileImage(
                        File(getPassController.visitorImage.toString()),
                      );
                    } else if (VisitorData
                        .visitorListDetails.last.imagePath!.isNotEmpty) {
                      // Use NetworkImage to create an ImageProvider from a URL
                      return NetworkImage(VisitorData
                          .visitorListDetails[0].imagePath
                          .toString());
                    } else {
                      // Use AssetImage to create an ImageProvider from an asset
                      return const AssetImage(Constant.usericon);
                    }
                  }()) as ImageProvider<Object>, // Ensure type safety
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(150.w),
                onTap: () {
                  getPassController.visitorImagepicker();
                },
                child: Container(),
              ),
            ),
            Positioned(
              bottom: 8.w,
              right: 8.w,
              child: InkWell(
                borderRadius: BorderRadius.circular(20.w),
                onTap: () {
                  getPassController.visitorImagepicker();
                },
                child: Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 20.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
