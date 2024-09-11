import 'package:campuspro/Modal/student_module/student_class_room_model.dart';
import 'package:campuspro/Modal/student_module/subject_techer_list_model.dart';

import 'package:campuspro/Repository/StudentRepositories/classroom_repo.dart';

import 'package:get/get.dart';

class StudentClasssRoomController extends GetxController {
  RxBool showbottomsheet = false.obs;

  classRoomData() async {
    await StudentClassRoomRepo.getClassRoomdata().then((value) {
      if (value != null) {
        if (value['Status'] == "Cam-001") {
          List<dynamic> listdata = value['Data'];
          ClassRoomDataList.classRoomlist = listdata
              .map((json) => StudentClassRoomModel.fromJson(json))
              .toList();
        }
      }
    });

    filterBysubjectTecher();
  }

  filterBysubjectTecher() async {
    await StudentClassRoomRepo.filterdataList().then((value) {
      if (value != null) {
        if (value['Status'] == "Cam-001") {
          List<dynamic> listdata = value['Data'];
          FilterTechears.filterListdata = listdata
              .map((json) => ClassRoomFilterDataListModel.fromJson(json))
              .toList();
        }
      }
    });
  }
}
