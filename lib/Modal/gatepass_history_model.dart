class GatePassHistory {
  static List<GatePassHistoryModel> gatePassHistoryList = [];
}

class GatePassHistoryModel {
  int? id;
  int? stuId;
  String? name;
  String? relWithStu;
  String? contactNo;
  String? purpose;
  String? time;
  String? toTime;
  String? passType;
  String? studentEmployeeName;
  String? imagePath;

  GatePassHistoryModel(
      {this.id,
      this.stuId,
      this.name,
      this.relWithStu,
      this.contactNo,
      this.purpose,
      this.time,
      this.toTime,
      this.passType,
      this.studentEmployeeName,
      this.imagePath});

  GatePassHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    stuId = json['StuId'];
    name = json['Name'];
    relWithStu = json['RelWithStu'];
    contactNo = json['ContactNo'];
    purpose = json['Purpose'];
    time = json['Time'];
    toTime = json['ToTime'];
    passType = json['PassType'];
    studentEmployeeName = json['StudentEmployeeName'];
    imagePath = json['ImagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['StuId'] = stuId;
    data['Name'] = name;
    data['RelWithStu'] = relWithStu;
    data['ContactNo'] = contactNo;
    data['Purpose'] = purpose;
    data['Time'] = time;
    data['Status'] = toTime;
    data['PassType'] = passType;
    data['StudentEmployeeName'] = studentEmployeeName;
    data['ImagePath'] = imagePath;
    return data;
  }
}
