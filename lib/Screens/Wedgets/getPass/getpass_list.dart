// ignore_for_file: sized_box_for_whitespace

import 'package:campuspro/Controllers/getpassController.dart';
import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:campuspro/Utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget shoGetPasslist() {
  final GetPassController getPassController = Get.find<GetPassController>();
  getPassController.getpassHistory();
  return Stack(
    children: [
      Card(
        elevation: 5,
        color: Colors.white,
        child: Container(
          height: 200.h,
          child: FutureBuilder<List<VisitorHistoryModal>>(
            future: getPassController.getpassHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingTextStyle: const TextStyle(color: Colors.white),
                      headingRowColor: MaterialStateProperty.all(
                          AppColors.loginscafoldcoolr),
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Sr No')),
                        DataColumn(label: Text('I Card No')),
                        DataColumn(label: Text('Visitor Image')),
                        DataColumn(label: Text('Visitor Name')),
                        DataColumn(label: Text('Entry Time')),
                        DataColumn(label: Text('Request Status')),
                        DataColumn(label: Text('Exit Time')),
                        DataColumn(label: Text('Number')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: [
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('           No data found')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                            DataCell(Text('')),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingTextStyle: const TextStyle(color: Colors.white),
                      headingRowColor: MaterialStateProperty.all(
                          AppColors.loginscafoldcoolr),
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Sr No')),
                        DataColumn(label: Text('I Card No')),
                        DataColumn(label: Text('Visitor Image')),
                        DataColumn(label: Text('Visitor Name')),
                        DataColumn(label: Text('Entry Time')),
                        DataColumn(label: Text('Request Status')),
                        DataColumn(label: Text('Exit Time')),
                        DataColumn(label: Text('Number')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: List<DataRow>.generate(
                        snapshot.data!.length,
                        (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text((index + 1).toString())),
                            DataCell(Text(
                              snapshot.data![index].iCardNo?.toString() ?? '0',
                            )),
                            DataCell(Container(
                              height: 200.h, // Set desired row height here
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(top: 3),
                                child: Image.network(
                                  snapshot.data![index].visitorImagePath
                                      .toString(),
                                  width: 80, // Set desired width
                                  height: 120, // Set desired height
                                  fit: BoxFit
                                      .cover, // Fit the image within the specified dimensions
                                ),
                              ),
                            )),
                            DataCell(Text(
                                snapshot.data![index].visitorName.toString())),
                            DataCell(Text(
                                snapshot.data![index].entryTime.toString())),
                            DataCell(
                                Text(snapshot.data![index].status.toString())),
                            DataCell(Text(
                                snapshot.data![index].exitTime.toString())),
                            DataCell(
                                Text(snapshot.data![index].number.toString())),
                            snapshot.data![index].exitTime!.isEmpty
                                ? DataCell(GestureDetector(
                                    onTap: () {
                                      getPassController
                                          .markVisitorExitApi(index);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 7.w, horizontal: 7.h),
                                        decoration: BoxDecoration(
                                            color: AppColors.appbuttonColor,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Text(
                                          "Exit",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        )),
                                  ))
                                : DataCell(Text('')),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      Positioned(
        top: -6,
        right: -3,
        child: Card(
          child: GestureDetector(
            onTap: () {
              getPassController.showvisitoryHistory.value = false;
            },
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        ),
      ),
    ],
  );
}
