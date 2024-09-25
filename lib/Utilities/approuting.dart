import 'package:campuspro/Controllers/StudentControllers/classroomcontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Controllers/StudentControllers/exam_test_result_controller.dart';
import 'package:campuspro/Controllers/StudentControllers/homeworkcontroller.dart';
import 'package:campuspro/Controllers/appbar_controller.dart';
import 'package:campuspro/Controllers/bottombar_controller.dart';
import 'package:campuspro/Controllers/bus_tracker_controller.dart';
import 'package:campuspro/Controllers/notificationController.dart';
import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Controllers/web_controller.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Screens/notification_screen.dart';
import 'package:campuspro/Screens/studenPortal/activity.dart';
import 'package:campuspro/Screens/studenPortal/circular.dart';
import 'package:campuspro/Screens/studenPortal/exam_analysis.dart';
import 'package:campuspro/Screens/studenPortal/exam_test_result.dart';
import 'package:campuspro/Screens/studenPortal/holiday_list_screen.dart';
import 'package:campuspro/Screens/studenPortal/homework.dart';
import 'package:campuspro/Screens/studenPortal/leave_details.dart';
import 'package:campuspro/Screens/studenPortal/profile_edit.dart';
import 'package:campuspro/Screens/studenPortal/student_calendar.dart';
import 'package:campuspro/Services/urlLuncher/web_url_luncher.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRouting extends GetxService {
  final BusTrackerController busTrackerController =
      Get.find<BusTrackerController>();

  final WebController webController = Get.find<WebController>();
  final AppbarController appbarController = Get.find<AppbarController>();
  final BottomBarController bottomBarController =
      Get.find<BottomBarController>();

  final StudentClasssRoomController studentClasssRoomController =
      Get.find<StudentClasssRoomController>();

  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();

  final UserTypeController userTypeController = Get.find<UserTypeController>();

  final NotificationController notificationController =
      Get.find<NotificationController>();

  final StudentHomeWorkController studentHomeWorkController =
      Get.find<StudentHomeWorkController>();

  final ExamTestExamResultController examResultController =
      Get.find<ExamTestExamResultController>();

  navigate(name, pageurl, BuildContext context, whereToOpenFlag) async {
    if (whereToOpenFlag == "W") {
      if (pageurl == '') {
        pageurl = 'Index.aspx';
        appbarController.appBarName.value = Constant.schoolName;
        webController.showWebViewScreen.value = false;
      } else {
        webController.generateWebUrl(pageurl, name);
        if (pageurl.toString().contains('Index.aspx')) {
          appbarController.appBarName.value = Constant.schoolName;
          webController.showWebViewScreen.value = false;
        } else {
          appbarController.appBarName.value = name;
          webController.showWebViewScreen.value = true;
        }
      }
    } else {
      webController.showWebViewScreen.value = false;
      switch (name) {
        case "Student Bus Location":
          appbarController.appBarName.value = 'Bus Tracker';
          await busTrackerController.getBusAllot(context);
          break;

        case "Visitor New":
          Navigator.pushNamed(context, Routes.visitorHistory);
          break;

        case "Go to Site":
          UrlLuncher.launchUrls(pageurl);
          break;

        case "Alert & Notification":
        case "Notification":
          Get.to(() => const NotificationScreen());
          notificationController.getNotification();
          appbarController.appBarName.value = name;
          webController.showWebViewScreen.value = false;
          break;

        case "Leave Detail":
        case "Leave Request":
          Get.toNamed(Routes.studentLeaveDetailScreen);
          break;

        case "Request Edit Detail":
          Get.toNamed(Routes.studentEditProfileScreen);
          break;

        case "Holiday List":
          Get.toNamed(Routes.holidayScreen);
          break;

        case "Calendar":
          Get.to(() => const StudentCalendarScreen());
          break;

        case "Home Work":
          await studentHomeWorkController.markgreenhomedate();
          studentHomeWorkController.gethomeworkbydate();
          Get.to(() => const HomeworkScreen());

          appbarController.appBarName.value = name;
          webController.showWebViewScreen.value = false;
          break;

        case "ClassRoom":
          if (UserTypeslist.userTypesDetails[userTypeController.usertypeIndex]
                  .ouserType ==
              'S') {
            await studentClasssRoomController.filterBysubjectTecher();

            Get.toNamed(Routes.studentClassRomm);
            appbarController.appBarName.value = name;
            webController.showWebViewScreen.value = false;
          } else {
            webController.generateWebUrl(pageurl, name);
          }
          break;

        case "Circular":
          Get.toNamed(Routes.studentCircularScreen);
          break;

        case "Activity":
          Get.toNamed(Routes.studentActivityScreen);
          break;

        case "Change Password":
          Get.toNamed(Routes.changePasswordScreen,
              arguments: {'isdefaultChangePass': false});
          break;
        case "Exam Analysis":
          await exameAnalysisController.getExamData();
          await exameAnalysisController.getclasssession();
          await exameAnalysisController.analysisdata();
          await Get.to(() => const ExameAnalysis());

          appbarController.appBarName.value = name;
          webController.showWebViewScreen.value = false;
          break;

        case "Exam/Test Result":
          await exameAnalysisController.getExamData();
          examResultController.testExamResult();
          Get.to(() => const ExamTestResult());

          appbarController.appBarName.value = name;
          webController.showWebViewScreen.value = false;
          break;

        case "Profile":
          Get.toNamed(Routes.studentProfileScreen);
          break;

        default:
          if (pageurl == '') {
            pageurl = 'Index.aspx';
            appbarController.appBarName.value = Constant.schoolName;
            webController.showWebViewScreen.value = false;
          } else {
            webController.generateWebUrl(pageurl, name);
            if (pageurl.toString().contains('Index.aspx')) {
              appbarController.appBarName.value = Constant.schoolName;
              webController.showWebViewScreen.value = false;
            } else {
              appbarController.appBarName.value = name;
              webController.showWebViewScreen.value = true;
            }
          }
          break;
      }
    }
  }
}
