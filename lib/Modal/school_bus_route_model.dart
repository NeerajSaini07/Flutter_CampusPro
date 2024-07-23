class SchoolBusRouteModel {
  static List<BusStopModel>? busStop = [];
  static List<BusRoutePolylineModel>? polyline = [];

  SchoolBusRouteModel({busStop, polyline});

  SchoolBusRouteModel.fromJson(Map<String, dynamic> json) {
    if (json['BusStop'] != null) {
      busStop = <BusStopModel>[];
      json['BusStop'].forEach((v) {
        busStop!.add(BusStopModel.fromJson(v));
      });
    }
    if (json['Polyline'] != null) {
      polyline = <BusRoutePolylineModel>[];
      json['Polyline'].forEach((v) {
        polyline!.add(BusRoutePolylineModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (busStop != null) {
      data['BusStop'] = busStop!.map((v) => v.toJson()).toList();
    }
    if (polyline != null) {
      data['Polyline'] = polyline!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusStopModel {
  String? stopName = '';
  String? lattitude = '';
  String? longitude = '';

  BusStopModel({this.stopName, this.lattitude, this.longitude});

  BusStopModel.fromJson(Map<String, dynamic> json) {
    stopName = json['StopName'];
    lattitude = json['Lattitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StopName'] = stopName;
    data['Lattitude'] = lattitude;
    data['Longitude'] = longitude;
    return data;
  }
}

class BusRoutePolylineModel {
  double? lat = 0;
  double? lng = 0;

  BusRoutePolylineModel({this.lat, this.lng});

  BusRoutePolylineModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
