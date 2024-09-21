import 'dart:developer';

import 'package:campuspro/Controllers/StudentControllers/profileController.dart';
import 'package:campuspro/Modal/student_module/student_profile_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_profile_repository.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum UploadDocumentType { student, father, mother, cperson }

class StudentEditProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  List<String> drownDownParamList = [
    "Nationality",
    "Religion",
    "Category",
    "Caste",
    "BloodGroup"
  ];
  RxBool editProfileBtnLoading = false.obs;
  final picker = ImagePicker();

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    await getDropDownList();
    callingProfileDataApi();
  }

  //Defining Controlller
  final TextEditingController nameC = TextEditingController();
  final TextEditingController dobC = TextEditingController();
  final TextEditingController fatherNameC = TextEditingController();
  final TextEditingController montherNameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController guardianMobileNoC = TextEditingController();
  final TextEditingController mobileNoC = TextEditingController();
  final TextEditingController studentAadharC = TextEditingController();
  final TextEditingController fatherAadharC = TextEditingController();
  final TextEditingController montherAadharC = TextEditingController();
  final TextEditingController presentAddressC = TextEditingController();
  final TextEditingController permanentAddressC = TextEditingController();
  final TextEditingController presentPinCodeC = TextEditingController();
  final TextEditingController permanentPinCodeC = TextEditingController();
  final TextEditingController familyIdC = TextEditingController();

  //Drop Down
  final List<String> genderDropDown = ["Male", "Female", "Other"];
  RxString selectedGender = "".obs;
  List<String> nationalityDropDown = [];
  RxString selectedNationality = "".obs;
  List<String> religionDropDown = [];
  RxString selectedReligion = "".obs;
  List<String> categoryDropDown = [];
  RxString selectedCategory = "".obs;
  List<String> casteDropDown = [];
  RxString selectedCaste = "".obs;
  List<String> bloodGroupDropDown = [];
  RxString selectedBloodGroup = "".obs;

  //Initial Images
  RxString studentImagePath = "".obs;
  RxString fatherImagePath = "".obs;
  RxString motherImagePath = "".obs;
  RxString personImagePath = "".obs;

  callingProfileDataApi() async {
    if (StudentProfileList.studentProfileList.isNotEmpty) {
      setProfileDataOnTextField();
    } else {
      final StudentProfileController profileController =
          Get.find<StudentProfileController>();
      final response = await profileController.getStudentProfileData();
      if (response.isNotEmpty) {
        setProfileDataOnTextField();
      }
    }
  }

  setProfileDataOnTextField() {
    final studentProfileData = StudentProfileList.studentProfileList.first;
    nameC.text = studentProfileData.stName ?? "";
    dobC.text = studentProfileData.dobNew ?? "";
    fatherNameC.text = studentProfileData.fatherName ?? "";
    montherNameC.text = studentProfileData.motherName ?? "";
    emailC.text = studentProfileData.email ?? "";
    guardianMobileNoC.text = studentProfileData.guardianMobileNo ?? "";
    mobileNoC.text = studentProfileData.mobileNo ?? "";
    studentAadharC.text = studentProfileData.studentAadharNo ?? "";
    fatherAadharC.text = studentProfileData.fatherAadharNo ?? "";
    montherAadharC.text = studentProfileData.motherAadharNo ?? "";
    presentAddressC.text = studentProfileData.prsntAddress ?? "";
    permanentAddressC.text = studentProfileData.permanentAddress ?? "";
    presentPinCodeC.text = studentProfileData.presZip ?? "";
    permanentPinCodeC.text = studentProfileData.permanentPin ?? "";
    familyIdC.text = studentProfileData.familyID ?? "";
    selectedGender.value =
        (studentProfileData.gender ?? "").capitalizeFirst ?? "";
    selectedNationality.value =
        nationalityDropDown.contains(studentProfileData.nationality)
            ? (studentProfileData.nationality ?? "")
            : "";
    selectedReligion.value =
        religionDropDown.contains(studentProfileData.religion)
            ? (studentProfileData.religion ?? "")
            : "";
    selectedCategory.value =
        categoryDropDown.contains(studentProfileData.category)
            ? (studentProfileData.category ?? "")
            : "";
    selectedCaste.value = casteDropDown.contains(studentProfileData.caste)
        ? (studentProfileData.caste ?? "")
        : "";
    selectedBloodGroup.value =
        bloodGroupDropDown.contains(studentProfileData.bloodGroup)
            ? (studentProfileData.bloodGroup ?? "")
            : "";
    studentImagePath.value = studentProfileData.studentImagePath ?? "";
    fatherImagePath.value = studentProfileData.fatherImagePath ?? "";
    motherImagePath.value = studentProfileData.motherImagePath ?? "";
    personImagePath.value = studentProfileData.conPersonImagePath ?? "";
    log(studentProfileData.studentImagePath.toString());
  }

  //Get DropDown List
  getDropDownList() async {
    for (String item in drownDownParamList) {
      final dropDownResponse =
          await StudentProfileRepo.getProfileDropDownRepo(paramType: item);
      if (dropDownResponse != null && dropDownResponse['Status'] == "Cam-001") {
        List<dynamic> dropDowndata = dropDownResponse['Data'];
        List<String> dropDownList = [];
        if (item != "BloodGroup") {
          for (var item in dropDowndata) {
            dropDownList.add(item['Paramname']);
          }
        } else {
          for (var item in dropDowndata) {
            dropDownList.add(item['GroupName']);
          }
        }

        switch (item) {
          case "Nationality":
            nationalityDropDown = dropDownList;
            break;
          case "Religion":
            religionDropDown = dropDownList;
            break;
          case "Category":
            categoryDropDown = dropDownList;
            break;
          case "Caste":
            casteDropDown = dropDownList;
            break;
          case "BloodGroup":
            bloodGroupDropDown = dropDownList;
            break;
          default:
            break;
        }
      }
    }
  }

  //Calling Send Request for profile update
  sendRequestForProfileUpdate() async {
    editProfileBtnLoading.value = true;
    try {
      final response =
          await StudentProfileRepo.sendRequestForProfileUpdateRepo();
      log(response.toString());
      if (response != null && response['Status'] == "Cam-001") {
        final StudentProfileController profileController =
            Get.find<StudentProfileController>();
        await profileController.getStudentProfileData();
        //Show Sneakbar
        CommonFunctions.showSuccessSnackbar("Request Submitted Successfully",
            "Your request for updating profile data has been successfully submitted.");
      } else {
        CommonFunctions.showErrorSnackbar("Request Failed",
            "We were unable to submit your profile data change request. Please try again later.");
      }
    } catch (e) {
      editProfileBtnLoading.value = false;
    }
    editProfileBtnLoading.value = false;
  }

  uploadImages(
      {required String imageSource, required UploadDocumentType saveTo}) async {
    //Type C for camera and G for Gallery
    XFile? pickedFile;
    if (imageSource == 'C') {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    }
    if (pickedFile != null) {
      // Crop the image
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.primarycolor,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          )
        ],
      );

      if (croppedFile != null) {
        final String fileExtension =
            croppedFile.path.split('.').last.toLowerCase();
        if (fileExtension == 'jpg' ||
            fileExtension == 'jpeg' ||
            fileExtension == 'png') {
          String pickedImagePath = croppedFile.path;
          String imageFor = getImageForType(saveTo: saveTo);

          final response = await StudentProfileRepo.uploadProfileImageRepo(
              imageFor: imageFor, imagePath: pickedImagePath);
          // log(response.toString());
          if (response != null && response['Status'] == "Cam-001") {
            CommonFunctions.showSuccessSnackbar(
                "Request Submitted Successfully",
                "Your request for updating profile Image has been successfully submitted.");
          } else {
            CommonFunctions.showErrorSnackbar("Request Failed",
                "We were unable to submit your profile Image change request. Please try again later.");
          }
        } else {
          CommonFunctions.showErrorSnackbar(
              "Invalid File", "Please select a valid image file.");
        }
      } else {
        CommonFunctions.showErrorSnackbar(
            "Cropping Failed", "Please crop the image before uploading.");
      }
    } else {
      CommonFunctions.showErrorSnackbar(
          "No Image Selected", "Please select an image.");
    }
  }

  String getImageForType({required UploadDocumentType saveTo}) {
    switch (saveTo) {
      case UploadDocumentType.student:
        return "STUDENT";
      case UploadDocumentType.father:
        return "FATHER";
      case UploadDocumentType.mother:
        return "MOTHER";
      case UploadDocumentType.cperson:
        return "CONTACTPERSON";
    }
  }
}
