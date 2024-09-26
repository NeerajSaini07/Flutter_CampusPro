class StudentCalendarlist {
  static List<StudentCalendarModel> stuCalendarList = [];
}

class StudentCalendarModel {
  String? id = "";
  String? name = "";
  String? description = "";
  String? type = "";
  String? date = "";
  String? mode = "";

  StudentCalendarModel(
      {this.id, this.name, this.description, this.type, this.date, this.mode});

  StudentCalendarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    description = json['description'] ?? "";
    type = json['type'] ?? "";
    date = json['date2'] ?? "";
    mode = json['mode'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['date2'] = date;
    data['mode'] = mode;
    return data;
  }
}

class CalendarEventModel {
  List? circularDots;
  String? leave;
  String? holiday;
  String? event;

  CalendarEventModel({this.circularDots, this.leave, this.holiday, this.event});

  CalendarEventModel.fromJson(Map<String, dynamic> json) {
    if (json['circularDots'] != null) {
      circularDots = [];
      json['circularDots'].forEach((v) {
        circularDots!.add(v);
      });
    }
    leave = json['leave'] ?? "";
    holiday = json['holiday'] ?? "";
    event = json['event'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (circularDots != null) {
      data['circularDots'] = circularDots!.map((v) => v.toJson()).toList();
    }
    data['leave'] = leave;
    data['holiday'] = holiday;
    data['event'] = event;
    return data;
  }
}
