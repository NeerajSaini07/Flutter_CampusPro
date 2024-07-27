import 'package:campuspro/Modal/visitor_history_model.dart';
import 'package:flutter/material.dart';

Widget historyData(index) {
  return DataTable(
    headingRowHeight: 0, // Hide the heading row
    columns: const <DataColumn>[
      DataColumn(label: SizedBox.shrink()), // Empty DataColumn
      DataColumn(label: SizedBox.shrink()),
      DataColumn(label: SizedBox.shrink()),
      DataColumn(label: SizedBox.shrink()),
      DataColumn(label: SizedBox.shrink()),
      DataColumn(label: SizedBox.shrink()),
      DataColumn(label: SizedBox.shrink()),
      DataColumn(label: SizedBox.shrink()),
    ],
    rows: [
      DataRow(
        cells: <DataCell>[
          DataCell(Text((index + 1).toString())),
          DataCell(Text(VisitorHistory.visitorHistoryListDetails[index].iCardNo
              .toString())),
          DataCell(Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Image.network(
                VisitorHistory.visitorHistoryListDetails[index].visitorImagePath
                    .toString(),
                width: 70, // Set desired width
                height: 100, // Set desired height
                fit: BoxFit
                    .cover, // Fit the image within the specified dimensions
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  print("comming here");
                  // Handle image loading errors and show a default image
                  return Image.asset(
                      'assets/icon/person_icon.png'); // Default image
                },
              ),
            ),
          )),
          DataCell(Text(VisitorHistory
              .visitorHistoryListDetails[index].visitorName
              .toString())),
          DataCell(Text(VisitorHistory
              .visitorHistoryListDetails[index].entryTime
              .toString())),
          DataCell(Text(VisitorHistory.visitorHistoryListDetails[index].status
              .toString())),
          DataCell(Text(VisitorHistory.visitorHistoryListDetails[index].exitTime
              .toString())),
          DataCell(Text(VisitorHistory.visitorHistoryListDetails[index].number
              .toString())),
        ],
      ),
    ],
  );
}
