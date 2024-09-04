// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member

import 'dart:developer';

import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Modal/gatepass_history_model.dart';
import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Modal/visitordata_model.dart';
import 'package:campuspro/Repository/getpass_respository.dart';
import 'package:campuspro/Screens/getpass/visitor_details_page.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetPassController extends GetxController {
  RxBool showOTPwidget = false.obs;
  RxBool showvisitoryHistory = false.obs;
  RxBool showvisitorDetails = false.obs;
  RxBool showErrorfield = false.obs;
  RxBool otperrorfield = false.obs;
  RxBool showPurposeTxtField = false.obs;

  final TextEditingController mobilenumberController = TextEditingController();

  RxString errorMessage = ''.obs;
  RxString errorMessageVisitorName = ''.obs;
  RxString errorMessageVisitorAddress = ''.obs;
  RxString errorMessageVisitortooMeet = ''.obs;
  RxString errorMessageVisitorPurpose = ''.obs;
  RxString errorMessageVisitorPurposetxt = ''.obs;
  RxString visitorTyep = ''.obs;
  RxString mobileNo = ''.obs;
  RxString otpValue = ''.obs;
  RxInt gatePassId = 0.obs;

//  tomeet*****************************************
  RxList toMeetOptions = [].obs;
  RxList<VisitorHistoryModal> vistorData = <VisitorHistoryModal>[].obs;
  RxList<GatePassHistoryModel> gatePassHistoryData =
      <GatePassHistoryModel>[].obs;

