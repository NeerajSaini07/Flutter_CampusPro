class ExamTestResultModel {
  final int examId;
  final String exam;
  final String subjectName;
  final String isAbsent;
  final double maxMarks;
  final String total;
  final String grades;
  final String percentage;
  final String subAssessment;
  final int displayOrderNo;

  ExamTestResultModel({
    required this.examId,
    required this.exam,
    required this.subjectName,
    required this.isAbsent,
    required this.maxMarks,
    required this.total,
    required this.grades,
    required this.percentage,
    required this.subAssessment,
    required this.displayOrderNo,
  });

  factory ExamTestResultModel.fromJson(Map<String, dynamic> json) {
    return ExamTestResultModel(
      examId: json['ExamId'] ?? 0,
      exam: json['Exam'] ?? '',
      subjectName: json['SubjectName'] ?? '',
      isAbsent: json['isabsent'] ?? 'N',
      maxMarks: (json['maxmarks'] ?? 0.0).toDouble(),
      total: json['total'] ?? '0',
      grades: json['Grades'] ?? '',
      percentage: json['percentage'] ?? '0.0',
      subAssessment: json['Subassessment'] ?? '',
      displayOrderNo: json['DisplayOrderNo'] ?? 0,
    );
  }

  // Method to convert an instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'ExamId': examId,
      'Exam': exam,
      'SubjectName': subjectName,
      'isabsent': isAbsent,
      'maxmarks': maxMarks,
      'total': total,
      'Grades': grades,
      'percentage': percentage,
      'Subassessment': subAssessment,
      'DisplayOrderNo': displayOrderNo,
    };
  }
}

class ExamModelForStudentResult {
  int examId;
  String exam;

  ExamModelForStudentResult({
    required this.examId,
    required this.exam,
  });

  factory ExamModelForStudentResult.fromJson(Map<String, dynamic> json) {
    return ExamModelForStudentResult(
      examId: json['ExamID'],
      exam: json['Exam'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ExamID': examId,
      'Exam': exam,
    };
  }
}

//  ********************************************* Graph model *************************

class TestResultGraphDataModel {
  String examname;
  String subjectname;
  String maxmarks;
  String marksobtain;
  String maxmarksobtain;
  String avragmarksobtain;

  TestResultGraphDataModel(
      {required this.examname,
      required this.subjectname,
      required this.avragmarksobtain,
      required this.marksobtain,
      required this.maxmarks,
      required this.maxmarksobtain});

  factory TestResultGraphDataModel.fromJson(Map<String, dynamic> json) {
    return TestResultGraphDataModel(
      examname: json['Exam'],
      subjectname: json['SubjectName'],
      avragmarksobtain: json['AveObtained'].toString(),
      marksobtain: json['MarksObtain'].toString(),
      maxmarks: json['MaxMarks'].toString(),
      maxmarksobtain: json['MaxObtained'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Exam': examname,
      'SubjectName': subjectname,
      'AveObtained': avragmarksobtain,
      'MarksObtain': marksobtain,
      'MaxMarks': maxmarks,
      'MaxObtained': maxmarksobtain,
    };
  }
}
