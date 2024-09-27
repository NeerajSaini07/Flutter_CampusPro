import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:campuspro/Controllers/StudentControllers/edit_profile_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/student_module/upload_document_type.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentEditProfileScreen extends StatelessWidget {
  const StudentEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentEditProfileController editProfileController =
        Get.find<StudentEditProfileController>();
    final UserTypeController userTypeController =
        Get.find<UserTypeController>();
    editProfileController.getUploadDocumentTypeList();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: customAppBar(context,
              showProfile: false,
              title: "Edit Profile Request",
              tabView: true,
              tabBarWidget: PreferredSize(
                preferredSize: Size.fromHeight(100.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage: () {
                              if (StudentDetaillist.studentdetails.isNotEmpty) {
                                if (StudentDetaillist
                                    .studentdetails.first.imageUrl
                                    .toString()
                                    .contains("https")) {
                                  return NetworkImage(
                                    StudentDetaillist
                                        .studentdetails.first.imageUrl
                                        .toString(),
                                  );
                                } else {
                                  return null;
                                }
                              }
                              return null;
                            }(),
                            child:
                                (StudentDetaillist.studentdetails.isNotEmpty &&
                                        StudentDetaillist
                                            .studentdetails.first.imageUrl
                                            .toString()
                                            .contains("https"))
                                    ? null
                                    : Image.asset(Constant.usericon),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  UserTypeslist
                                          .userTypesDetails[
                                              userTypeController.usertypeIndex]
                                          .stuEmpName ??
                                      "N/A",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  UserTypeslist
                                          .userTypesDetails[
                                              userTypeController.usertypeIndex]
                                          .userName ??
                                      "",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TabBar(
                      controller: editProfileController.tabController,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor: Colors.white,
                      unselectedLabelStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(
                          text: "Update Profile",
                        ),
                        Tab(
                          text: "Update Document",
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          body: TabBarView(
            controller: editProfileController.tabController,
            children: [
              updateProfileSection(context, editProfileController),
              updateDocumentSection(context, editProfileController),
            ],
          ),
        ),
      ),
    );
  }

  Widget updateDocumentSection(BuildContext context,
      StudentEditProfileController editProfileController) {
    return FutureBuilder<List<UploadDocumentTypeModel>>(
      future: editProfileController.getUploadDocumentTypeList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          final listData = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            itemCount: listData.length,
            itemBuilder: (context, index) {
              return uploadDocumentListCardView(
                  listData[index], editProfileController);
            },
          );
        }
      },
    );
  }

  Widget uploadDocumentListCardView(UploadDocumentTypeModel listData,
      StudentEditProfileController editProfileController) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(2.w).copyWith(left: 6.w),
          margin: EdgeInsets.symmetric(horizontal: 8.w).copyWith(bottom: 10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: AppColors.appbuttonColor, width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listData.docName ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appbuttonColor),
                    ),
                    // SizedBox(
                    //   height: 1.h,
                    // ),
                    // Text(
                    //   "Lgvjhklghjklghjkl",
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //       fontSize: 10.sp,
                    //       fontWeight: FontWeight.bold,
                    //       color: AppColors.textfieldhintstycolor),
                    // ),
                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(4.r),
                onTap: () {
                  editProfileController.uploadStudentDocuments(
                      documentId: listData.docId.toString());
                },
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                      color: AppColors.appbuttonColor,
                      borderRadius: BorderRadius.circular(4.r)),
                  child: Icon(
                    Icons.file_upload_sharp,
                    color: AppColors.whitetextcolor,
                    size: 25.w,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget updateProfileSection(BuildContext context,
      StudentEditProfileController editProfileController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldWidget(
                labelText: "Name", controller: editProfileController.nameC),
            textFieldWidget(
                labelText: "DOB",
                controller: editProfileController.dobC,
                readOnly: true,
                suffixIcon: const Icon(
                  Icons.calendar_month,
                )),
            textFieldWidget(
                labelText: "Father Name",
                controller: editProfileController.fatherNameC),
            textFieldWidget(
                labelText: "Mother Name",
                controller: editProfileController.montherNameC),
            textFieldWidget(
                labelText: "Email", controller: editProfileController.emailC),
            textFieldWidget(
                labelText: "Guardian Mobile No",
                controller: editProfileController.guardianMobileNoC),
            textFieldWidget(
                labelText: "Mobile No",
                controller: editProfileController.mobileNoC),
            Obx(
              () => dropDownTextField(
                  initialItem: editProfileController.selectedGender.value,
                  labelText: "Gender",
                  dropDownList: editProfileController.genderDropDown),
            ),
            Obx(
              () => dropDownTextField(
                  initialItem: editProfileController.selectedBloodGroup.value,
                  labelText: "Blood Group",
                  dropDownList: editProfileController.bloodGroupDropDown),
            ),
            Obx(
              () => dropDownTextField(
                  initialItem: editProfileController.selectedCategory.value,
                  labelText: "Category",
                  dropDownList: editProfileController.categoryDropDown),
            ),
            Obx(
              () => dropDownTextField(
                  initialItem: editProfileController.selectedCaste.value,
                  labelText: "Caste",
                  dropDownList: editProfileController.casteDropDown),
            ),
            Obx(
              () => dropDownTextField(
                  initialItem: editProfileController.selectedReligion.value,
                  labelText: "Religion",
                  dropDownList: editProfileController.religionDropDown),
            ),
            Obx(
              () => dropDownTextField(
                  initialItem: editProfileController.selectedNationality.value,
                  labelText: "Nationality",
                  dropDownList: editProfileController.nationalityDropDown),
            ),
            textFieldWidget(
                labelText: "Student Aadhar No",
                controller: editProfileController.studentAadharC),
            textFieldWidget(
                labelText: "Father Aadhar No",
                controller: editProfileController.fatherAadharC),
            textFieldWidget(
                labelText: "Mother Aadhar No",
                controller: editProfileController.montherAadharC),
            textFieldWidget(
                labelText: "Present Address",
                controller: editProfileController.presentAddressC),
            textFieldWidget(
                labelText: "Permanent Address",
                controller: editProfileController.permanentAddressC),
            textFieldWidget(
                labelText: "Present Pin Code",
                controller: editProfileController.presentPinCodeC),
            textFieldWidget(
                labelText: "Permanent Pin Code",
                controller: editProfileController.permanentPinCodeC),
            textFieldWidget(
                labelText: "Family ID",
                controller: editProfileController.familyIdC),
            Obx(
              () => uploadDocument(context,
                  labelText: "Student Image",
                  type: UploadDocumentType.student,
                  imagePath: editProfileController.studentImagePath.value,
                  editProfileController: editProfileController),
            ),
            Obx(
              () => uploadDocument(context,
                  labelText: "Father Image",
                  type: UploadDocumentType.father,
                  imagePath: editProfileController.fatherImagePath.value,
                  editProfileController: editProfileController),
            ),
            Obx(
              () => uploadDocument(context,
                  labelText: "Mother Image",
                  type: UploadDocumentType.mother,
                  imagePath: editProfileController.motherImagePath.value,
                  editProfileController: editProfileController),
            ),
            Obx(
              () => uploadDocument(context,
                  labelText: "C.Person Image",
                  type: UploadDocumentType.mother,
                  imagePath: editProfileController.personImagePath.value,
                  editProfileController: editProfileController),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(
                    () => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                            elevation: 0,
                            backgroundColor: AppColors.appbuttonColor),
                        onPressed: editProfileController
                                .editProfileBtnLoading.value
                            ? () {}
                            : () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                editProfileController
                                    .sendRequestForProfileUpdate();
                              },
                        child: editProfileController.editProfileBtnLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Send Edit Request',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.whitetextcolor),
                              )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textFieldWidget(
      {required String labelText,
      required TextEditingController controller,
      Widget? suffixIcon,
      bool readOnly = false,
      TextInputAction textInputAction = TextInputAction.next}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 2.h, top: 10.h),
          child: Text(labelText,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )),
        ),
        TextField(
          textInputAction: textInputAction,
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            fillColor: AppColors.whitetextcolor,
            filled: true,
            hintText: "Enter your ${labelText.toLowerCase()}",
            hintStyle: TextStyle(
                fontSize: 14.sp, color: AppColors.textfieldhintstycolor),
            labelStyle: TextStyle(
              fontSize: 14.sp,
            ),
            suffixIcon: suffixIcon,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(
                  color: AppColors.textfieldhintstycolor, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  const BorderSide(color: AppColors.primarycolor, width: 0.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget dropDownTextField(
      {required String labelText,
      required List<String> dropDownList,
      String initialItem = ""}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 2.h, top: 10.h),
          child: Text(labelText,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )),
        ),
        CustomDropdown<String>(
          hintText: 'Select $labelText',
          items: dropDownList,
          initialItem: initialItem.isEmpty ? null : initialItem,
          excludeSelected: false,
          closedHeaderPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: CustomDropdownDecoration(
              hintStyle: TextStyle(
                  fontSize: 14.sp, color: AppColors.textfieldhintstycolor),
              closedBorderRadius: BorderRadius.circular(8.r),
              closedBorder:
                  Border.all(width: 0.5, color: AppColors.primarycolor)),
          onChanged: (saveData) {
            log('changing value to: $saveData');
          },
        ),
      ],
    );
  }

  Widget uploadDocument(BuildContext context,
      {required String labelText,
      String imagePath = "",
      required UploadDocumentType type,
      required StudentEditProfileController editProfileController}) {
    String imageName = "";
    if (imagePath.contains("https")) {
      imageName = labelText.replaceAll(' ', '_').toLowerCase() +
          "." +
          imagePath.split('.').last;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 2.h, top: 10.h),
          child: Text(labelText,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border:
                  Border.all(width: 0.5, color: AppColors.textfieldhintstycolor
                      //  AppColors.primarycolor
                      )),
          child: Row(
            children: [
              Text(imageName.isNotEmpty ? imageName : "Upload $labelText",
                  style: TextStyle(
                      fontSize: 14.sp, color: AppColors.textfieldhintstycolor)),
              const Spacer(),
              if (imageName.isNotEmpty) ...{
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).width * 0.6,
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        imagePath,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    top: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.visibility_outlined,
                      size: 20.sp,
                    )),
                SizedBox(
                  width: 2.w,
                ),
              },
              IconButton(
                  onPressed: () {
                    editProfileController.uploadImages(
                        imageSource: "C", saveTo: type);
                  },
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 20.sp,
                  )),
              SizedBox(
                width: 2.w,
              ),
              IconButton(
                  onPressed: () {
                    editProfileController.uploadImages(
                        imageSource: "G", saveTo: type);
                  },
                  icon: Icon(
                    Icons.image_outlined,
                    size: 20.sp,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
