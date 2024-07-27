// ignore_for_file: non_constant_identifier_names

import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Modal/visitordata_model.dart';
import 'package:campuspro/Repository/getpass_respository.dart';
import 'package:campuspro/Screens/Wedgets/getPass/idProofuploadedDilog.dart';
import 'package:campuspro/Screens/Wedgets/getPass/visitordetailsupload_dialog.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GetPassController extends GetxController {
  RxBool showOTPwidget = false.obs;
  RxBool showvisitoryHistory = false.obs;
  RxBool showvisitorDetails = false.obs;
  RxBool showErrorfield = false.obs;
  RxBool otperrorfield = false.obs;

  RxString errorMessage = ''.obs;
  RxString visitorTyep = ''.obs;
  RxString mobileNo = ''.obs;
  RxString otpValue = ''.obs;

//  tomeet*****************************************
  var toMeetOptions = <List<dynamic>>[].obs;

// ************************  image ************************
  RxString imagesource = ''.obs;
  final imagePathForIdProof = ''.obs;
  final picker = ImagePicker();

  // ******************************** purpose ****************************
  var purposelist = <List<dynamic>>[].obs;

  // *********************************** profile update ******************

  RxString FullName = ''.obs;
  RxString adress = ''.obs;
  RxString selectedPurpose = ''.obs;
  RxString selectedOption = ''.obs;

  final visitorImage = ''.obs;

  //  visitory history table ************************

  RxList<String> exitTimes = <String>[].obs;
  RxString exitime = ''.obs;

  @override
  void onClose() {
    // Clean up any resources or controllers here if necessary
    super.onClose();
  }

  // *********************************************** search visitor using mobiler number****************

  searchvistorByMobile() async {
    // ************************** when click on it then make it false ****************
    showErrorfield.value = false;
    showOTPwidget.value = false;
    // finding ther userindex from chache ***************************************
    if (mobileNo.value.isNotEmpty) {
      int usertypeIndex =
          await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
      await GetPassRepository.searchvistor().then((value) {
        //  *******************  if data is empty ******************
        if (value['Status'] == 'Cam-006') {
          // ***********************  if visitor is mother or father ************
          if (visitorTyep.value == 'Father' || visitorTyep.value == 'Mother') {
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
          if (UserTypeslist.userTypesDetails[usertypeIndex].sendOtpToVisitor ==
              'Y') {
            showOTPwidget.value = true;
          } else {
            showOTPwidget.value = false;
            showvisitorDetails.value = true;
          }
        }

// Storing data in model for dispalying ************************************
      });
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
    print(data);

    VisitorHistory.visitorHistoryListDetails =
        data.map((json) => VisitorHistoryModal.fromJson(json)).toList();

    if (UserTypeslist.userTypesDetails[usertypeIndex].sendOtpToVisitor == 'Y') {
      showOTPwidget.value = false;
    }

    return VisitorHistory.visitorHistoryListDetails;
  }

  // *******************************************send otp to vistory ***********

  sendOTPRequest() async {
    await GetPassRepository.sendingOtpForGatePass().then((value) {});
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
    await GetPassRepository.getDataForToMeet().then((value) {
      if (value != null) {
        var data = value['Data'];

        for (var ele1 in data) {
          toMeetOptions.add([ele1["Name"], ele1["Id"].toString()]);
        }
      }
    }).catchError((error) {});
  }

  // **********************************************************************

  PursposedataGeting() async {
    await GetPassRepository.getPurpose().then((value) {
      if (value != null) {
        var data = value['Data'];
        for (var ele1 in data) {
          purposelist.add([ele1["Name"], ele1["Id"].toString()]);
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
      await GetPassRepository.updateIdProof().then((value) {
        if (value['Status'] == 'Cam-001') {
          showUploadDialog(context, true);
          showErrorfield.value = false;
          showOTPwidget.value = false;
          Future.delayed(const Duration(microseconds: 10));
          showvisitorDetails.value = true;
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  updateVisitorDetails(BuildContext context) async {
    await GetPassRepository.saveVisitordata().then((value) {
      if (value['Status'] == 'Cam-001') {
        getVisitorHistory();
        showuploadVisitorDialog(context, true);
        visitorImage.value = '';
        selectedOption.value = '';
        selectedPurpose.value = '';
        FullName.value = '';
        adress.value = '';
        showOTPwidget.value = false;
        showvisitorDetails.value = false;
      }
    });
  }

  bool hasExitTime(int index) {
    if (index < exitTimes.length) {
      return exitTimes[index].isNotEmpty;
    }
    return false;
  }

  markVisitorExitApi(index) async {
    GetPassRepository.exitVisitor(index).then((value) async {
      await getVisitorHistory();
      showvisitoryHistory.value = false;
      await Future.delayed(const Duration(microseconds: 100));
      showvisitoryHistory.value = true;
      hasExitTime(index);
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
}
