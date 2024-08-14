import 'package:campuspro/Controllers/exception_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/login_model.dart';
import 'package:campuspro/Repository/login_repository.dart';
import 'package:campuspro/Services/InternetConnection/internet_connectivity.dart';
import 'package:campuspro/Services/notificationService/notification_service.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginController extends GetxController {
  final RxString mobileNumber = ''.obs; // storing user mobile number

  final RxString passWord = ''.obs; // storing user password

  final RxString formErrorText = ''.obs; // storing error text from form

  RxBool passwordHide = false
      .obs; //  toggle botton of password show and hide on password input field

  RxBool showerror = false.obs; // display  number field error

  RxBool loginLoader = false.obs;

  RxBool gloableError = false.obs;

  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode phoneNode = FocusNode();
  final FocusNode passNode = FocusNode();
  var isPhoneFocused = false.obs;
  var isPassFocused = false.obs;

  @override
  void onInit() {
    super.onInit();
    phoneNode.addListener(() {
      isPhoneFocused.value = phoneNode.hasFocus;
    });
    passNode.addListener(() {
      isPassFocused.value = passNode.hasFocus;
    });
  }

  @override
  void onClose() {
    phoneNode.dispose();
    passNode.dispose();
    super.onClose();
  }
  // ************************************show and hide password of input field*******************

  void showHidePassword() {
    passwordHide.value = !passwordHide.value;
  }

  void validatePhoneNumber(BuildContext context) {
    // print("value not comming");
    // final InternetController internetController =
    //     Get.find<InternetController>();
    // if (internetController.internetChecker.value == true) {
    if (mobileNumber.value.length != 10) {
      showerror.value = true;
      formErrorText.value = "Please Enter a Valid Number";
    } else {
      showerror.value = false;
      formErrorText.value = "";

      userLogin();
      // Perform further validation or submission logic here
    }
    // } else {
    //   showNoInternetDialog(context);
    // }
  }

// ******************************************* user login *********************

  userLogin() async {
    final UserTypeController userTypeController =
        Get.find<UserTypeController>();

    final ConnectivityService connectivityService =
        Get.find<ConnectivityService>();

    final ExceptionController exceptionController =
        Get.find<ExceptionController>();

    final sharedfdata = Sharedprefdata();

    if (connectivityService.isConnected.value) {
      bool loginvalue =
          (await sharedfdata.getbooleandata(Sharedprefdata.loginKey)) ?? false;

      loginLoader.value = true;

      await LoginRepository.userLoginRepo().then((value) async {
        if (value != null) {
          if (loginvalue == true) {
            // await Future.delayed(const Duration(seconds: 2));
            loginLoader.value = false;

//  ********************************* Stroing data into the  model  *************************************
            List<dynamic> data = value['Data'];
            UserLogin.loginDetails =
                data.map((json) => LoginModel.fromJson(json)).toList();
          } else {
// *********************** user sign in manul **********************************
// **********************************************************************************************
            // await Future.delayed(const Duration(seconds: 2));

            loginLoader.value = false;
            List<dynamic> data = value['Data'];
            UserLogin.loginDetails =
                data.map((json) => LoginModel.fromJson(json)).toList();

            if (UserLogin.loginDetails[0].validated == 'N') {
              showerror.value = false;
              gloableError.value = true;
              formErrorText.value =
                  UserLogin.loginDetails[0].validateMessage.toString();
            } else {
              // ***********************************************************************
              await Sharedprefdata.storeStringData(
                  Sharedprefdata.mobile, mobileNumber.value);
              await Sharedprefdata.storeStringData(Sharedprefdata.uid,
                  UserLogin.loginDetails[0].oUserid.toString());
              if (mobileNumber.value
                      .toString()
                      .substring(mobileNumber.value.length - 5) ==
                  passWord.value) {
                Sharedprefdata.setbooleandata(Sharedprefdata.loginKey, false);
                Get.toNamed(Routes.changePasswordScreen);
              } else {
                // ********************************** stored in prefrence ***************************

                await Sharedprefdata.setbooleandata(
                    Sharedprefdata.loginKey, true);
                await Sharedprefdata.storeStringData(Sharedprefdata.token,
                    UserLogin.loginDetails[0].token.toString());
                await Sharedprefdata.storeStringData(
                    Sharedprefdata.password, passWord.value);

                await userTypeController.getUsers();

                Get.offAndToNamed(Routes.userType);
              }

              // *************************************** clear variable value of **********

              showerror.value = false;
              gloableError.value = false;
              formErrorText.value = '';
              mobileNumber.value = '';
              passWord.value = '';
              mobileNumberController.clear();
              passwordController.clear();

// ************************ finding the users list of currect the login user**********************
            }
          }
          await getToken();
        }
      });
    } else {
      exceptionController.showDialog(
          title: "Oops! No internet ",
          message: 'Please check your settings and try again');
    }
  }
}
