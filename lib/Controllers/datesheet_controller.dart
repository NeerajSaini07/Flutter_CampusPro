import 'dart:developer';
import 'package:campuspro/Modal/student_module/student_datesheet_model.dart';
import 'package:campuspro/Repository/StudentRepositories/datesheet_repo.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:get/get.dart';

class StudentDatesheetController extends GetxController {
  var isLoading = true.obs;
  var filteredDateSheet = <String, List<Datesheetmodel>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDatesheetsData();
  }

  Future<void> fetchDatesheetsData() async {
    isLoading(true);
    try {
      var response = await StudentdatesheetRepo.getdatesheet();
      log(response.toString());
      if (response != null && response['Status'] == 'Cam-001') {
        List<dynamic> listdata = response['Data'];
        Datesheetl.datesheetlist =
            listdata.map((json) => Datesheetmodel.fromJson(json)).toList();
        await filterDateSheetData();
      } else if (response['Status'] == 'Cam-003') {
        Get.toNamed(Routes.userType);
      }
    } catch (e) {
      log("Error fetching timetable: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> filterDateSheetData() async {
    Map<String, List<Datesheetmodel>> result = {};
    if (Datesheetl.datesheetlist.isNotEmpty) {
      for (var item in Datesheetl.datesheetlist) {
        String examKey = item.exam ?? "";
        if (!result.containsKey(examKey)) {
          result[examKey] = <Datesheetmodel>[];
        }
        result[examKey]!.add(item);
      }
    }
    log(result.toString());
    filteredDateSheet.value = result;
  }
}
