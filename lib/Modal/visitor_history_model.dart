// ignore_for_file: unnecessary_this

class VisitorHistory {
  static List<VisitorHistoryModal> visitorHistoryListDetails = [];
}

class VisitorHistoryModal {
  int? id;
  String? entryTime;
  String? exitTime;
  String? visitorName;
  String? number;
  String? visitorAddress;
  String? visitorImagePath;
  String? purpose;
  String? status;
  int? iCardNo;
  String? visitorImage;
  String? imageByte;

  VisitorHistoryModal({
    this.id,
    this.entryTime,
    this.exitTime,
    this.visitorName,
    this.number,
    this.visitorAddress,
    this.visitorImagePath,
    this.purpose,
    this.status,
    this.iCardNo,
    this.visitorImage,
    this.imageByte,
  });

  VisitorHistoryModal.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    entryTime = json['EntryTime'];
    exitTime = json['ExitTime'];
    visitorName = json['VisitorName'];
    number = json['Number'];
    visitorAddress = json['VisitorAddress'];
    visitorImagePath = json['VisitorImagePath'];
    purpose = json['Purpose'];
    status = json['Status'];
    iCardNo = json['ICardNo'];
    visitorImage = json['VisitorImage'];
    imageByte = json['ImageByte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = this.id;
    data['EntryTime'] = this.entryTime;
    data['ExitTime'] = this.exitTime;
    data['VisitorName'] = this.visitorName;
    data['Number'] = this.number;
    data['VisitorAddress'] = this.visitorAddress;
    data['VisitorImagePath'] = this.visitorImagePath;
    data['Purpose'] = this.purpose;
    data['Status'] = this.status;
    data['ICardNo'] = this.iCardNo;
    data['VisitorImage'] = this.visitorImage;
    data['ImageByte'] = this.imageByte;
    return data;
  }
}
