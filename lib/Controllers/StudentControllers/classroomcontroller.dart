import 'package:campuspro/Controllers/fcm_token_controller.dart';
import 'package:campuspro/Modal/student_module/classromm_comment_model.dart';
import 'package:campuspro/Modal/student_module/student_class_room_model.dart';
import 'package:campuspro/Modal/student_module/class_room_teacher_filter.dart';
import 'package:campuspro/Repository/StudentRepositories/classroom_repo.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class StudentClasssRoomController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  RxBool showbottomsheet = false.obs;
  var classRoomdatalist = <StudentClassRoomModel>[].obs;
  var commentlist = <ClassRoomCommentModel>[].obs;
  var filterList = <ClassRoomFilterDataListModel>[].obs;

  var refreshpage = false.obs;
  var empid = '';
  var subjectid = '';

  var commenttext = ''.obs;
  final TextEditingController comment = TextEditingController();
  RxString filesource = ''.obs;
  var fileName = ''.obs;
  final picker = ImagePicker();
  final FcmTokenController fcmTokenController = Get.find<FcmTokenController>();

  var successcommentloader = false.obs;
  final FocusNode commentFocusNode = FocusNode();

  classRoomData() async {
    await StudentClassRoomRepo.getClassRoomdata().then((value) async {
      if (value != null) {
        if (value['Status'] == "Cam-001") {
          List<dynamic> listdata = value['Data'];
          classRoomdatalist.value = listdata
              .map((json) => StudentClassRoomModel.fromJson(json))
              .toList();
        } else if (value['Status'] == "Cam-003") {
          await fcmTokenController.getFCMToken();

          classRoomData();
        }
      }
    });
  }

  filterBysubjectTecher() async {
    await StudentClassRoomRepo.filterdataList().then((value) async {
      if (value != null) {
        if (value['Status'] == "Cam-001") {
          List<dynamic> listdata = value['Data'];
          filterList.value = listdata
              .map((json) => ClassRoomFilterDataListModel.fromJson(json))
              .toList();
        } else if (value['Status'] == "Cam-001") {
          await fcmTokenController.getFCMToken();
          filterBysubjectTecher();
        }
      }
    });
  }

  //  *****************************  pick file ********************

  getfiles() async {
    FilePickerResult? pickedPdf;
    pickedPdf = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg'],
    );

    if (pickedPdf != null) {
      String filepath = pickedPdf.files.single.path!;
      filesource.value = filepath;
      fileName.value = path.basename(filepath);
    } else {}
  }

//  *****************************   add comment on  homehomehork ************

  addCommentOnClassRoom(index) async {
    commentFocusNode.unfocus();
    await StudentClassRoomRepo.addcomments(index).then((value) async {
      if (value != null) {
        if (value['Status'] == 'Cam-001') {
          successcommentloader.value = true;
          Get.snackbar("Comments", "Your Comments Successfully Post");
          comment.clear();

          filesource.value = '';
          fileName.value = '';
          await getclassRommComments(index);
        } else if (value['Status'] == 'Cam-006') {
          filesource.value = '';
          fileName.value = '';
          comment.clear();
          await getclassRommComments(index);
          successcommentloader.value = false;
          Get.snackbar("Comments", "Your Comments Successfully Post");
        } else {
          successcommentloader.value = false;
          Get.snackbar("Comments", "Your Comments is Faild ");
        }
      }
    });
  }

  getclassRommComments(index) async {
    final FcmTokenController fcmTokenController =
        Get.find<FcmTokenController>();
    await StudentClassRoomRepo.getClassRoomCommentsdata(index).then((value) {
      if (value != null) {
        if (value['Status'] == 'Cam-001') {
          List<dynamic> commentdata = value['Data'];
          commentlist.value = commentdata
              .map((json) => ClassRoomCommentModel.fromJson(json))
              .toList();

          successcommentloader.value = false;
        } else if (value['Status'] == 'Cam-003') {}
      }
    });
  }
}
