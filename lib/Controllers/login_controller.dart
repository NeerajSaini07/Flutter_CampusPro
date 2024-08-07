import 'package:campuspro/Controllers/internet_controller.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/login_model.dart';
import 'package:campuspro/Repository/login_repository.dart';
import 'package:campuspro/Screens/Wedgets/no_internet.dart';
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
  // ************************************show and hide password of input field*******************

  void showHidePassword() {
    passwordHide.value = !passwordHide.value;
  }

  void validatePhoneNumber(BuildContext context) {
    // final InternetController internetController =
    //     Get.find<InternetController>();

    // if (internetController.internetChecker.value == true) {
    if (mobileNumber.value.isEmpty) {
      showerror.value = true;
      formErrorText.value = "Please enter a number";
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

    final sharedfdata = Sharedprefdata();

    bool loginvalue =
        (await sharedfdata.getbooleandata(Sharedprefdata.loginKey)) ?? false;

    loginLoader.value = true;

    await LoginRepository.userLoginRepo().then((value) async {
      if (value != null) {
// **********************     checking user silent sign in *****************************
        if (loginvalue == true) {
          await Future.delayed(const Duration(seconds: 2));
          loginLoader.value = false;

//  ********************************* Stroing data into the  model  *************************************
          List<dynamic> data = value['Data'];
          UserLogin.loginDetails =
              data.map((json) => LoginModel.fromJson(json)).toList();
        } else {
// *********************** user sign in manul **********************************
// **********************************************************************************************
          await Future.delayed(const Duration(seconds: 2));

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
// ********************************** stored in prefrence ***************************

            Sharedprefdata.setbooleandata(Sharedprefdata.loginKey, true);
            Sharedprefdata.storeStringData(Sharedprefdata.token,
                UserLogin.loginDetails[0].token.toString());
            Sharedprefdata.storeStringData(Sharedprefdata.uid,
                UserLogin.loginDetails[0].oUserid.toString());
            Sharedprefdata.storeStringData(
                Sharedprefdata.mobile, mobileNumber.value);
            Sharedprefdata.storeStringData(
                Sharedprefdata.password, passWord.value);

            // *************************************** clear variable value of **********

            showerror.value = false;
            gloableError.value = false;
            formErrorText.value = '';
            mobileNumber.value = '';
            passWord.value = '';
            mobileNumberController.clear();
            passwordController.clear();

            await userTypeController.getUsers();
            // ***********************************************************************
            Get.offAndToNamed(Routes.userType);

// ************************ finding the users list of currect the login user**********************
          }
        }
      }
    });
  }
}
