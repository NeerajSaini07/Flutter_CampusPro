import 'package:campuspro/Modal/student_module/timetable_model.dart';
import 'package:campuspro/Repository/StudentRepositories/timetable_repo.dart';
import 'package:get/get.dart';

class StudenttimetableController extends GetxController {
  var isLoading = true.obs;
  var periods = <Period>[].obs;
  var classInfo = <ClassInfo>[].obs;
  var timetable = <Timetable>[].obs;

  var selectedDay = ''.obs; // Stores the selected day
  var filteredTimetable =
      <Timetable>[].obs; // Stores the filtered timetable based on day

  @override
  void onInit() {
    super.onInit();
    fetchTimetableData();
  }

  Future<void> fetchTimetableData() async {
    isLoading(true); // Set loading to true while data is being fetched
    try {
      var response = await StudenttimetableRepo.gettimetable();
      if (response != null) {
        // Assuming you have a fromJson method to parse response into models
        StudentTimetableModel data =
            StudentTimetableModel.fromJson(response['Data']);

        // Update the observable lists with fetched data
        periods.assignAll(data.periods);
        classInfo.assignAll(data.classes);
        timetable.assignAll(data.timetables);

        // Set initial filter to the first day (e.g., Monday)
        if (timetable.isNotEmpty) {
          selectedDay.value = 'Monday';
          filterTimetableByDay(selectedDay.value);
        }
      }
    } catch (e) {
      print("Error fetching timetable: $e");
    } finally {
      isLoading(false);
    }
  }

  // Method to filter timetable based on selected day
  void filterTimetableByDay(String day) {
    selectedDay.value = day;

    // Filter the timetable based on the selected day
    filteredTimetable
        .assignAll(timetable.where((t) => t.dayStr == day).toList());
  }
}
