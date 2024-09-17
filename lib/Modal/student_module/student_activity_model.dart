import 'package:get/get_rx/src/rx_types/rx_types.dart';

class StudentActivityModel {
  int? srNo;
  int? id;
  String? title;
  String? dateAdded;
  String? htmlContent;
  String? fileurl;
  //to show downloading status
  RxBool? isDownloaded = false.obs;

  StudentActivityModel(
      {this.srNo,
      this.id,
      this.title,
      this.dateAdded,
      this.htmlContent,
      this.fileurl,
      this.isDownloaded});

  factory StudentActivityModel.fromJson(Map<String, dynamic> json) {
    return StudentActivityModel(
      srNo: json['SrNo'] ?? 0,
      id: json['Id'] ?? 0,
      title: json['Title'] ?? "",
      dateAdded: json['DateAdded'] ?? "",
      htmlContent: json['HtmlContent'] ?? "",
      fileurl: json['CircularFileUrl'] ?? "",
      isDownloaded: false.obs,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SrNo'] = srNo;
    data['Id'] = id;
    data['Title'] = title;
    data['DateAdded'] = dateAdded;
    data['HtmlContent'] = htmlContent;
    data['CircularFileUrl'] = fileurl;
    return data;
  }
}
