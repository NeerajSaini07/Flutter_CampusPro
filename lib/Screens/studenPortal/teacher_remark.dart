import 'package:campuspro/Controllers/StudentControllers/profileController.dart';
import 'package:campuspro/Modal/student_module/student_remark_model.dart';
import 'package:campuspro/Screens/Wedgets/StudentWidget/profile/remark_list_card_style.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentTeacherRemark extends StatelessWidget {
  StudentTeacherRemark({super.key});
  final StudentProfileController profileController =
      Get.find<StudentProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Teacher Remark"),
      body: FutureBuilder<List<StudentRemarkModel>>(
        future: profileController.getStudentRemarkData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final remarkData = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: remarkData.length,
              itemBuilder: (context, index) {
                return remarkListCardView(remarkData[index]);
              },
            );
          }
        },
      ),
    );
  }
}
