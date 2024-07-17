class UserLogin {
  static List<LoginModel> loginDetails = [];
}

class LoginModel {
  String? validated = "";
  String? validateMessage = "";
  String? oUserid = "";
  String? oUserName = "";
  String? sendOTP = "";
  String? token = "";

  LoginModel(
      {this.validated,
      this.validateMessage,
      this.oUserid,
      this.oUserName,
      this.sendOTP,
      this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    validated = json['Validated'] ?? "";
    validateMessage = json['ValidateMessage'] ?? "";
    oUserid = json['OUserid'] ?? "";
    oUserName = json['OUserName'] ?? "";
    sendOTP = json['SendOTP'] ?? "";
    token = json['Token'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Validated'] = validated;
    data['ValidateMessage'] = validateMessage;
    data['OUserid'] = oUserid;
    data['OUserName'] = oUserName;
    data['SendOTP'] = sendOTP;
    data['Token'] = token;
    return data;
  }
}
