class EmployeeDetailList {
  static List<EmployeeDetailModel> employeeDetails = [];
}

class EmployeeDetailModel {
  int? empId;
  String? empNo;
  String? name;
  String? fatherName;
  String? husbandName;
  String? spouseName;
  String? dateOfBirth;
  String? gender;
  String? mobileNo;
  String? emailId;
  String? baseAPIURL;
  String? employeeImagePath;
  String? aadharNo;
  String? prsAddr;
  String? prmAddr;
  String? prsPin;
  String? prmPin;
  String? bloodGroup;
  int? category;
  int? religion;
  int? nationality;
  int? maritalStatus;
  String? panNo;
  String? uan;
  String? bankAcct;
  String? bankName;
  String? ifscCode;
  String? dataVerified;
  int? qualification;
  String? profQualification;
  String? speciality;
  String? ambition;
  String? idMark;
  String? prsCity;
  String? prsState;
  String? prmCity;
  String? prmState;
  int? designation;
  String? branchCode;
  String? branchName;
  String? dateOfJoining;
  String? esicNo;
  String? accountHolderName;
  String? departmentName;
  double? basicPay;
  String? prsPhone;
  String? designationName;
  String? religionName;
  String? categoryName;
  String? bloodGroupName;
  String? prsCityName;
  String? prsStateName;
  String? prmCityName;
  String? prmStateName;
  String? maritalStatusName;
  String? qualificationName;
  int? sessionId;
  String? shiftName;

  EmployeeDetailModel({
    this.empId,
    this.empNo,
    this.name,
    this.fatherName,
    this.husbandName,
    this.spouseName,
    this.dateOfBirth,
    this.gender,
    this.mobileNo,
    this.emailId,
    this.baseAPIURL,
    this.employeeImagePath,
    this.aadharNo,
    this.prsAddr,
    this.prmAddr,
    this.prsPin,
    this.prmPin,
    this.bloodGroup,
    this.category,
    this.religion,
    this.nationality,
    this.maritalStatus,
    this.panNo,
    this.uan,
    this.bankAcct,
    this.bankName,
    this.ifscCode,
    this.dataVerified,
    this.qualification,
    this.profQualification,
    this.speciality,
    this.ambition,
    this.idMark,
    this.prsCity,
    this.prsState,
    this.prmCity,
    this.prmState,
    this.designation,
    this.branchCode,
    this.branchName,
    this.dateOfJoining,
    this.esicNo,
    this.accountHolderName,
    this.departmentName,
    this.basicPay,
    this.prsPhone,
    this.designationName,
    this.religionName,
    this.categoryName,
    this.bloodGroupName,
    this.prsCityName,
    this.prsStateName,
    this.prmCityName,
    this.prmStateName,
    this.maritalStatusName,
    this.qualificationName,
    this.sessionId,
    this.shiftName,
  });

