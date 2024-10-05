import 'dart:developer';
import 'package:campuspro/Repository/StudentRepositories/timetable_repo.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';

class StudenttimetableController extends GetxController {
  var isLoading = true.obs;
  var filteredTimetable = <String, List<Map<String, String>>>{}.obs;
  var expandedStates = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTimetableData();
  }

  Future<void> fetchTimetableData() async {
    isLoading(true);
    try {
      var response = await StudenttimetableRepo.gettimetable();
      log(response.toString());
      if (response != null && response['Status'] == "Cam-001") {
        List<dynamic> periodData = response['Data1'] ?? [];
        List<dynamic> timetableData = response['Data3'] ?? [];

        Map<String, List<Map<String, String>>> result = {};

        for (var tableItem in timetableData) {
          String day = tableItem['DayStr'] ?? "";
          if (day.trim().isNotEmpty) {
            result[day] = [];
            for (int i = 0; i < periodData.length; i++) {
              String periodKey = 'Period_${i + 1}';
              if (tableItem[periodKey] != null &&
                  tableItem[periodKey].isNotEmpty) {
                result[day]!.add({
                  'period_no': (i + 1).toString(),
                  'period_time': periodData[i]['PeriodName']
                      .split('(')
                      .last
                      .replaceFirst(')', ''),
                  'period_name': tableItem[periodKey]
                });
              } else if (periodData[i]['PeriodName'] != null &&
                  periodData[i]['PeriodName'].isNotEmpty) {
                result[day]!.add({
                  'period_no': (i + 1).toString(),
                  'period_time': periodData[i]['PeriodName']
                      .split('(')
                      .last
                      .replaceFirst(')', ''),
                  'period_name': "--"
                });
              }
            }
            expandedStates[day] = false;
          }
        }

        //Sorting ***********
        const daysOfWeek = [
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday',
          'Sunday'
        ];
        filteredTimetable.value = Map.fromEntries(
          daysOfWeek
              .where((day) => result.containsKey(day))
              .map((day) => MapEntry(day, result[day]!)),
        );
        log(filteredTimetable.value.toString());
      } else if (response['Status'] == 'Cam-003') {
        Get.toNamed(Routes.userType);
      }
    } catch (e) {
      log("Error fetching timetable: $e");
    } finally {
      isLoading(false);
    }
  }

  void toggleExpansion(String day) {
    expandedStates[day] = !(expandedStates[day] ?? false);
  }
}
