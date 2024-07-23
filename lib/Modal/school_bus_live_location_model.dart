class SchoolBusLiveLocationModel {
  static int? vId = 0;
  static String? vehicleNumber = '';
  static String? deviceId = '';
  static String? cordinate = '';
  static String? address = '';
  static String? city = '';
  static String? state = '';
  static String? motionStatus = '';
  static String? motionState = '';
  static String? speed = '';
  static String? shareLink = '';
  static String? latitude = '';
  static String? longitude = '';
  static String? orientation = '';
  static List<OtherBusesModel>? otherBuses = [];

  SchoolBusLiveLocationModel({
    vId,
    vehicleNumber,
    deviceId,
    cordinate,
    address,
    city,
    state,
    motionStatus,
    motionState,
    speed,
    shareLink,
    latitude,
    longitude,
    orientation,
    otherBuses,
  });

  SchoolBusLiveLocationModel.fromJson(Map<String, dynamic> json) {
    vId = json['VId'] ?? -1;
    vehicleNumber = json['Vehicle_number'] ?? "";
    deviceId = json['device_id'] ?? "";
    cordinate = json['cordinate'] ?? "";
    address = json['address'] ?? "";
    city = json['city'] ?? "";
    state = json['state'] ?? "";
    motionStatus = json['motion_status'] ?? "";
    motionState = json['motion_state'] ?? "";
    speed = json['speed'] ?? "";
    shareLink = json['share_link'] ?? "";
    latitude = json['Latitude'] ?? "";
    longitude = json['Longitude'] ?? "";
    orientation = json['orientation'] ?? "";
    otherBuses = json["OtherBuses"] ?? [];
    if (json['OtherBuses'] != null) {
      otherBuses = <OtherBusesModel>[];
      json['BusStop'].forEach((v) {
        otherBuses!.add(OtherBusesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['VId'] = vId;
    data['vehicle_number'] = vehicleNumber;
    data['device_id'] = deviceId;
    data['cordinate'] = cordinate;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['motion_status'] = motionStatus;
    data['motion_state'] = motionState;
    data['speed'] = speed;
    data['share_link'] = shareLink;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['orientation'] = orientation;
    return data;
  }
}

class OtherBusesModel {
  String? vehicleNumber = '';
  String? lattitude = '';
  String? longitude = '';
  String? address = '';
  String? orientation = '';

  OtherBusesModel(
      {this.vehicleNumber,
      this.lattitude,
      this.longitude,
      this.address,
      this.orientation});

  OtherBusesModel.fromJson(Map<String, dynamic> json) {
    vehicleNumber = json['vehicle_number'];
    lattitude = json['Lattitude'];
    longitude = json['Longitude'];
    address = json['address'];
    orientation = json['orientation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vehicle_number'] = vehicleNumber;
    data['Lattitude'] = lattitude;
    data['Longitude'] = longitude;
    data['address'] = address;
    data['orientation'] = orientation;
    return data;
  }
}
