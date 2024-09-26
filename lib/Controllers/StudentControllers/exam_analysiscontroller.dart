// ignore_for_file: unused_element

import 'package:campuspro/Controllers/login_controller.dart';
import 'package:campuspro/Modal/student_module/exam_analysis_session_model.dart';
import 'package:campuspro/Repository/StudentRepositories/exam_analysis_repository.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExameAnalysisController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getclasssession();
  }

  ScrollController scrollController = ScrollController();

  var sessionList = <SessionModel>[].obs;

  var exannameforAllexamAnalysis = [].obs;
  var examnameList = <ExamnameModel>[].obs; // exam name list
  var studentReport = <ExamanalysisDataModel>[].obs; //  all eaxma analysis list
  var subjectlist = [];
  Map<String, List<double>> subjectScoreMap = {};

  var showtooltiponbarchart = false.obs;
  RxInt touchedIndex = (-1).obs;
  RxInt touchedRodIndex = (-1).obs;
  var subjectnameOnTooltip = ''.obs;
  Color tooltipColor = Colors.transparent;

  var session = ''.obs;
  var examName = ''.obs;
  var showloader = false.obs;
  var removefilter = false.obs;
  var startfilter = false.obs;
  var showSingleExamGhraph = false.obs;
  var singleExamDataList = <SingleExamAnalysisModel>[].obs;

  final LoginController loginController = Get.find<LoginController>();

  void updateTouchedGroupIndex(int index) {
    touchedIndex.value = index;
  }

  getclasssession() async {
    ExamanalysisRepository.getClasssessiondata().then((value) {
      if (value != null) {
        if (value['Status'] == 'Cam-001') {
          List<dynamic> sessiondata = value['Data'];
          sessionList.value =
              sessiondata.map((json) => SessionModel.fromJson(json)).toList();
        }
      }
    });
  }

  getExamData() async {
    await ExamanalysisRepository.getExamname().then((value) {
      if (value != null) {
        if (value['Status'] == 'Cam-001') {
          examnameList.clear();
          List<dynamic> examname = value['Data'];
          examnameList.value = examname
              .map((json) => ExamnameModel.fromJson(json))
              .toList()
              .reversed
              .toList();
          // examnameList.value =
          //     examname.map((json) => ExamnameModel.fromJson(json)).toList();
        } else if (value['Status'] == 'Cam-006') {
          examnameList.clear();
          exannameforAllexamAnalysis();
        }
      }
    });
  }

  analysisdata() async {
    showloader.value = true;
    final response = await ExamanalysisRepository.examAnalysisReportData();
    if (response != null) {
      List<dynamic> reportdata = response['Data'];
      if (response['Status'] == 'Cam-001') {
        studentReport.value = reportdata
            .map((json) => ExamanalysisDataModel.fromJson(json))
            .toList();
        for (var i = 0; i < studentReport.length; i++) {
          if (!subjectlist.contains(studentReport[i].subjectName)) {
            subjectlist.add(studentReport[i].subjectName);
          }
        }

        showloader.value = false;

        datatransforming();
      } else if (response['Status'] == 'Cam-006') {
        studentReport.clear();
        showloader.value = false;
      } else {
        studentReport.clear();
        showloader.value = false;
      }
    }
  }

  final List<Color> colorPalette = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.cyan,
    Colors.indigo,
    Colors.teal,
    Colors.brown,
    Colors.grey,
    Colors.pink,
    Colors.amber,
    Colors.deepOrange,
    Colors.lime,
    Colors.lightBlue,
    Colors.deepPurple,
    Colors.blueGrey,
    Colors.lightGreen,
    Colors.orangeAccent,
  ];

  Map<String, Color> getSubjectColorMap(List<ExamanalysisDataModel> data) {
    final Map<String, Color> subjectColorMap = {};
    final List<String> subjects =
        data.map((item) => item.subjectName).toSet().toList();
    for (int i = 0; i < subjects.length; i++) {
      subjectColorMap[subjects[i]] = colorPalette[i % colorPalette.length];
    }

    return subjectColorMap;
  }

  datatransforming() {
    subjectScoreMap.clear();
    for (int i = 0; i < studentReport.length; i++) {
      String subjectName = studentReport[i].subjectName;
      double marksObtain = studentReport[i].marksObtain;
      if (!exannameforAllexamAnalysis.contains(studentReport[i].exam)) {
        exannameforAllexamAnalysis.add(studentReport[i].exam);
      }

      if (subjectScoreMap.containsKey(subjectName)) {
        subjectScoreMap[subjectName]!.add(marksObtain);
      } else {
        subjectScoreMap[subjectName] = [marksObtain];
      }
    }
  }

  final List<Color> colorplateforsingleexam = [
    AppColors.selfcolor,
    AppColors.avgmarks,
    AppColors.successColor
  ];

  final List<String> result = ["Self", "Avgerage", "Highest"];

  filterExamDataBySessionAndExam() async {
    showSingleExamGhraph.value = true;
    removefilter.value = true;
    showloader.value = true;
    Get.back();
    await ExamanalysisRepository.examAnalysisReportData().then((value) async {
      print(value);
      if (value != null) {
        if (value['Status'] == 'Cam-001') {
          List<dynamic> exmadata = value['Data'];
          singleExamDataList.value = exmadata
              .map((json) => SingleExamAnalysisModel.fromJson(json))
              .toList();
          session.value = '';
          examName.value = '';

          await Future.delayed(const Duration(microseconds: 1000));
          showloader.value = false;
        } else if (value['Status'] == 'Camp-003') {
          await loginController.userLogin();
          filterExamDataBySessionAndExam();
          await Future.delayed(const Duration(microseconds: 1000));
          showloader.value = false;
        } else if (value['Status'] == 'Cam-006') {
          session.value = '';
          examName.value = '';
          singleExamDataList.clear();
          await Future.delayed(const Duration(microseconds: 1000));
          showloader.value = false;
        } else {
          session.value = '';
          examName.value = '';
          singleExamDataList.clear();
          await Future.delayed(const Duration(microseconds: 1000));
          showloader.value = false;
        }
      }
    });
  }
}
