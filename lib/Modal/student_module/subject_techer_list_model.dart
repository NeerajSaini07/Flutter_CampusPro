class FilterTechears {
  static List<ClassRoomFilterDataListModel> filterListdata = [];
}

class ClassRoomFilterDataListModel {
  String? empSub;
  int? empId;
  int? subjectId;
  int? sessionId;
  int? classId;
  int? streamId;
  int? yearId;
  int? sectionId;

  ClassRoomFilterDataListModel({
    this.empSub,
    this.empId,
    this.subjectId,
    this.sessionId,
    this.classId,
    this.streamId,
    this.yearId,
    this.sectionId,
  });

  // Constructor to initialize from JSON
  ClassRoomFilterDataListModel.fromJson(Map<String, dynamic> json) {
    empSub = json['EmpSub'];
    empId = json['EmpId'];
    subjectId = json['SubjectId'];
    sessionId = json['SessionId'];
    classId = json['ClassID'];
    streamId = json['StreamId'];
    yearId = json['YearId'];
    sectionId = json['SectionId'];
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmpSub'] = empSub;
    data['EmpId'] = empId;
    data['SubjectId'] = subjectId;
    data['SessionId'] = sessionId;
    data['ClassID'] = classId;
    data['StreamId'] = streamId;
    data['YearId'] = yearId;
    data['SectionId'] = sectionId;
    return data;
  }
}
