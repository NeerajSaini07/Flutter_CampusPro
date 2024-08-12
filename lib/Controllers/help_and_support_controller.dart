import 'package:campuspro/Repository/help_and_support_repo.dart';
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
