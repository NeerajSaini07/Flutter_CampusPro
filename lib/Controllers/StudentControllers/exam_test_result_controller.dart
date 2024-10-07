import 'dart:developer';

import 'package:campuspro/Controllers/StudentControllers/exam_analysiscontroller.dart';
import 'package:campuspro/Repository/StudentRepositories/test_exam_result_repo.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Modal/student_module/exam_test_result_model.dart';

class ExamTestExamResultController extends GetxController {
  var testMarksResultList = <ExamTestResultModel>[].obs;

  ScrollController scrollController = ScrollController();
  var showloader = false.obs;
  var bottomshitopenforExamResult = false.obs;
  var examid = ''.obs;
  var examname = ''.obs;

  final ExameAnalysisController exameAnalysisController =
      Get.find<ExameAnalysisController>();
  var examnameListForResult = <ExamModelForStudentResult>[].obs;
  RxInt touchedIndex = (-1).obs;
  RxInt touchedRodIndex = (-1).obs;
  var subjectnameOnTooltip = ''.obs;
  Color tooltipColor = Colors.transparent;

  void updateTouchedGroupIndex(int index) {
    touchedIndex.value = index;
  }

  //  *******************************  method for getting single exam result data ***************
  testExamResult() async {
    await Future.delayed(const Duration(seconds: 1));
    await TestExamResultRepository.getSingleExamMarksRepo().then((value) {
      log(value.toString());
      if (value != null) {
        if (value['Status'] == 'Cam-001') {
          testMarksResultList.clear();
          List<dynamic> resultdata = value['Data'];
          testMarksResultList.value = resultdata
              .map((json) => ExamTestResultModel.fromJson(json))
              .toList();

          examname.value = testMarksResultList[0].exam;
          if (bottomshitopenforExamResult.value == true) {
            Get.back();
          }

          bottomshitopenforExamResult.value = false;
          exameAnalysisController.session.value = '';
          examid.value = '';

          showloader.value = false;
        } else {
          if (bottomshitopenforExamResult.value == true) {
            Get.back();
          }
          testMarksResultList.clear();
          showloader.value = false;
          exameAnalysisController.session.value = '';
          examid.value = '';
          bottomshitopenforExamResult.value = false;
        }
      }
    });
  }

  studentexamNameForTestResult() async {
    showloader.value = true;
    await TestExamResultRepository.getExamnameForStudentResult().then((value) {
      if (value != null) {
        if (value['Status'] == 'Cam-001') {
          examnameListForResult.clear();
          List<dynamic> examname = value['Data'];
          examnameListForResult.value = examname
              .map((json) => ExamModelForStudentResult.fromJson(json))
              .toList();

          testExamResult();
        } else if (value['Status'] == 'Cam-003') {
          Get.toNamed(Routes.userType);
          showloader.value = true;
          examnameListForResult.clear();
        } else {
          showloader.value = true;
          examnameListForResult.clear();
        }
      }
    });
  }
}
