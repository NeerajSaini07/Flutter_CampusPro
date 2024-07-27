class StudentListRouteDropDown {
  StudentListRouteDropDown({
    required this.data,
    required this.status,
    required this.message,
  });
  late final StudentData data;
  late final String status;
  late final String message;

  StudentListRouteDropDown.fromJson(Map<String, dynamic> json) {
    data = StudentData.fromJson(json['Data']);
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

class StudentData {
  StudentData({
    required this.table,
  });
  late final List<StudentTable> table;

  StudentData.fromJson(Map<String, dynamic> json) {
    table =
        List.from(json['Table']).map((e) => StudentTable.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final sdata = <String, dynamic>{};
    sdata['Table'] = table.map((e) => e.toJson()).toList();
    return sdata;
  }
}

class StudentTable {
  StudentTable({
    required this.routeID,
    required this.routeName,
  });
  late final int routeID;
  late final String routeName;

  StudentTable.fromJson(Map<String, dynamic> json) {
    routeID = json['RouteID'];
    routeName = json['RouteName'];
  }

  Map<String, dynamic> toJson() {
    final sdata = <String, dynamic>{};
    sdata['RouteID'] = routeID;
    sdata['RouteName'] = routeName;
    return sdata;
  }
}
