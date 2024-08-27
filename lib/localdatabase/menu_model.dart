import 'dart:convert';

class UserData {
  final String? mobileNo;
  final String? userId;
  final String? updatedDate;
  final String? orgId;
  final String? schoolId;
  final String? userType;
  final List drawerData;

  UserData(
      {this.mobileNo,
      this.userId,
      this.updatedDate,
      this.orgId,
      this.schoolId,
      this.userType,
      required this.drawerData});

  Map<String, dynamic> toMap() {
    return {
      'mobileNo': mobileNo,
      'userId': userId,
      'updatedDate': updatedDate,
      'orgId': orgId,
      'schoolId': schoolId,
      'userType': userType,
      'drawerData': jsonEncode(drawerData),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      mobileNo: map['mobileNo'],
      userId: map['userId'],
      updatedDate: map['updatedDate'],
      orgId: map['orgId'],
      schoolId: map['schoolId'],
      userType: map['userType'],
      drawerData: List<dynamic>.from(jsonDecode(map['drawerData'])),
    );
  }
}
