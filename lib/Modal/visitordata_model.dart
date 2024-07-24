// ignore_for_file: unnecessary_this

class VisitorData {
  static List<VisitorDataModel> visitorListDetails = [];
}

class VisitorDataModel {
  String? name;
  String? address;
  String? imagePath;
  String? visitorId;
  String? visitorImage;
  String? isOtpSent;
  String? imageByte;

  VisitorDataModel(
      {this.name,
      this.address,
      this.imagePath,
      this.visitorId,
      this.visitorImage,
      this.isOtpSent,
      this.imageByte});

  VisitorDataModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    address = json['Address'];
    imagePath = json['ImagePath'];
    visitorId = json['VisitorId'];
    visitorImage = json['VisitorImage'];
    isOtpSent = json['IsOtpSent'];
    imageByte = json['ImageByte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['ImagePath'] = this.imagePath;
    data['VisitorId'] = this.visitorId;
    data['VisitorImage'] = this.visitorImage;
    data['IsOtpSent'] = this.isOtpSent;
    data['ImageByte'] = this.imageByte;
    return data;
  }
}
