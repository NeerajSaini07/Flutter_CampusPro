class WebUrlList {
  static List<WebUrlModel> urlListProperties = [];
}

class WebUrlModel {
  String? url = "";
  String? pageName = "";

  WebUrlModel({this.url, this.pageName});

  WebUrlModel.fromJson(Map<String, dynamic> json) {
    url = json['Url'];
    pageName = json['PageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Url'] = url;
    data['PageName'] = pageName;
    return data;
  }
}
