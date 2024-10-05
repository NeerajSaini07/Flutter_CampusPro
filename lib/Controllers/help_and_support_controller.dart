import 'package:campuspro/Repository/help_and_support_repo.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';

class HelpAndSupportController extends GetxController {
  RxString mobileNo = ''.obs;
  RxString email = ''.obs;
  getHelpAndSupportDetails() async {
    try {
      await HelpAndSupportRepository.getHelpAndSupportDetailsRepo()
          .then((response) async {
        if (response != null) {
          if (response['Status'] == "Cam-001") {
            mobileNo.value = response['Data'].first['MobileNo'] ?? "";
            email.value = response['Data'].first['Email'] ?? "";
          } else if (response['Status'] == 'Cam-003') {
            Get.toNamed(Routes.userType);
            mobileNo.value = "";
            email.value = "";
          } else {
            mobileNo.value = "";
            email.value = "";
          }
        } else {
          mobileNo.value = "";
          email.value = "";
        }
        // log(response.toString());
      });
    } catch (e) {
      rethrow;
    }
  }
}
