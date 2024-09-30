import 'package:campuspro/Controllers/usertype_controller.dart';
import 'package:campuspro/Modal/employee_module/employee_info.dart';
import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:get/get.dart';

class ProfilePic extends StatelessWidget {
  final double radius;
  final double fontSize;
  final bool tooltip;
  const ProfilePic(
      {super.key,
      required this.radius,
      required this.fontSize,
      this.tooltip = false});

  @override
  Widget build(BuildContext context) {
    final UserTypeController userTypeController =
        Get.find<UserTypeController>();
    if ((StudentDetaillist.studentdetails.isNotEmpty &&
        StudentDetaillist.studentdetails.first.imageUrl
            .toString()
            .contains("https"))) {
      return ProfilePicture(
        name: UserTypeslist
            .userTypesDetails[userTypeController.usertypeIndex].stuEmpName
            .toString(),
        count: 1,
        img: StudentDetaillist.studentdetails.first.imageUrl.toString(),
        radius: radius,
        fontsize: fontSize,
        tooltip: tooltip,
      );
    } else if (EmployeeDetailList.employeeDetails.isNotEmpty &&
        EmployeeDetailList.employeeDetails.first.employeeImagePath
            .toString()
            .contains("https")) {
      return ProfilePicture(
        name: UserTypeslist
            .userTypesDetails[userTypeController.usertypeIndex].stuEmpName
            .toString(),
        count: 1,
        img: EmployeeDetailList.employeeDetails.first.employeeImagePath
            .toString(),
        radius: radius,
        fontsize: fontSize,
        tooltip: tooltip,
      );
    } else {
      return ProfilePicture(
        name: UserTypeslist
            .userTypesDetails[userTypeController.usertypeIndex].stuEmpName
            .toString(),
        count: 1,
        radius: radius,
        fontsize: fontSize,
        tooltip: tooltip,
      );
    }
  }
}
