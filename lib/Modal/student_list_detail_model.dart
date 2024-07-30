class StudentListDetailModel {
  StudentListDetailModel({
    required this.data,
    required this.status,
    required this.message,
  });
  late final StudentDetailsData data;
  late final String status;
  late final String message;

  StudentListDetailModel.fromJson(Map<String, dynamic> json) {
    data = StudentDetailsData.fromJson(json['Data']);
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

class StudentDetailsData {
  StudentDetailsData({
    required this.table,
  });
  late final List<StudentDetailsTable> table;

  StudentDetailsData.fromJson(Map<String, dynamic> json) {
    table = List.from(json['Table'])
        .map((e) => StudentDetailsTable.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final sdata = <String, dynamic>{};
    sdata['Table'] = table.map((e) => e.toJson()).toList();
    return sdata;
  }
}

class StudentDetailsTable {
  StudentDetailsTable({
    required this.admNo,
    required this.studentID,
    required this.stName,
    required this.fatherName,
    required this.guardianMobileNo,
    required this.prsntAddress,
    required this.fee,
    required this.areaIDDrop,
    required this.stopIdDrop,
    required this.busIDDrop,
    required this.routeIdDrop,
    required this.srNo,
  });
  late final String admNo;
  late final int studentID;
  late final String stName;
  late final String fatherName;
  late final String guardianMobileNo;
  late final String prsntAddress;
  late final String fee;
  late final int areaIDDrop;
  late final int stopIdDrop;
  late final int busIDDrop;
  late final int routeIdDrop;
  late final int srNo;

  StudentDetailsTable.fromJson(Map<String, dynamic> json) {
    admNo = json['AdmNo'];
    studentID = json['StudentID'];
    stName = json['StName'];
    fatherName = json['FatherName'];
    guardianMobileNo = json['GuardianMobileNo'];
    prsntAddress = json['PrsntAddress'];
    fee = json['Fee'];
    areaIDDrop = json['AreaID_Drop'];
    stopIdDrop = json['StopId_Drop'];
    busIDDrop = json['BusID_Drop'];
    routeIdDrop = json['RouteId_Drop'];
    srNo = json['SrNo'];
  }

  Map<String, dynamic> toJson() {
    final sdata = <String, dynamic>{};
    sdata['AdmNo'] = admNo;
    sdata['StudentID'] = studentID;
    sdata['StName'] = stName;
    sdata['FatherName'] = fatherName;
    sdata['GuardianMobileNo'] = guardianMobileNo;
    sdata['PrsntAddress'] = prsntAddress;
    sdata['Fee'] = fee;
    sdata['AreaID_Drop'] = areaIDDrop;
    sdata['StopId_Drop'] = stopIdDrop;
    sdata['BusID_Drop'] = busIDDrop;
    sdata['RouteId_Drop'] = routeIdDrop;
    sdata['SrNo'] = srNo;
    return sdata;
  }
}
