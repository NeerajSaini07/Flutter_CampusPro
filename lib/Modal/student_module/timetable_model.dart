class StudentTimetableModel {
  List<Period> periods;
  List<ClassInfo> classes;
  List<Timetable> timetables;

  StudentTimetableModel(
      {required this.periods, required this.classes, required this.timetables});

  factory StudentTimetableModel.fromJson(Map<String, dynamic> json) {
    return StudentTimetableModel(
      periods: (json['Table'] as List).map((e) => Period.fromJson(e)).toList(),
      classes:
          (json['Table1'] as List).map((e) => ClassInfo.fromJson(e)).toList(),
      timetables:
          (json['Table2'] as List).map((e) => Timetable.fromJson(e)).toList(),
    );
  }
}

class Period {
  int periodId;
  String periodName;

  Period({required this.periodId, required this.periodName});

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      periodId: json['PeriodId'],
      periodName: json['PeriodName'],
    );
  }
}

class ClassInfo {
  String id;
  String className;

  ClassInfo({required this.id, required this.className});

  factory ClassInfo.fromJson(Map<String, dynamic> json) {
    return ClassInfo(
      id: json['ID'],
      className: json['ClassName'],
    );
  }
}

class Timetable {
  String dayStr;
  String combName;
  String period1;
  String period2;
  String period3;
  String period4;
  String period5;
  String period6;
  String period7;

  Timetable({
    required this.dayStr,
    required this.combName,
    required this.period1,
    required this.period2,
    required this.period3,
    required this.period4,
    required this.period5,
    required this.period6,
    required this.period7,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) {
    return Timetable(
      dayStr: json['DayStr'],
      combName: json['CombName'],
      period1: json['Period_1'],
      period2: json['Period_2'],
      period3: json['Period_3'],
      period4: json['Period_4'],
      period5: json['Period_5'],
      period6: json['Period_6'],
      period7: json['Period_7'],
    );
  }
}
