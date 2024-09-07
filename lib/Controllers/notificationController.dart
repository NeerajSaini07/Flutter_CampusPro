import 'package:campuspro/Modal/student_module/notification_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxBool notificationStatus = false.obs;

  final PageController pageController = PageController();

  int currentIndex = 0;

  List<NotificationModel> messages = [];

  startAutoSlide() {
    Future.delayed(const Duration(seconds: 10), () {
      if (pageController.hasClients) {
        pageController.nextPage(
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        currentIndex = (currentIndex + 1) % messages.length;
      }
    });
    startAutoSlide();
  }

  getNotification() async {
    await StudentProfileRepo.notificationRepo().then((value) {
      if (value['Status'] == "Cam-001") {
        List<dynamic> notificationData = value['Data'];
        NotificationList.notificationList = notificationData
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        messages = NotificationList.notificationList;
        notificationStatus.value = true;
      } else {
        NotificationList.notificationList = [];
        notificationStatus.value = false;
      }
    });
  }

  String trimSentence(String sentence, int maxLength) {
    if (sentence.length <= maxLength) return sentence;

    String trimmed = sentence.substring(0, maxLength);

    int lastSpace = trimmed.lastIndexOf(' ');

    if (lastSpace != -1) {
      trimmed = trimmed.substring(0, lastSpace);
    }

    return "$trimmed...";
  }
}
