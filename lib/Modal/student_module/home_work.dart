class HomeworkList {
  static List<HomeworkModel> homeworkDetails = [];
}

class HomeworkModel {
  String? title;
  String? description;
  DateTime? date;
  String? teacherName;
  String? subject;

  HomeworkModel(
      {this.title,
      this.description,
      this.date,
      this.teacherName,
      this.subject});

  // Factory constructor to create HomeworkModel from JSON
  factory HomeworkModel.fromJson(Map<String, dynamic> json) {
    return HomeworkModel(
        title: json['Title'] ?? "",
        description: json['Description'] ?? "",
        teacherName: json['teacherName'],
        subject: json['subject'],
        date: json['date']);
  }

  // Method to convert HomeworkModel to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Title'] = title;
    data['Description'] = description;
    data['teacherName'] = teacherName;
    data['date'] = date;
    data['subject'] = subject;
    return data;
  }
}