  EmployeeDetailModel.fromJson(Map<String, dynamic> json) {
    empId = json['EmpId'];
    empNo = json['Empno'];
    name = json['Name'];
    fatherName = json['FatherName'];
    husbandName = json['HusbandName'];
    spouseName = json['SpouseName'];
    dateOfBirth = json['DateOfBirth'];
    gender = json['Gender'];
    mobileNo = json['MobileNo'];
    emailId = json['emailid'];
    baseAPIURL = json['BaseAPIURL'];
    employeeImagePath = json['EmployeeImagePath'];
    aadharNo = json['AadharNo'];
    prsAddr = json['PrsAddr'];
    prmAddr = json['PrmAddr'];
    prsPin = json['Prspin'];
    prmPin = json['Prmpin'];
    bloodGroup = json['BloodGroup'];
    category = json['Category'];
    religion = json['Religion'];
    nationality = json['Nationality'];
    maritalStatus = json['MaritalStatus'];
    panNo = json['PanNo'];
    uan = json['UAN'];
    bankAcct = json['Bankacct'];
    bankName = json['BankName'];
    ifscCode = json['Ifsccode'];
    dataVerified = json['DataVerified'];
    qualification = json['Qualification'];
    profQualification = json['ProfQualification'];
    speciality = json['Spaciality'];
    ambition = json['Ambition'];
    idMark = json['IDmark'];
    prsCity = json['Prscity'];
    prsState = json['Prsstate'];
    prmCity = json['Prmcity'];
    prmState = json['Prmstate'];
    designation = json['Designation'];
    branchCode = json['BranchCode'];
    branchName = json['BranchName'];
    dateOfJoining = json['DateofJoining'];
    esicNo = json['ESICNo'];
    accountHolderName = json['AccountHolderName'];
    departmentName = json['DepartmentName'];
    basicPay = json['BasicPay'];
    prsPhone = json['PrsPhone'];
    designationName = json['DesignationName'];
    religionName = json['ReligionName'];
    categoryName = json['CategoryName'];
    bloodGroupName = json['BloodGroupName'];
    prsCityName = json['PrsCityName'];
    prsStateName = json['PrsStateName'];
    prmCityName = json['PrmCityName'];
    prmStateName = json['PrmStateName'];
    maritalStatusName = json['MaritalStatusName'];
    qualificationName = json['QualificationName'];
    sessionId = json['SessionId'];
    shiftName = json['ShiftName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['EmpId'] = empId;
    data['Empno'] = empNo;
    data['Name'] = name;
    data['FatherName'] = fatherName;
    data['HusbandName'] = husbandName;
    data['SpouseName'] = spouseName;
    data['DateOfBirth'] = dateOfBirth;
    data['Gender'] = gender;
    data['MobileNo'] = mobileNo;
    data['emailid'] = emailId;
    data['BaseAPIURL'] = baseAPIURL;
    data['EmployeeImagePath'] = employeeImagePath;
    data['AadharNo'] = aadharNo;
    data['PrsAddr'] = prsAddr;
    data['PrmAddr'] = prmAddr;
    data['Prspin'] = prsPin;
    data['Prmpin'] = prmPin;
    data['BloodGroup'] = bloodGroup;
    data['Category'] = category;
    data['Religion'] = religion;
    data['Nationality'] = nationality;
    data['MaritalStatus'] = maritalStatus;
    data['PanNo'] = panNo;
    data['UAN'] = uan;
    data['Bankacct'] = bankAcct;
    data['BankName'] = bankName;
    data['Ifsccode'] = ifscCode;
    data['DataVerified'] = dataVerified;
    data['Qualification'] = qualification;
    data['ProfQualification'] = profQualification;
    data['Spaciality'] = speciality;
    data['Ambition'] = ambition;
    data['IDmark'] = idMark;
    data['Prscity'] = prsCity;
    data['Prsstate'] = prsState;
    data['Prmcity'] = prmCity;
    data['Prmstate'] = prmState;
    data['Designation'] = designation;
    data['BranchCode'] = branchCode;
    data['BranchName'] = branchName;
    data['DateofJoining'] = dateOfJoining;
    data['ESICNo'] = esicNo;
    data['AccountHolderName'] = accountHolderName;
    data['DepartmentName'] = departmentName;
    data['BasicPay'] = basicPay;
    data['PrsPhone'] = prsPhone;
    data['DesignationName'] = designationName;
    data['ReligionName'] = religionName;
    data['CategoryName'] = categoryName;
    data['BloodGroupName'] = bloodGroupName;
    data['PrsCityName'] = prsCityName;
    data['PrsStateName'] = prsStateName;
    data['PrmCityName'] = prmCityName;
    data['PrmStateName'] = prmStateName;
    data['MaritalStatusName'] = maritalStatusName;
    data['QualificationName'] = qualificationName;
    data['SessionId'] = sessionId;
    data['ShiftName'] = shiftName;
    return data;
  }
}
