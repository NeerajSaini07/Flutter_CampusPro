// import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:campuspro/Utilities/colors.dart';

// class CircularScreen extends StatefulWidget {
//   const CircularScreen({super.key});

//   @override
//   _CircularScreenState createState() => _CircularScreenState();
// }

// class _CircularScreenState extends State<CircularScreen> {
//   DateTime? _fromDate;
//   DateTime? _toDate;
//   List<Circular> _filteredCircular = [];
//   // Sample data for the card list
//   final List<Circular> _circularList = [
//     Circular(
//       title: 'Date Sheet',
//       content:
//           '1st Sessional examination of all classes of UG/PG 3rd,5th semester are commencing w.e.f. 02-09-2024.',
//       date: '2024-08-01',
//       number: '123',
//     ),
//     Circular(
//       title: 'Teej',
//       content: 'Holiday',
//       date: '2024-08-20',
//       number: '123',
//     ),
//     Circular(
//       title: 'Holiday',
//       content: 'Yoga day',
//       date: '2024-09-03',
//       number: '123',
//     ),
//     Circular(
//       title: 'Activity',
//       content: 'Activity',
//       date: '2024-09-10',
//       number: '123',
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _filteredCircular = _circularList;
//   }

//   void _showFilterOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: const EdgeInsets.all(
//               20.0), // Increased padding for better spacing
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   width: 25.w,
//                   height: 4.h,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(2.0),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                   height: 10.h), // Additional spacing after the drag handle
//               Text(
//                 'Filter',
//                 style: AppTextStyles.filterTextStyle.copyWith(
//                   fontSize: 18.sp, // Slightly larger font for the title
//                   fontWeight: FontWeight.bold, // Bold for emphasis
//                 ),
//               ),
//               SizedBox(
//                   height: 10
//                       .h), // Increased spacing between title and filter options
//               ListTile(
//                 contentPadding:
//                     EdgeInsets.zero, // Removed default padding for alignment
//                 title: Text(
//                   'Date',
//                   style: AppTextStyles.filterOptionTextStyle,
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white70,
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 12.w,
//                             vertical: 10.h), // Better padding for buttons
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       onPressed: () => selectFromDate(context),
//                       icon: Icon(
//                         Icons.date_range,
//                         size: 18.sp,
//                         color: AppColors.blackcolor,
//                       ),
//                       label: Text(
//                           _fromDate != null
//                               ? '${_fromDate!.day}/${_fromDate!.month}/${_fromDate!.year}'
//                               : 'From',
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.blackcolor)),
//                     ),
//                     SizedBox(
//                         width: 8
//                             .w), // Slightly reduced spacing for better alignment
//                     ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white70,
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 12.w,
//                             vertical: 10.h), // Consistent button padding
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       onPressed: () => selectToDate(context),
//                       icon: Icon(
//                         Icons.date_range,
//                         size: 18.sp,
//                         color: AppColors.blackcolor,
//                       ),
//                       label: Text(
//                           _toDate != null
//                               ? '${_toDate!.day}/${_toDate!.month}/${_toDate!.year}'
//                               : 'To',
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.blackcolor)),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                   height:
//                       20.h), // Increased spacing before the Apply Filter button
//               SizedBox(height: 20.h),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       Navigator.pop(context);
//                       filterActivitiesByDate();
//                     });
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.appbuttonColor,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.r),
//                     ),
//                   ),
//                   child: Text(
//                     'Apply',
//                     style: TextStyle(fontSize: 16.sp, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> selectFromDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _fromDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _fromDate) {
//       setState(() {
//         _fromDate = picked;
//       });
//     }
//   }

//   Future<void> selectToDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _toDate ?? DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _toDate) {
//       setState(() {
//         _toDate = picked;
//       });
//     }
//   }

