import 'package:campuspro/Modal/student_module/notification_model.dart';
import 'package:campuspro/Repository/StudentRepositories/student_profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final PageController pageController = PageController();
  int currentIndex = 0;
  var fromdate = ''.obs;
  var todate = ''.obs;
  var notificationloader = false.obs;
  var removeFilter = false.obs;
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDatecontroller = TextEditingController();

  var notificationList = <NotificationModel>[].obs;
  var dashboardnotification = <NotificationModel>[].obs;

  //  **************** calling the api for finding the notification for notification screen

  getNotification() async {
    notificationloader.value = true;
    await StudentProfileRepo.notificationRepo(1).then((value) {
      if (value['Status'] == "Cam-001") {
        List<dynamic> notificationData = value['Data'];
        // **************  for storing the data for showing notification on dshboiard *********
        notificationList.value = notificationData
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        //  ************************************************************

        dashboardnotification.value = notificationData
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        fromDateController.clear();
        toDatecontroller.clear();
        fromdate.value = '';
        todate.value = '';

        notificationloader.value = false;
      } else {
        notificationloader.value = false;
        notificationList.clear();
        dashboardnotification.clear();
      }
    });
  }

  //  ***********************  get date rage from input field *******************

  getdateRage(datename, BuildContext contex) async {
    DateTime? pickedDate = await showDatePicker(
      context: contex,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      if (datename == 'fromDate') {
        fromDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        fromdate.value = "${pickedDate.toLocal()}".split(' ')[0];
      } else {
        toDatecontroller.text = "${pickedDate.toLocal()}".split(' ')[0];
        todate.value = "${pickedDate.toLocal()}".split(' ')[0];
      }
    }
  }

  //  ********************  filter notification ******************************

  filternotificationdata() async {
    notificationloader.value = true;
    await StudentProfileRepo.notificationRepo(0).then((value) async {
      if (value['Status'] == "Cam-001") {
        List<dynamic> notificationData = value['Data'];
        notificationList.value = notificationData
            .map((json) => NotificationModel.fromJson(json))
            .toList();

        notificationloader.value = false;
        clearDateFields();
      } else {
        notificationList.clear();
        notificationloader.value = false;
      }
    });
  }

  //  ************************************ clear the data ********************

  clearDateFields() {
    todate.value = '';
    fromdate.value = '';
    toDatecontroller.clear();
    fromDateController.clear();
  }
}
