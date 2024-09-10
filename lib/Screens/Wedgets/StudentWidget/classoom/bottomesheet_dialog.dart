import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showFilterOptions(BuildContext context) {
  String sortBy = 'Teacher';

  final Map<String, List<String>> teacherSubjectMap = {
    'Jai': ['Maths', 'Science'],
    'Ajit': ['English', 'History'],
    'Nazish Hussain': ['Geography', 'Computer Science', "Hindi"],
    'Anurag': ['Physics', 'Chemistry'],
    'Ashish': ['Physics', 'Chemistry'],
  };

  String? selectedTeacher;
  List<String> selectedSubjects = [];

  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 20.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      underline: Container(), // Remove the default underline
                      dropdownColor: AppColors.whitetextcolor,
                      value: sortBy,

                      borderRadius: BorderRadius.circular(20),
                      // icon: Icon(Icons.sort, color: AppColors.primarycolor), // Sort icon
                      iconSize: 24.sp,
                      items: ['Teacher', 'Subject'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          sortBy = newValue!;
                        });
                      },
                      // Custom button with icon and text
                      selectedItemBuilder: (BuildContext context) {
                        return ['Teacher', 'Subject']
                            .map<Widget>((String item) {
                          return Row(
                            children: [
                              Icon(Icons.sort,
                                  color: AppColors.primarycolor), // Sort icon
                              SizedBox(width: 5.w),
                              Text(
                                "SORT",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.primarycolor,
                                ),
                              ),
                            ],
                          );
                        }).toList();
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        splashColor: AppColors.appbuttonColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4.r),
                        onTap: () {
                          Navigator.pop(context);
                          // Add your functionality here for the 'Apply' button
                        },
                        child: Text(
                          'Apply',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.blackcolor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.h),
                // Display teachers or subjects based on sorting option
                if (sortBy == 'Teacher') ...[
                  Wrap(
                    spacing: 5.0,
                    runSpacing: 5.h,
                    children: teacherSubjectMap.keys.map((Teacher) {
                      return SizedBox(
                        child: FilterChip(
                          padding: EdgeInsets.all(2),
                          backgroundColor: AppColors.whitetextcolor,
                          label: Text(
                            Teacher,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                          selected: selectedTeacher == Teacher,
                          onSelected: (isSelected) {
                            setState(() {
                              selectedTeacher = isSelected ? Teacher : null;
                              selectedSubjects
                                  .clear(); // Clear subjects if the teacher changes
                            });
                          },
                          selectedColor: Colors.blue.shade100,
                          checkmarkColor: Colors.blue,
                        ),
                      );
                    }).toList(),
                  ),
                ] else if (sortBy == 'Subject') ...[
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 15.h,
                    children: teacherSubjectMap.values
                        .expand((subjectList) => subjectList)
                        .toSet()
                        .map((Subject) {
                      return SizedBox(
                        child: FilterChip(
                          backgroundColor: AppColors.whitetextcolor,
                          label: Text(
                            Subject,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.bold),
                          ),
                          selected: selectedSubjects.contains(Subject),
                          onSelected: (isSelected) {
                            setState(() {
                              if (isSelected) {
                                selectedSubjects.add(Subject);
                              } else {
                                selectedSubjects.remove(Subject);
                              }
                            });
                          },
                          selectedColor: Colors.green.shade100,
                          checkmarkColor: Colors.green,
                        ),
                      );
                    }).toList(),
                  ),
                ],
                SizedBox(height: 10.h),

                if (selectedTeacher != null && sortBy == 'Teacher')
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8.r),
                        decoration:
                            BoxDecoration(color: AppColors.primarycolor),
                        child: Text(
                          "Choose Subject",
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whitetextcolor),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 15.h,
                        children:
                            teacherSubjectMap[selectedTeacher]!.map((Subject) {
                          return SizedBox(
                            width: 100.w,
                            child: FilterChip(
                              backgroundColor: AppColors.whitetextcolor,
                              label: Text(
                                Subject,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              selected: selectedSubjects.contains(Subject),
                              onSelected: (isSelected) {
                                setState(() {
                                  if (isSelected) {
                                    selectedSubjects.add(Subject);
                                  } else {
                                    selectedSubjects.remove(Subject);
                                  }
                                });
                              },
                              selectedColor: Colors.green.shade100,
                              checkmarkColor: Colors.green,
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
              ],
            ),
          );
        },
      );
    },
  );
}
