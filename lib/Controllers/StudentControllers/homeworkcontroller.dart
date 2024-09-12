import 'package:campuspro/Modal/student_module/home_work.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class StudentHomeWorkController extends GetxController {
  var calendarFormat = CalendarFormat.week.obs;
  var focuseddate = DateTime.now().obs;
  RxBool tableRefresh = false.obs;
  var selectedDay = DateTime.now().obs;

  List<Map<String, dynamic>> homeworkJsonList = [];

  Map<DateTime, List<String>> homeworkEvents = {
    DateTime.utc(2024, 9, 9): ['Math Homework'],
    DateTime.utc(2024, 9, 10): ['Science Project'],
    DateTime.utc(2024, 9, 11): ['History Essay'],
  };

  @override
  void onInit() {
    super.onInit();
    loadHomeworkDataForCurrentDay();
    homeworkdata();
  }

  void loadHomeworkDataForCurrentDay() {}

  DateTime getDateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  void homeworkdata() {
    HomeworkList.homeworkDetails = [
      HomeworkModel(
        subject: "Math",
        teacherName: "Jay",
        title: 'Math Homework',
        description: 'Complete exercises 1-10 on page 32.',
        date: DateTime(
          2024,
          9,
          9,
        ),
      ),
      HomeworkModel(
        subject: "English",
        title: 'English Essay',
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        teacherName: "Nazish",
        date: DateTime(
          2024,
          9,
          9,
        ),
      ),
      HomeworkModel(
        subject: "physics",
        title: 'Science Project',
        description: 'Prepare a model of the solar system.',
        date: DateTime(
          2024,
          9,
          10,
        ),
      ),
    ];

    homeworkJsonList =
        HomeworkList.homeworkDetails.map((hw) => hw.toJson()).toList();
  }
}
