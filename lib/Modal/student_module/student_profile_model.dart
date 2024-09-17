class StudentProfileList {
  static List<StudentProfileModel> studentProfileList = [];
}

class StudentProfileModel {
  String? email;
  int? studentid;
  String? admNo;
  String? stName;
  String? gender;
  String? dOB;
  String? fatherName;
  String? motherName;
  String? mobileNo;
  String? guardianMobileNo;
  String? category;
  String? caste;
  String? religion;
  String? bloodGroup;
  String? prsntAddress;
  String? permanentAddress;
  String? nationality;
  String? pCity;
  String? pState;
  String? pO;
  String? village;
  String? presZip;
  String? permanentPin;
  String? prsntphoneno;
  String? className;
  String? streamname;
  String? year;
  String? classSection;
  String? motherAadharNo;
  String? fatherAadharNo;
  String? studentAadharNo;
  String? dobNew;
  String? studentImagePath;
  String? fatherImagePath;
  String? motherImagePath;
  String? houseName;
  String? examRollNo;
  String? familyID;
  String? conPersonImagePath;

  StudentProfileModel(
      {this.email,
      this.studentid,
      this.admNo,
      this.stName,
      this.gender,
      this.dOB,
      this.fatherName,
      this.motherName,
      this.mobileNo,
      this.guardianMobileNo,
      this.category,
      this.caste,
      this.religion,
      this.bloodGroup,
      this.prsntAddress,
      this.permanentAddress,
      this.nationality,
      this.pCity,
      this.pState,
      this.pO,
      this.village,
      this.presZip,
      this.permanentPin,
      this.prsntphoneno,
      this.className,
      this.streamname,
      this.year,
      this.classSection,
      this.motherAadharNo,
      this.fatherAadharNo,
      this.studentAadharNo,
      this.dobNew,
      this.studentImagePath,
      this.fatherImagePath,
      this.motherImagePath,
      this.houseName,
      this.examRollNo,
      this.familyID,
      this.conPersonImagePath});

  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    email = json['Email'] ?? "";
    studentid = json['Studentid'] ?? "";
    admNo = json['AdmNo'] ?? "";
    stName = json['StName'] ?? "";
    gender = json['Gender'] ?? "";
    dOB = json['DOB'] ?? "";
    fatherName = json['FatherName'] ?? "";
    motherName = json['MotherName'] ?? "";
    mobileNo = json['MobileNo'] ?? "";
    guardianMobileNo = json['GuardianMobileNo'] ?? "";
    category = json['Category'] ?? "";
    caste = json['Caste'] ?? "";
    religion = json['Religion'] ?? "";
    bloodGroup = json['BloodGroup'] ?? "";
    prsntAddress = json['PrsntAddress'] ?? "";
    permanentAddress = json['PermanentAddress'] ?? "";
    nationality = json['nationality'] ?? "";
    pCity = json['pCity'] ?? "";
    pState = json['pState'] ?? "";
    pO = json['PO'] ?? "";
    village = json['Village'] ?? "";
    presZip = json['PresZip'] ?? "";
    permanentPin = json['PermanentPin'] ?? "";
    prsntphoneno = json['prsntphoneno'] ?? "";
    className = json['ClassName'] ?? "";
    streamname = json['streamname'] ?? "";
    year = json['year'] ?? "";
    classSection = json['ClassSection'] ?? "";
    motherAadharNo = json['MotherAadharNo'] ?? "";
    fatherAadharNo = json['FatherAadharNo'] ?? "";
    studentAadharNo = json['StudentAadharNo'] ?? "";
    dobNew = json['DobNew'] ?? "";
    studentImagePath = json['StudentImagePath'] ?? "";
    fatherImagePath = json['FatherImagePath'] ?? "";
    motherImagePath = json['MotherImagePath'] ?? "";
    houseName = json['HouseName'] ?? "";
    examRollNo = json['ExamRollNo'] ?? "";
    familyID = json['FamilyID'] ?? "";
    conPersonImagePath = json['ConPersonImagePath'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Email'] = email;
    data['Studentid'] = studentid;
    data['AdmNo'] = admNo;
    data['StName'] = stName;
    data['Gender'] = gender;
    data['DOB'] = dOB;
    data['FatherName'] = fatherName;
    data['MotherName'] = motherName;
    data['MobileNo'] = mobileNo;
    data['GuardianMobileNo'] = guardianMobileNo;
    data['Category'] = category;
    data['Caste'] = caste;
    data['Religion'] = religion;
    data['BloodGroup'] = bloodGroup;
    data['PrsntAddress'] = prsntAddress;
    data['PermanentAddress'] = permanentAddress;
    data['nationality'] = nationality;
    data['pCity'] = pCity;
    data['pState'] = pState;
    data['PO'] = pO;
    data['Village'] = village;
    data['PresZip'] = presZip;
    data['PermanentPin'] = permanentPin;
    data['prsntphoneno'] = prsntphoneno;
    data['ClassName'] = className;
    data['streamname'] = streamname;
    data['year'] = year;
    data['ClassSection'] = classSection;
    data['MotherAadharNo'] = motherAadharNo;
    data['FatherAadharNo'] = fatherAadharNo;
    data['StudentAadharNo'] = studentAadharNo;
    data['DobNew'] = dobNew;
    data['StudentImagePath'] = studentImagePath;
    data['FatherImagePath'] = fatherImagePath;
    data['MotherImagePath'] = motherImagePath;
    data['HouseName'] = houseName;
    data['ExamRollNo'] = examRollNo;
    data['FamilyID'] = familyID;
    data['ConPersonImagePath'] = conPersonImagePath;
    return data;
  }
}
