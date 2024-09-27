class TransportDetailModel {
  static List<Studentinfo> infoDataList = [];
  static List<Pickupinfo> pickinfoDataList = [];
  static List<Dropinfo> dropinfooDataList = [];
}

class Studentinfo {
  String admNo;
  String stName;
  String fatherName;

  Studentinfo(
      {required this.admNo, required this.stName, required this.fatherName});

  factory Studentinfo.fromJson(Map<String, dynamic> json) {
    return Studentinfo(
      admNo: json['ADMNo'],
      stName: json['stName'],
      fatherName: json['fathername'],
    );
  }
}

// Model for Data2
class Pickupinfo {
  String routeName;
  String regNo;
  String driverName;
  String driverMobileNo;
  String conductorName;
  String conductorMobileNo;
  String busNo;

  Pickupinfo({
    required this.routeName,
    required this.regNo,
    required this.driverName,
    required this.driverMobileNo,
    required this.conductorName,
    required this.conductorMobileNo,
    required this.busNo,
  });

  factory Pickupinfo.fromJson(Map<String, dynamic> json) {
    return Pickupinfo(
      routeName: json['RouteName'],
      regNo: json['RegNo'],
      driverName: json['DriverName'],
      driverMobileNo: json['drivermobileno'],
      conductorName: json['conductorname'],
      conductorMobileNo: json['conductormobileno'],
      busNo: json['BusNo'],
    );
  }
}

// Model for Data3
class Dropinfo {
  String routeName;
  String busNo;
  String driverName;
  String driverMobileNo;
  String conductorName;
  String conductorMobileNo;

  Dropinfo({
    required this.routeName,
    required this.busNo,
    required this.driverName,
    required this.driverMobileNo,
    required this.conductorName,
    required this.conductorMobileNo,
  });

  factory Dropinfo.fromJson(Map<String, dynamic> json) {
    return Dropinfo(
      routeName: json['RouteName'],
      busNo: json['BusNo'],
      driverName: json['DriverName'],
      driverMobileNo: json['drivermobileno'],
      conductorName: json['conductorname'],
      conductorMobileNo: json['conductormobileno'],
    );
  }
}
