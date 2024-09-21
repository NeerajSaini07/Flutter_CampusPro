class StudentAttendanceList {
  static List<StudentAttendanceModel> studentAttendanceList = [];
}

class StudentAttendanceModel {
  String? attDate;
  String? newAttDate;
  String? attStatus;

  StudentAttendanceModel({this.attDate, this.newAttDate, this.attStatus});

  StudentAttendanceModel.fromJson(Map<String, dynamic> json) {
    attDate = json['AttDate'] ?? "";
    newAttDate = json['NewAttDate'] ?? "";
    attStatus = json['AttStatus'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AttDate'] = attDate;
    data['NewAttDate'] = newAttDate;
    data['AttStatus'] = attStatus;
    return data;
  }
}
