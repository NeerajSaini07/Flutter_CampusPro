class StudentActivityModel {
  int? srNo;
  int? id;
  String? title;
  String? dateAdded;
  String? htmlContent;
  String? fileurl;

  StudentActivityModel(
      {this.srNo,
      this.id,
      this.title,
      this.dateAdded,
      this.htmlContent,
      this.fileurl});

  factory StudentActivityModel.fromJson(Map<String, dynamic> json) {
    return StudentActivityModel(
        srNo: json['SrNo'] ?? 0,
        id: json['Id'] ?? 0,
        title: json['Title'] ?? "",
        dateAdded: json['DateAdded'] ?? "",
        htmlContent: json['HtmlContent'] ?? "",
        fileurl: json['CircularFileUrl'] ?? "");
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
