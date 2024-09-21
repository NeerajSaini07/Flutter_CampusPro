class SessionModel {
  int id;
  String sessionFrom;
  int status;

  SessionModel({
    required this.id,
    required this.sessionFrom,
    required this.status,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['Id'],
      sessionFrom: json['SessionFrom'],
      status: json['Status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'SessionFrom': sessionFrom,
      'Status': status,
    };
  }
}

// ************************************************** Get analysis exam name model **********************

class ExamnameModel {
  int examId;
  String exam;

  ExamnameModel({
    required this.examId,
    required this.exam,
  });

  factory ExamnameModel.fromJson(Map<String, dynamic> json) {
    return ExamnameModel(
      examId: json['examid'],
      exam: json['exam'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'examid': examId,
      'exam': exam,
    };
  }
}

//   **********************   analysis report data model ********************************

class ExamanalysisDataModel {
  final int examId;
  final String exam;
  final int subjectId;
  final String subjectName;
  final double marksObtain;

  ExamanalysisDataModel({
    required this.examId,
    required this.exam,
    required this.subjectId,
    required this.subjectName,
    required this.marksObtain,
  });

  factory ExamanalysisDataModel.fromJson(Map<String, dynamic> json) {
    return ExamanalysisDataModel(
      examId: json['ExamId'],
      exam: json['exam'],
      subjectId: json['SubjectId'],
      subjectName: json['SubjectName'],
      marksObtain: json['MarksObtain'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ExamId': examId,
      'exam': exam,
      'SubjectId': subjectId,
      'SubjectName': subjectName,
      'MarksObtain': marksObtain,
    };
  }
}

//  ************************* model for specific exam ******************************

class SingleExamAnalysisModel {
  final int examId;
  final String exam;
  final int subjectId;
  final String subjectName;
  final int studentId;
  final String studentName;
  final String maxMarks;
  final String marksObtain;
  final String maxMarksObtain;
  final String aveMarksObtain;

  SingleExamAnalysisModel({
    required this.examId,
    required this.exam,
    required this.subjectId,
    required this.subjectName,
    required this.studentId,
    required this.studentName,
    required this.maxMarks,
    required this.marksObtain,
    required this.maxMarksObtain,
    required this.aveMarksObtain,
  });

  factory SingleExamAnalysisModel.fromJson(Map<String, dynamic> json) {
    return SingleExamAnalysisModel(
      examId: json['ExamId'],
      exam: json['Exam'],
      subjectId: json['SubjectId'],
      subjectName: json['SubjectName'],
      studentId: json['StudentId'],
      studentName: json['StudentName'],
      maxMarks: json['MaxMarks'],
      marksObtain: json['MarksObtain'],
      maxMarksObtain: json['MaxMarksObtain'],
      aveMarksObtain: json['AveMarksObtain'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ExamId': examId,
      'Exam': exam,
      'SubjectId': subjectId,
      'SubjectName': subjectName,
      'StudentId': studentId,
      'StudentName': studentName,
      'MaxMarks': maxMarks,
      'MarksObtain': marksObtain,
      'MaxMarksObtain': maxMarksObtain,
      'AveMarksObtain': aveMarksObtain,
    };
  }
}
