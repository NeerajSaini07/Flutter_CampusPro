class StudentLeaveRequestList {
  static List<StudentLeaveRequestModel> studentLeaveRequestList = [];
}

class StudentLeaveRequestModel {
  String? leaveDayType;
  String? leaveType;
  String? fromDate;
  String? toDate;
  String? leaveStatus;
  int? allowedFor;

  StudentLeaveRequestModel(
      {this.leaveDayType,
      this.leaveType,
      this.fromDate,
      this.toDate,
      this.leaveStatus,
      this.allowedFor});

  StudentLeaveRequestModel.fromJson(Map<String, dynamic> json) {
    leaveDayType = json['LeaveDayType'] ?? "";
    leaveType = json['LeaveType'] ?? "";
    fromDate = json['FromDate'] ?? "";
    toDate = json['ToDate'] ?? "";
    leaveStatus = json['LeaveStatus'] ?? "";
    allowedFor = json['AllowedFor'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LeaveDayType'] = leaveDayType;
    data['LeaveType'] = leaveType;
    data['FromDate'] = fromDate;
    data['ToDate'] = toDate;
    data['LeaveStatus'] = leaveStatus;
    data['AllowedFor'] = allowedFor;
    return data;
  }
}