// ************************  image ************************
  RxString imagesource = ''.obs;
  final imagePathForIdProof = ''.obs;
  final picker = ImagePicker();

  // ******************************** purpose ****************************
  RxList purposelist = [].obs;

  // *********************************** profile update ******************

  RxString FullName = ''.obs;
  RxString adress = ''.obs;
  RxString otherMessage = ''.obs;
  RxString selectedPurpose = ''.obs;
  RxString selectedOption = ''.obs;

  final visitorImage = ''.obs;

  //  visitory history table ************************

  RxList<String> exitTimes = <String>[].obs;
  RxString exitime = ''.obs;

  @override
  void onInit() {
    super.onInit();
    toMeetdata();
    // getpassHistory();
    // getVisitorHistory();
  }

  @override
  void onClose() {
    // Clean up any resources or controllers here if necessary
    super.onClose();
  }

  clearFieldData() {
    FullName.value = '';
    adress.value = '';
    otherMessage.value = '';
    selectedPurpose.value = '';
    selectedOption.value = '';
    visitorImage.value = '';
    showPurposeTxtField.value = false;
    errorMessageVisitorName.value = '';
    errorMessageVisitorAddress.value = '';
    errorMessageVisitortooMeet.value = '';
    errorMessageVisitorPurpose.value = '';
    errorMessageVisitorPurposetxt.value = '';
  }

  // *********************************************** search visitor using mobiler number****************

  searchvistorByMobile() async {
    // ************************** when click on it then make it false ****************

    final AppbarController appbarController = Get.find<AppbarController>();
    showErrorfield.value = false;
    showOTPwidget.value = false;
    if (mobileNo.value.isNotEmpty) {
      if (mobileNo.value.length < 10) {
        showErrorfield.value = true;
        errorMessage.value = "Please Enter Valid Number";
      } else {
        // finding ther userindex from chache ***************************************
        int usertypeIndex =
            await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
        await GetPassRepository.searchvistor().then((value) {
          // print(value);
          //  *******************  if data is empty ******************
          if (value['Status'] == 'Cam-006') {
            // ***********************  if visitor is mother or father ************
            if (visitorTyep.value == 'Father' ||
                visitorTyep.value == 'Mother') {
              errorMessage.value = "Mobile Number Not Registered";

//  ******************************** make it false if any is true **************
              showErrorfield.value = true;
              showOTPwidget.value = false;
              showvisitorDetails.value = false;

              //  *******************************other ************************
            } else {
              showErrorfield.value = false;
              errorMessage.value = '';
              List<dynamic> data = value['Data'];

              log(data.toString());
              VisitorData.visitorListDetails =
                  data.map((json) => VisitorDataModel.fromJson(json)).toList();
//   ***************** if otp is enable *********************************

              if (UserTypeslist
                      .userTypesDetails[usertypeIndex].sendOtpToVisitor ==
                  'Y') {
                showOTPwidget.value = true;
                //  show details page ***************************************
              } else {
                showOTPwidget.value = false;
                showvisitorDetails.value = true;
                showErrorfield.value = false;
                errorMessage.value = '';
              }
            }
          }

          // ***********************  if respose is succcess **********************
          else if (value['Status'] == 'Cam-001') {
            List<dynamic> data = value['Data'];
            VisitorData.visitorListDetails =
                data.map((json) => VisitorDataModel.fromJson(json)).toList();
            if (UserTypeslist
                    .userTypesDetails[usertypeIndex].sendOtpToVisitor ==
                'Y') {
              showOTPwidget.value = true;
            } else {
              // mobileNo.value = '';
              mobilenumberController.clear();
              appbarController.appBarName.value = 'Visitor Details';
              Get.to(const VisitorDetialsPage());
              showOTPwidget.value = false;
            }
          }

// Storing data in model for dispalying ************************************
        });
      }
    } else {
      errorMessage.value = "Enter Mobile Number";
      showErrorfield.value = true;
      showOTPwidget.value = false;
      showvisitorDetails.value = false;
    }
  }

  // *********************************************get visitor History ******************

  Future<List<VisitorHistoryModal>> getVisitorHistory() async {
    int usertypeIndex =
        await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);

    final value = await GetPassRepository.getvisitorHistory();
    List<dynamic> data = value['Data'];
    VisitorHistory.visitorHistoryListDetails =
        data.map((json) => VisitorHistoryModal.fromJson(json)).toList();

    if (UserTypeslist.userTypesDetails[usertypeIndex].sendOtpToVisitor == 'Y') {
      showOTPwidget.value = false;
    }
    vistorData.value = VisitorHistory.visitorHistoryListDetails;
    return VisitorHistory.visitorHistoryListDetails;
  }

  // **********************************verify OTP *************************

  verifyvisitoryOTP() async {
    await GetPassRepository.verifyOtpGatePass().then((value) {
      if (value['Status'] == 'Cam-001') {
        showOTPwidget.value = false;
        showvisitorDetails.value = true;
        showErrorfield.value = false;
      } else if (value['Status'] == 'Cam-002') {
        showErrorfield.value = false;
        errorMessage.value = 'Invalid OTP ';
        //showvisitorDetails.value = true;
        otperrorfield.value = true;
      }
    });
  }

  toMeetdata() async {
    toMeetOptions.value = [];

    await GetPassRepository.getDataForToMeet().then((value) {
      if (value != null) {
        var data = value['Data'];

        for (var ele1 in data) {
          if (!toMeetOptions
              .any((element) => element['name'] == ele1['Name'])) {
            toMeetOptions
                .add({"name": ele1["Name"], "id": ele1["Id"].toString()});
          }
        }
      }
    }).catchError((error) {});
  }

  // **********************************************************************

  PursposedataGeting() async {
    purposelist.value = [];
    await GetPassRepository.getPurpose().then((value) {
      if (value != null) {
        var data = value['Data'];
        for (var ele1 in data) {
          purposelist.value
              .add({"name": ele1["Name"], "id": ele1["Id"].toString()});
        }
      }
    }).catchError((error) {
      throw error;
    });
  }

