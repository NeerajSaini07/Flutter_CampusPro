class HomeWorkByDateModel {
  int? id;
  String? attDate;
  String? homeworkMsg;
  String? homeworkURL;
  String? name;
  String? subjectName;

  HomeWorkByDateModel({
    this.id,
    this.attDate,
    this.homeworkMsg,
    this.homeworkURL,
    this.name,
    this.subjectName,
  });

  factory HomeWorkByDateModel.fromJson(Map<String, dynamic> json) {
    return HomeWorkByDateModel(
      id: json['ID'] ?? 0,
      attDate: json['AttDate'] ?? "",
      homeworkMsg: json['HomeworkMsg'] ?? "",
      homeworkURL: json['HomeworkURL'] ?? "",
      name: json['Name'] ?? "",
      subjectName: json['SubjectName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = id;
    data['AttDate'] = attDate;
    data['HomeworkMsg'] = homeworkMsg;
    data['HomeworkURL'] = homeworkURL;
    data['Name'] = name;
    data['SubjectName'] = subjectName;
    return data;
  }
}
