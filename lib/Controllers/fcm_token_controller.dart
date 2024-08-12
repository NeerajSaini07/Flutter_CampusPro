import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Repository/fcmtoken_repository.dart';
import 'package:get/get.dart';

class FcmTokenController extends GetxController {
  //Token Generated to use in Future Apis and also updates the FCM token for notification
  getFCMToken() async {
    await FcmTokenRepository.getfcmTokendata().then((value) async {
      if (value != null) {
        List<dynamic> data = value['Data'];
        FcmTokenList.tokenlist =
            data.map((json) => FcmTokeModel.fromJson(json)).toList();
      }
    });
  }

  //Removes FCM token for notification at logout
  removeFCMToken() async {
    await FcmTokenRepository.removefcmToken().then((value) async {
      if (value != null) {}
    });
  }
}