// **************************************************************
  idProofVerify(BuildContext context) async {
    XFile? pickedFile;
    if (imagesource.value == 'Cemra') {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }

    if (pickedFile != null) {
      imagePathForIdProof.value =
          pickedFile.path; // Use pickedFile.path to get the file path
    }
    try {
      updateVisitorDetails(context);
      // await GetPassRepository.updateIdProof().then((value) {
      //   if (value['Status'] == 'Cam-001') {
      //     showUploadDialog(context, true);
      //     showErrorfield.value = false;
      //     showOTPwidget.value = false;
      //     Future.delayed(const Duration(microseconds: 10));
      //     showvisitorDetails.value = true;
      //   }
      // });
    } catch (e) {
      rethrow;
    }
  }

  updateVisitorDetails(BuildContext context) async {
    final AppbarController appbarController = Get.find<AppbarController>();
    // print("calling");

    await GetPassRepository.saveVisitordata().then((value) {
      // print(value);
      if (value['Status'] == 'Cam-001') {
        getVisitorHistory();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            duration: const Duration(milliseconds: 1000),
            content: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Visitor Data Updated",
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
        visitorImage.value = '';
        selectedOption.value = '';
        selectedPurpose.value = '';
        FullName.value = '';
        mobileNo.value = '';
        mobilenumberController.clear();
        adress.value = '';
        otherMessage.value = '';
        showOTPwidget.value = false;
        showvisitorDetails.value = false;
        appbarController.appBarName.value = Constant.schoolName;
        Get.back();
      }
    });
  }

  markVisitorExitApi(index) async {
    GetPassRepository.exitVisitor(index).then((value) async {
      await getVisitorHistory();
      showvisitoryHistory.value = false;
      await Future.delayed(const Duration(microseconds: 100));
      showvisitoryHistory.value = true;
    });
  }

  //  Select image for visitor *****************************

  visitorImagepicker() async {
    XFile? pickedFile;
    if (imagesource.value == 'Cemra') {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    if (pickedFile != null) {
      visitorImage.value = pickedFile.path;

      // Use pickedFile.path to get the file path
    }
  }

  getpassHistory() {
    gatePassHistoryData.value = [];
    GetPassRepository.getPassHistory().then((value) {
      if (value['Data'] != null) {
        List<dynamic> data = value['Data'];
        GatePassHistory.gatePassHistoryList =
            data.map((json) => GatePassHistoryModel.fromJson(json)).toList();
        gatePassHistoryData.value = GatePassHistory.gatePassHistoryList;
      } else {
        gatePassHistoryData.value = [];
      }
    });
  }

  markGatePassExitApi(index) async {
    GetPassRepository.exitGatePass(index).then((value) async {
      await getpassHistory();
    });
  }

  //  CheckVistor Form *****************************
  bool checkVistorDetailForm() {
    if (FullName.value.isEmpty) {
      errorMessageVisitorName.value = "Please Enter your name.";
      errorMessageVisitorAddress.value = '';
      errorMessageVisitortooMeet.value = '';
      errorMessageVisitorPurpose.value = '';
      errorMessageVisitorPurposetxt.value = '';
      return false;
    } else if (adress.value.isEmpty) {
      errorMessageVisitorName.value = '';
      errorMessageVisitorAddress.value = "Please Enter your address.";
      errorMessageVisitortooMeet.value = '';
      errorMessageVisitorPurpose.value = '';
      errorMessageVisitorPurposetxt.value = '';
      return false;
    } else if (selectedOption.value.isEmpty) {
      errorMessageVisitorName.value = '';
      errorMessageVisitorAddress.value = '';
      errorMessageVisitortooMeet.value = 'Please select a person to meet.';
      errorMessageVisitorPurpose.value = '';
      errorMessageVisitorPurposetxt.value = '';
      return false;
    } else if (selectedPurpose.value.isEmpty) {
      errorMessageVisitorName.value = '';
      errorMessageVisitorAddress.value = '';
      errorMessageVisitortooMeet.value = '';
      errorMessageVisitorPurpose.value = 'Please select a purpose.';
      errorMessageVisitorPurposetxt.value = '';
      return false;
    } else if (showPurposeTxtField.value == true &&
        otherMessage.value.isEmpty) {
      errorMessageVisitorName.value = '';
      errorMessageVisitorAddress.value = '';
      errorMessageVisitortooMeet.value = '';
      errorMessageVisitorPurpose.value = '';
      errorMessageVisitorPurposetxt.value =
          'Please specify the purpose of visit.';
      return false;
    } else {
      return true;
    }
  }
}
