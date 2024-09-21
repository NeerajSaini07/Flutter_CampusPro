import 'dart:developer';

import 'package:campuspro/Repository/StudentRepositories/test_exam_result_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Modal/student_module/exam_test_result_model.dart';

class ExamTestExamResultController extends GetxController {
  var testMarksResultList = <ExamTestResultModel>[].obs;

  ScrollController scrollController = ScrollController();
  var showloader = false.obs;

  //  *******************************  method for getting single exam result data ***************
  testExamResult() async {
    showloader.value = true;
    await TestExamResultRepository.getSingleExamMarksRepo().then((value) {
      if (value != null) {
        print(value);
        if (value['Status'] == 'Cam-001') {
          List<dynamic> resultdata = value['Data'];
          testMarksResultList.value = resultdata
              .map((json) => ExamTestResultModel.fromJson(json))
              .toList();
          showloader.value = false;
          log("loader value $showloader");
        }
      }
    });
  }
}
