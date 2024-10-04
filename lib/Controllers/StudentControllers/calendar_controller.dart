import 'dart:developer';

import 'package:campuspro/Modal/student_module/calendar_model.dart';
import 'package:campuspro/Repository/StudentRepositories/holiday_calendar_repo.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentCalendarController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var studentCalendarData = <DateTime, Map<String, dynamic>>{}.obs;
  var eventsForDay = <DateTime, CalendarEventModel>{}.obs;

  void updateSelectedDay(DateTime day) {
    selectedDay.value = day;
    focusedDay.value = day;
    getEventsForDay(day);
  }

  getStudentCalendarData() async {
    selectedDay.value = DateTime.now();
    focusedDay.value = DateTime.now();
    eventsForDay.clear();
    final calendarResponse =
        await StudentHolidayCalendarRepo.getStudentCalendarDataRepo();
    log(calendarResponse.toString());
    if (calendarResponse != null && calendarResponse['Status'] == "Cam-001") {
      List<dynamic> calendarList = calendarResponse['Data'];
      StudentCalendarlist.stuCalendarList = calendarList
          .map((json) => StudentCalendarModel.fromJson(json))
          .toList();
      await processCalendarData(StudentCalendarlist.stuCalendarList);
      getEventsForDay(DateTime.now());
    } else if (calendarResponse['Status'] == "Cam-003") {
      Get.toNamed(Routes.userType);
    }
  }

  processCalendarData(List<StudentCalendarModel> calendarList) {
    Map<DateTime, Map<String, dynamic>> calendarDetails = {};
    for (StudentCalendarModel item in calendarList) {
      DateTime date =
          DateFormat("dd-MM-yyyy").parse(item.date.toString().trim());
      if (!calendarDetails.containsKey(date)) {
        calendarDetails[date] = {
          "circularDots": [],
          "leave": "",
          "holiday": "",
          "event": "",
        };
      }
      switch (item.name.toString().toLowerCase().split(' ').last) {
        case "present":
          if (!calendarDetails[date]!['circularDots'].contains('P')) {
            calendarDetails[date]!['circularDots'].add('P');
          }
          break;
        case 'absent':
          if (!calendarDetails[date]!['circularDots'].contains('A')) {
            calendarDetails[date]!['circularDots'].add('A');
          }
          break;
        case 'holiday':
          if (!calendarDetails[date]!['circularDots'].contains('H')) {
            calendarDetails[date]!['circularDots'].add('H');
            calendarDetails[date]!['holiday'] = item.description;
          }
          break;
        case 'leave':
          if (!calendarDetails[date]!['circularDots'].contains('L')) {
            calendarDetails[date]!['circularDots'].add('L');
            calendarDetails[date]!['leave'] = item.name;
          }
          break;
        case 'event':
          if (!calendarDetails[date]!['circularDots'].contains('E')) {
            calendarDetails[date]!['circularDots'].add('E');
            calendarDetails[date]!['event'] = item.description;
          }
          break;
        default:
          break;
      }
    }

    log(calendarDetails.toString());
    studentCalendarData.value = calendarDetails;
  }

  List<dynamic> getCircularDotsListForDay(DateTime day) {
    try {
      DateTime date =
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(day.toString());
      // print(date.toString());
      // print(studentCalendarData.value[date]!['circularDots']);
      return studentCalendarData.value[date]!['circularDots'] ?? [];
    } catch (e) {
      return [];
    }
  }

  getEventsForDay(DateTime day) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(day);
    DateTime parsedDate = DateTime.parse('$formattedDate 00:00:00.000');
    var eventData = studentCalendarData[parsedDate] ?? {};
    if (eventData.isNotEmpty) {
      eventsForDay.value = {parsedDate: CalendarEventModel.fromJson(eventData)};
      print(eventsForDay.value.length);
    } else {
      eventsForDay.clear();
    }
  }
}
