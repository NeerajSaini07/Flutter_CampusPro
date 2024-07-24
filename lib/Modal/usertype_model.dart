// ignore_for_file: unnecessary_this

class UserTypeslist {
  static List<UserTypeModel> userTypesDetails = [];
}

class UserTypeModel {
  String? buttonConfigString = "";
  String? schoolName = "";
  String? attStartTime = "";
  String? attCloseTime = "";
  String? showFeeReceipt = "";
  String? editAmount = "";
  String? incrementMonthId = "";
  String? currentSessionid = "";
  String? organizationId = "";
  String? schoolId = "";
  String? stuEmpId = "";
  String? stuEmpName = "";
  String? ouserType = "";
  String? headerImgPath = "";
  String? logoImgPath = "";
  String? websiteUrl = "";
  String? bloggerUrl = "";
  String? busId = "";
  String? sendOtpToVisitor = "";
  String? letPayOldFeeMonths = "";
  String? fillFeeAmount = "";
  String? testUrl = "";
  String? isShowMobileNo = "";
  String? empJoinOnPlatformApp = "";
  String? stuJoinOnPlatformApp = "";
  String? baseDomainURL = "";
  String? appUrl = "";
  String? userName = "";
  String? dashboardUrl = "";
  String? dashboardType = "";

  UserTypeModel(
      {this.buttonConfigString,
      this.schoolName,
      this.attStartTime,
      this.attCloseTime,
      this.showFeeReceipt,
      this.editAmount,
      this.incrementMonthId,
      this.currentSessionid,
      this.organizationId,
      this.schoolId,
      this.stuEmpId,
      this.stuEmpName,
      this.ouserType,
      this.headerImgPath,
      this.logoImgPath,
      this.websiteUrl,
      this.bloggerUrl,
      this.busId,
      this.sendOtpToVisitor,
      this.letPayOldFeeMonths,
      this.fillFeeAmount,
      this.testUrl,
      this.isShowMobileNo,
      this.empJoinOnPlatformApp,
      this.stuJoinOnPlatformApp,
      this.baseDomainURL,
      this.appUrl,
      this.dashboardType,
      this.dashboardUrl,
      this.userName});

  UserTypeModel.fromJson(Map<String, dynamic> json) {
    buttonConfigString = json['ButtonConfigString'] ?? "";
    schoolName = json['SchoolName'] ?? "";
    attStartTime = json['AttStartTime'] ?? "";
    attCloseTime = json['AttCloseTime'] ?? "";
    showFeeReceipt = json['ShowFeeReceipt'] ?? "";
    editAmount = json['EditAmount'] ?? "";
    incrementMonthId = json['IncrementMonthId'] ?? "";
    currentSessionid = json['CurrentSessionid'] ?? "";
    organizationId = json['OrganizationId'] ?? "";
    schoolId = json['SchoolId'] ?? "";
    stuEmpId = json['StuEmpId'] ?? "";
    stuEmpName = json['StuEmpName'] ?? "";
    ouserType = json['OuserType'] ?? "";
    headerImgPath = json['HeaderImgPath'] ?? "";
    logoImgPath = json['LogoImgPath'] ?? "";
    websiteUrl = json['WebsiteUrl'] ?? "";
    bloggerUrl = json['BloggerUrl'] ?? "";
    busId = json['BusId'] ?? "";
    sendOtpToVisitor = json['SendOtpToVisitor'] ?? "";
    letPayOldFeeMonths = json['LetPayOldFeeMonths'] ?? "";
    fillFeeAmount = json['FillFeeAmount'] ?? "";
    testUrl = json['TestUrl'] ?? "";
    isShowMobileNo = json['IsShowMobileNo'] ?? "";
    empJoinOnPlatformApp = json['EmpJoinOnPlatformApp'] ?? "";
    stuJoinOnPlatformApp = json['StuJoinOnPlatformApp'] ?? "";
    baseDomainURL = json['BaseDomainURL'] ?? "";
    appUrl = json['AppUrl'] ?? "";
    dashboardType = json["Flag"];
    dashboardUrl = json["Url"];
    userName = json["UserName"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ButtonConfigString'] = this.buttonConfigString;
    data['SchoolName'] = this.schoolName;
    data['AttStartTime'] = this.attStartTime;
    data['AttCloseTime'] = this.attCloseTime;
    data['ShowFeeReceipt'] = this.showFeeReceipt;
    data['EditAmount'] = this.editAmount;
    data['IncrementMonthId'] = this.incrementMonthId;
    data['CurrentSessionid'] = this.currentSessionid;
    data['OrganizationId'] = this.organizationId;
    data['SchoolId'] = this.schoolId;
    data['StuEmpId'] = this.stuEmpId;
    data['StuEmpName'] = this.stuEmpName;
    data['OuserType'] = this.ouserType;
    data['HeaderImgPath'] = this.headerImgPath;
    data['LogoImgPath'] = this.logoImgPath;
    data['WebsiteUrl'] = this.websiteUrl;
    data['BloggerUrl'] = this.bloggerUrl;
    data['BusId'] = this.busId;
    data['SendOtpToVisitor'] = this.sendOtpToVisitor;
    data['LetPayOldFeeMonths'] = this.letPayOldFeeMonths;
    data['FillFeeAmount'] = this.fillFeeAmount;
    data['TestUrl'] = this.testUrl;
    data['IsShowMobileNo'] = this.isShowMobileNo;
    data['EmpJoinOnPlatformApp'] = this.empJoinOnPlatformApp;
    data['StuJoinOnPlatformApp'] = this.stuJoinOnPlatformApp;
    data['BaseDomainURL'] = this.baseDomainURL;
    data['AppUrl'] = this.appUrl;
    data['UserName'] = this.userName;
    return data;
  }
}
