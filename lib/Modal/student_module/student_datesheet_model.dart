class Datesheetl{
  static List<Datesheetmodel> datesheetlist = [];
}

class Datesheetmodel {
  int? classId;
  int? streamId;
  int? yearId;
  int? examId;
  String? exam;
  String? subjectHead;
  String? subjectCode;
  String? examDate;
  String? shift;
  String? timing;
  String? syllabus;

  Datesheetmodel({
    this.classId,
    this.streamId,
    this.yearId,
    this.examId,
    this.exam,
    this.subjectHead,
    this.subjectCode,
    this.examDate,
    this.shift,
    this.timing,
    this.syllabus,
  });

  Datesheetmodel.fromJson(Map<String, dynamic> json) {
    classId = json['ClassId'];
    streamId = json['StreamId'];
    yearId = json['YearId'];
    examId = json['ExamId'];
    exam = json['Exam'];
    subjectHead = json['SubjectHead'];
    subjectCode = json['SubjectCode'];
    examDate = json['ExamDate'];
    shift = json['Shift'];
    timing = json['Timing'];
    syllabus = json['Syllabus'];
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['ClassId'] = classId;
    data['StreamId'] = streamId;
    data['YearId'] = yearId;
    data['ExamId'] = examId;
    data['Exam'] = exam;
    data['SubjectHead'] = subjectHead;
    data['SubjectCode'] = subjectCode;
    data['ExamDate'] = examDate;
    data['Shift'] = shift;
    data['Timing'] = timing;
    data['Syllabus'] = syllabus;
    return data;
  }
}
