import 'package:campuspro/Modal/student_module/student_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

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
    return ProfilePicture(
      name: StudentDetaillist.studentdetails.first.stName ?? "",
      count: 1,
      radius: radius,
      fontsize: fontSize,
      img: StudentDetaillist.studentdetails.first.imageUrl,
      tooltip: tooltip,
    );
  }
}