//   void filterActivitiesByDate() {
//     if (_fromDate != null && _toDate != null) {
//       _filteredCircular = _circularList.where((activity) {
//         DateTime activityDate = DateTime.parse(activity.date);
//         return activityDate.isAfter(_fromDate!) &&
//             activityDate.isBefore(_toDate!);
//       }).toList();
//     } else {
//       _filteredCircular = _circularList;
//     }
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(context),
//       body: Container(
//         height: double.infinity,
//         color: AppColors.whitetextcolor,
//         child: Padding(
//           padding: EdgeInsets.all(10.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 4.h),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search Circular...',
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 0.h, horizontal: 8.w),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.r),
//                           borderSide:
//                               const BorderSide(color: AppColors.appbuttonColor),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.r),
//                           borderSide:
//                               const BorderSide(color: AppColors.appbuttonColor),
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _filteredCircular = _circularList
//                               .where((circular) =>
//                                   circular.title
//                                       .toLowerCase()
//                                       .contains(value.toLowerCase()) ||
//                                   circular.content
//                                       .toLowerCase()
//                                       .contains(value.toLowerCase()))
//                               .toList();
//                         });
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   GestureDetector(
//                     onTap: () {
//                       _showFilterOptions(context);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(5.r),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(14.r),
//                         shape: BoxShape.rectangle,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Image.asset(
//                             'assets/icon/filter.png',
//                             color: AppColors.blackcolor, // Path to your image
//                             width: 30.w, // Set the width of the image
//                             height: 30.w, // Set the height of the image
//                             fit: BoxFit.contain, // Adjust the fit as needed
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5.h),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _filteredCircular.length,
//                   itemBuilder: (context, index) {
//                     return CircularCard(circular: _filteredCircular[index]);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:campuspro/Controllers/StudentControllers/circular_controller.dart';
import 'package:campuspro/Modal/student_module/student_circular_model.dart';
import 'package:campuspro/Screens/Wedgets/common_appbar.dart';
import 'package:campuspro/Screens/style/style.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:campuspro/Utilities/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentCircularScreen extends StatelessWidget {
  const StudentCircularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CircularController circularController = Get.find<CircularController>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBar(context),
        body: FutureBuilder<List<StudentCircularModel>>(
          future: circularController.getStudentCircular(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('An error occurred'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data available'));
            } else {
              final circularData = snapshot.data!;
              return ListView.builder(
                itemCount: circularData.length,
                itemBuilder: (context, index) {
                  return circularListCard(
                      circularData[index], context, circularController);
                },
              );
            }
          },
        ));
  }
}

Widget circularListCard(StudentCircularModel circularData, BuildContext context,
    CircularController circularController) {
  return Stack(
    children: [
      Card(
        color: AppColors.whitetextcolor,
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h)
            .copyWith(top: 12.h),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                circularData.cirSubject ?? "",
                style: AppTextStyles.cardTitle,
              ),
              SizedBox(height: 8.h),
              HtmlWidget(
                '''
                ${circularData.cirContent ?? ""}
                ''',
                onTapUrl: (url) async {
                  final Uri launchUri = Uri.parse(url.toString());
                  if (await canLaunchUrl(launchUri)) {
                    await launchUrl(
                      launchUri,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                  return true;
                },
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    circularData.circularDate ?? "",
                    style: AppTextStyles.cardDate,
                  ),
                  if (circularData.circularFileurl != null &&
                      circularData.circularFileurl!.isNotEmpty)
                    InkWell(
                      borderRadius: BorderRadius.circular(14.r),
                      onTap: () {
                        final url =
                            'https://jsoncompare.org/LearningContainer/SampleFiles/PDF/sample-pdf-download-10-mb.pdf';
                        final fileName = 'sample.pdf';
                        circularController.downloadFile(url, fileName);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColors.appbuttonColor,
                          borderRadius: BorderRadius.circular(14.r),
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.download,
                              size: 16.r,
                              color: AppColors.whitetextcolor,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              'Download',
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
      Positioned(
          top: 0,
          right: 20.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
                color: AppColors.appbuttonColor.withOpacity(0.6),
                border: Border.all(width: 1.w, color: Colors.white),
                borderRadius: BorderRadius.circular(4.r)),
            child: Text(
              "Circular No: ${circularData.cirNo}",
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ))
    ],
  );
}
