class UploadDocumentTypeList {
  static List<UploadDocumentTypeModel> uploadDocumentTypeList = [];
}

class UploadDocumentTypeModel {
  int? docId;
  String? docName;
  UploadDocumentTypeModel({this.docId, this.docName});

  UploadDocumentTypeModel.fromJson(Map<String, dynamic> json) {
    docId = json['DocId'] ?? 0;
    docName = json['DocName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DocId'] = docId;
    data['DocName'] = docName;
    return data;
  }
}
