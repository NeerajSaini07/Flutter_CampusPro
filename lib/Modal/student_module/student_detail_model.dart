class StudentDetaillist {
  static List<StudentDetailModel> studentdetails = [];
}

class StudentDetailModel {
  String? schoolname;
  String? schoolAddress;
  int? sessionId;
  String? sessionStr;
  int? studentId;
  String? admNo;
  String? stName;
  String? fatherName;
  String? gender;
  String? dOB;
  String? compClass;
  int? classId;
  int? streamId;
  int? yearId;
  String? mobile;
  int? classSectionId;
  String? retMessage;
  String? attStatus;
  String? imageUrl;
  int? showFeeReceipt;
  String? emailid;

  StudentDetailModel(
      {this.schoolname,
      this.schoolAddress,
      this.sessionId,
      this.sessionStr,
      this.studentId,
      this.admNo,
      this.stName,
      this.fatherName,
      this.gender,
      this.dOB,
      this.compClass,
      this.classId,
      this.streamId,
      this.yearId,
      this.mobile,
      this.classSectionId,
      this.retMessage,
      this.attStatus,
      this.imageUrl,
      this.showFeeReceipt,
      this.emailid});

  StudentDetailModel.fromJson(Map<String, dynamic> json) {
    schoolname = json['Schoolname'];
    schoolAddress = json['SchoolAddress'];
    sessionId = json['SessionId'];
    sessionStr = json['SessionStr'];
    studentId = json['StudentId'];
    admNo = json['AdmNo'];
    stName = json['StName'];
    fatherName = json['FatherName'];
    gender = json['Gender'];
    dOB = json['DOB'];
    compClass = json['CompClass'];
    classId = json['ClassId'];
    streamId = json['StreamId'];
    yearId = json['YearId'];
    mobile = json['Mobile'];
    classSectionId = json['ClassSectionId'];
    retMessage = json['RetMessage'];
    attStatus = json['AttStatus'];
    imageUrl = json['imageUrl'];
    showFeeReceipt = json['showFeeReceipt'];
    emailid = json['emailid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Schoolname'] = schoolname;
    data['SchoolAddress'] = schoolAddress;
    data['SessionId'] = sessionId;
    data['SessionStr'] = sessionStr;
    data['StudentId'] = studentId;
    data['AdmNo'] = admNo;
    data['StName'] = stName;
    data['FatherName'] = fatherName;
    data['Gender'] = gender;
    data['DOB'] = dOB;
    data['CompClass'] = compClass;
    data['ClassId'] = classId;
    data['StreamId'] = streamId;
    data['YearId'] = yearId;
    data['Mobile'] = mobile;
    data['ClassSectionId'] = classSectionId;
    data['RetMessage'] = retMessage;
    data['AttStatus'] = attStatus;
    data['imageUrl'] = imageUrl;
    data['showFeeReceipt'] = showFeeReceipt;
    data['emailid'] = emailid;
    return data;
  }
}
