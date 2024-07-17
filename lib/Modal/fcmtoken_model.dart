class FcmTokenList {
  static List<FcmTokeModel> tokenlist = [];
}

class FcmTokeModel {
  String? token = "";
  String? erpDomainName = "";

  FcmTokeModel({this.erpDomainName, this.token});

  FcmTokeModel.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    erpDomainName = json['ERPDomainName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    data['ERPDomainName'] = erpDomainName;
    return data;
  }
}
