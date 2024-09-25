class StudentHolidaylist {
  static List<StudentHolidayModel> stuHolidayList = [];
}

class StudentHolidayModel {
  String? date = "";
  String? title = "";

  StudentHolidayModel({this.date, this.title});

  StudentHolidayModel.fromJson(Map<String, dynamic> json) {
    date = json['Date'] ?? "";
    title = json['Title'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['Title'] = title;
    return data;
  }
}
