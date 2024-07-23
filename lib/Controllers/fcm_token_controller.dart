import 'package:campuspro/Modal/fcmtoken_model.dart';
import 'package:campuspro/Repository/fcmtoken_repository.dart';
import 'package:get/get.dart';

class FcmTokenController extends GetxController {
  getFCMToken() async {
    await FcmTokenRepository.getfcmTokendata().then((value) async {
      if (value != null) {
        List<dynamic> data = value['Data'];
        FcmTokenList.tokenlist =
            data.map((json) => FcmTokeModel.fromJson(json)).toList();
      }
    });
  }
}
