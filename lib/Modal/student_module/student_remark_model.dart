class StudentRemarkList {
  static List<StudentRemarkModel> studentRemarkList = [];
}

class StudentRemarkModel {
  String? remark;
  int? id;
  int? studentId;
  String? guardianMobileNo;
  String? stName;
  String? compClass;
  String? fatherName;
  int? sessionId;
  String? addedOnDate;
  String? empName;
  String? empMobileNo;
  String? extraRemark;

  StudentRemarkModel(
      {this.remark,
      this.id,
      this.studentId,
      this.guardianMobileNo,
      this.stName,
      this.compClass,
      this.fatherName,
      this.sessionId,
      this.addedOnDate,
      this.empName,
      this.empMobileNo,
      this.extraRemark});

  StudentRemarkModel.fromJson(Map<String, dynamic> json) {
    remark = json['Remark'] ?? "";
    id = json['Id'] ?? 0;
    studentId = json['StudentId'] ?? 0;
    guardianMobileNo = json['GuardianMobileNo'] ?? "";
    stName = json['StName'] ?? "";
    compClass = json['CompClass'] ?? "";
    fatherName = json['FatherName'] ?? "";
    sessionId = json['SessionId'] ?? 0;
    addedOnDate = json['AddedOnDate'] ?? "";
    empName = json['EmpName'] ?? "";
    empMobileNo = json['EmpMobileNo'] ?? "";
    extraRemark = json['ExtraRemark'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Remark'] = remark;
    data['Id'] = id;
    data['StudentId'] = studentId;
    data['GuardianMobileNo'] = guardianMobileNo;
    data['StName'] = stName;
    data['CompClass'] = compClass;
    data['FatherName'] = fatherName;
    data['SessionId'] = sessionId;
    data['AddedOnDate'] = addedOnDate;
    data['EmpName'] = empName;
    data['EmpMobileNo'] = empMobileNo;
    data['ExtraRemark'] = extraRemark;
    return data;
  }
}
