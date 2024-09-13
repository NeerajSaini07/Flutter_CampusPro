class NotificationList {
  static List<NotificationModel> notificationList = [];
}

class NotificationModel {
  int? smsId;
  String? smsType = "";
  String? alertDate = "";
  String? alertMessage = "";
  String? sortDate = "";
  late bool isSeen;

  NotificationModel({
    this.smsId,
    this.smsType,
    this.alertDate,
    this.alertMessage,
    this.sortDate,
    this.isSeen = false,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    smsId = json['SmsId'];
    smsType = json['SmsType'] ?? "";
    alertDate = json['AlertDate'] ?? "";
    alertMessage = json['AlertMessage'] ?? "";
    sortDate = json['SortDate'] ?? "";
    isSeen = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SmsId'] = smsId;
    data['SmsType'] = smsType;
    data['AlertDate'] = alertDate;
    data['AlertMessage'] = alertMessage;
    data['SortDate'] = sortDate;
    return data;
  }
}
