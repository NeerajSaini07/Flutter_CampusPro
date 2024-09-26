class FeedbackM{
  static List<FeedbackModel> feedbackList =[];
}

class FeedbackModel {
  String? type; 
  String? topic;
  String? subject;
  String? detail;
  String? readStatus;
  String? adminRemarks;
  String? tranDate;

  FeedbackModel({
    this.type,
    this.topic,
    this.subject,
    this.detail,
    this.readStatus,
    this.adminRemarks,
    this.tranDate,
  });

  // Factory method to create an instance from a JSON map
  FeedbackModel.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    topic = json['C_STopic'];
    subject = json['C_SSubject'];
    detail = json['C_SDetail'];
    readStatus = json['ReadStatus'];
    adminRemarks = json['AdminRemarks'];
    tranDate = json['TranDate'];
  }

  // Method to convert the instance into a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type'] = type;
    data['C_STopic'] = topic;
    data['C_SSubject'] = subject;
    data['C_SDetail'] = detail;
    data['ReadStatus'] = readStatus;
    data['AdminRemarks'] = adminRemarks;
    data['TranDate'] = tranDate;

    return data;
  }
}
