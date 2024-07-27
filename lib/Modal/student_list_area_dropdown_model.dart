class StudentListAreaDropDown {
  StudentListAreaDropDown({
    required this.data,
    required this.status,
    required this.message,
  });
  late final StudentAreaData data;
  late final String status;
  late final String message;

  StudentListAreaDropDown.fromJson(Map<String, dynamic> json) {
    data = StudentAreaData.fromJson(json['Data']);
    status = json['Status'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final sdata = <String, dynamic>{};
    sdata['Data'] = data.toJson();
    sdata['Status'] = status;
    sdata['Message'] = message;
    return sdata;
  }
}

class StudentAreaData {
  StudentAreaData({
    required this.table,
  });
  late final List<StudentAreaTable> table;

  StudentAreaData.fromJson(Map<String, dynamic> json) {
    table = List.from(json['Table'])
        .map((e) => StudentAreaTable.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final sdata = <String, dynamic>{};
    sdata['Table'] = table.map((e) => e.toJson()).toList();
    return sdata;
  }
}

class StudentAreaTable {
  StudentAreaTable({
    required this.areaID,
    required this.areaName,
  });
  late final int areaID;
  late final String areaName;

  StudentAreaTable.fromJson(Map<String, dynamic> json) {
    areaID = json['AreaID'];
    areaName = json['AreaName'];
  }

  Map<String, dynamic> toJson() {
    final sdata = <String, dynamic>{};
    sdata['AreaID'] = areaID;
    sdata['AreaName'] = areaName;
    return sdata;
  }
}
