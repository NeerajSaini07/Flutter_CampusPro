import 'dart:convert';

class DashboardMenuModelLocalDb {
  final String? mobileNo;
  final String? userId;
  final String? updatedDate;
  final String? orgId;
  final String? schoolId;
  final String? userType;
  final List dashboardMenu;

  DashboardMenuModelLocalDb(
      {this.mobileNo,
      this.userId,
      this.updatedDate,
      this.orgId,
      this.schoolId,
      this.userType,
      required this.dashboardMenu});

  Map<String, dynamic> toMap() {
    return {
      'mobileNo': mobileNo,
      'userId': userId,
      'updatedDate': updatedDate,
      'orgId': orgId,
      'schoolId': schoolId,
      'userType': userType,
      'dashboardmenu': jsonEncode(dashboardMenu),
    };
  }

  factory DashboardMenuModelLocalDb.fromMap(Map<String, dynamic> map) {
    return DashboardMenuModelLocalDb(
      mobileNo: map['mobileNo'],
      userId: map['userId'],
      updatedDate: map['updatedDate'],
      orgId: map['orgId'],
      schoolId: map['schoolId'],
      userType: map['userType'],
      dashboardMenu: List<dynamic>.from(jsonDecode(map['dashboardmenu'])),
    );
  }
}
