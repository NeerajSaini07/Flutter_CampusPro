class StudentCircularList {
  static List<StudentCircularModel> studentCircularList = [];
}

class StudentCircularModel {
  int? circularId;
  String? cirNo;
  String? circularDate;
  String? cirSubject;
  String? cirContent;
  String? circularFileurl;
  String? className;
  int? empId;
  String? empName;
  String? forStuEmp;
  String? createdTimestamp;

  StudentCircularModel({
    this.circularId,
    this.cirNo,
    this.circularDate,
    this.cirSubject,
    this.cirContent,
    this.circularFileurl,
    this.className,
    this.empId,
    this.empName,
    this.forStuEmp,
    this.createdTimestamp,
  });

  StudentCircularModel.fromJson(Map<String, dynamic> json) {
    circularId = json['CircularId'];
    cirNo = json['CirNo'] ?? "";
    circularDate = json['CircularDate'] ?? "";
    cirSubject = json['CirSubject'] ?? "";
    cirContent = json['CirContent'] ?? "";
    circularFileurl = json['CircularFileurl'] ?? "";
    className = json['ClassName'] ?? "";
    empId = json['empid'];
    empName = json['empname'] ?? "";
    forStuEmp = json['ForStuEmp'] ?? "";
    createdTimestamp = json['CreatedTimestamp'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CircularId'] = circularId;
    data['CirNo'] = cirNo;
    data['CircularDate'] = circularDate;
    data['CirSubject'] = cirSubject;
    data['CirContent'] = cirContent;
    data['CircularFileurl'] = circularFileurl;
    data['ClassName'] = className;
    data['empid'] = empId;
    data['empname'] = empName;
    data['ForStuEmp'] = forStuEmp;
    data['CreatedTimestamp'] = createdTimestamp;
    return data;
  }
}
