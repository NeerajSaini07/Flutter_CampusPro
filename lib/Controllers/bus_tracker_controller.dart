import 'dart:async';
import 'dart:developer';
import 'package:campuspro/Controllers/exception_controller.dart';
import 'package:campuspro/Modal/school_bus_detail_model.dart';
import 'package:campuspro/Modal/school_bus_live_location_model.dart';
import 'package:campuspro/Modal/school_bus_route_model.dart';
import 'package:campuspro/Modal/usertype_model.dart';
import 'package:campuspro/Repository/bus_tracker_repository.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:campuspro/Utilities/routes.dart';
import 'package:campuspro/Utilities/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusTrackerController extends GetxController {
  RxBool isBusAlloted = false.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  RxString busRegNo = 'fetching...'.obs;
  RxString currentAddress = ''.obs;
  late GoogleMapController mapController;
  Timer? timer;

  //Variables Defined//
  final LatLng initialLocation =
      const LatLng(22.665785423912535, 78.292848203125);
  // final LatLng initialLocation = const LatLng(28.7041, 77.1025);

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  //******************* Get Bus Allot Api************************//

  getBusAllot(BuildContext context) async {
    try {
      final usertypeIndex =
          await Sharedprefdata.getIntegerData(Sharedprefdata.userTypeIndex);
      await BusTrackerRepository.checkBusAllotRepo().then((value) {
        if (value != null) {
          log(value.toString());
          if (value["Data"][0]["Flag"] == "YY") {
            isBusAlloted.value = true;
            Get.toNamed(Routes.busTrackerScreen);
          } else if (value["Data"][0]["Flag"] == "YN") {
            if (UserTypeslist.userTypesDetails[usertypeIndex].ouserType!
                        .toLowerCase() ==
                    "s" ||
                UserTypeslist.userTypesDetails[usertypeIndex].ouserType!
                        .toLowerCase() ==
                    "f") {
              //Alert : "Bus is not running at this time"
              Get.dialog(
                const CustomDialog(
                  icon: Icons.warning_amber_rounded,
                  title: "Alert",
                  message: "Bus is not running at this time",
                  btnText: "OK",
                ),
              );
            } else {
              isBusAlloted.value = true;
              Get.toNamed(Routes.busTrackerScreen);
            }
          } else {
            if (UserTypeslist.userTypesDetails[usertypeIndex].ouserType!
                        .toLowerCase() ==
                    "s" ||
                UserTypeslist.userTypesDetails[usertypeIndex].ouserType!
                        .toLowerCase() ==
                    "f") {
              //Alert : "Bus is not assigned"
              Get.dialog(
                const CustomDialog(
                  icon: Icons.warning_amber_rounded,
                  title: "Alert",
                  message: "Bus is not assigned",
                  btnText: "OK",
                ),
              );
            } else {
              isBusAlloted.value = true;
              Get.toNamed(Routes.busTrackerScreen);
            }
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  //******************* Get School Bus Route Api************************//
  getSchoolBusRoute(BuildContext context) async {
    try {
      await BusTrackerRepository.schoolBusRouteRepo().then((value) async {
        if (value != null) {
          log(value.toString());
          List<dynamic> busStopData = value["BusStop"];
          List<dynamic> polylineData = value["BusStop"];
          SchoolBusRouteModel.busStop =
              busStopData.map((json) => BusStopModel.fromJson(json)).toList();
          SchoolBusRouteModel.polyline = polylineData
              .map((json) => BusRoutePolylineModel.fromJson(json))
              .toList();

          Uint8List imageData = await getMarker(context, Constant.busMarker);
          //School Details
          if (context.mounted) {
            await getSchoolBusDetails(context);
          }

          //This is marker drawing part

          if (SchoolBusRouteModel.busStop != null) {
            for (var element in SchoolBusRouteModel.busStop!) {
              if (element.lattitude != null &&
                  element.longitude != null &&
                  element.lattitude != "" &&
                  element.longitude != "") {
                markers.add(Marker(
                  markerId: MarkerId(element.stopName ?? ""),
                  position: LatLng(double.parse(element.lattitude!),
                      double.parse(element.longitude!)),
                  infoWindow: InfoWindow(
                    title: element.stopName,
                    snippet: 'School Bus Stop',
                  ),
                  icon: BitmapDescriptor.fromBytes(imageData),
                ));
              }
            }
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  //******************* Get Current Location ************************//

  Future<void> getCurrentLocation(BuildContext context, String? vehicleNumber,
      String? trackingDeviceIMEI) async {
    try {
      Uint8List imageData = await getMarker(context, Constant.busIcon);
      var location = const LatLng(28.7041, 77.1025);
      if (context.mounted) {
        updateMarkerAndCircle(context, location.latitude, location.longitude,
            "192", imageData, []);
        fetchSchoolBusLiveLocation(
            context, vehicleNumber, trackingDeviceIMEI, imageData);
      }
      timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
        if (context.mounted) {
          fetchSchoolBusLiveLocation(
              context, vehicleNumber, trackingDeviceIMEI, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  //******************* Update Marker ************************//

  Future<void> updateMarkerAndCircle(
      BuildContext context,
      double latitude,
      double longitude,
      String? direction,
      Uint8List imageData,
      List<OtherBusesModel>? otherBuses) async {
    LatLng latlng = LatLng(latitude, longitude);
    Uint8List imageDataNew = await getMarker(context, Constant.busMarker);

    markers.clear();
    markers.add(Marker(
      markerId: const MarkerId("live_location"),
      position: latlng,
      rotation:
          direction != "" && direction != null ? double.parse(direction) : 192,
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: const Offset(0.5, 0.5),
      icon: BitmapDescriptor.fromBytes(imageData),
    ));

    if (otherBuses != null && otherBuses.isNotEmpty) {
      for (int i = 0; i < otherBuses.length; i++) {
        LatLng latLng = LatLng(double.parse(otherBuses[i].lattitude ?? '0'),
            double.parse(otherBuses[i].longitude ?? '0'));
        markers.add(Marker(
          markerId: MarkerId("home$i"),
          position: latLng,
          rotation: otherBuses[i].orientation != "" &&
                  otherBuses[i].orientation != null
              ? double.parse(otherBuses[i].orientation!)
              : 192,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageDataNew),
          infoWindow: InfoWindow(
            title: "${otherBuses[i].vehicleNumber}",
            snippet: "Bus",
          ),
        ));
      }
    }
  }

  //******************* Fetch Bus Location Api************************//
  Future<void> fetchSchoolBusLiveLocation(
      BuildContext context,
      String? vehicleNumber,
      String? trackingDeviceIMEI,
      Uint8List imageData) async {
    try {
      await BusTrackerRepository.schoolBusLiveLocationRepo(
              vehicleNumber, trackingDeviceIMEI)
          .then((value) {
        if (value != null) {
          log(value.toString());
          SchoolBusLiveLocationModel.vehicleNumber =
              value["Data"][0]["Vehicle_number"];
          SchoolBusLiveLocationModel.latitude = value["Data"][0]["Latitude"];
          SchoolBusLiveLocationModel.longitude = value["Data"][0]["Longitude"];
          SchoolBusLiveLocationModel.address = value["Data"][0]["address"];
          SchoolBusLiveLocationModel.orientation =
              value["Data"][0]["orientation"];
          List<dynamic> otherBuses = value["Data"][0]["OtherBuses"];
          SchoolBusLiveLocationModel.otherBuses =
              otherBuses.map((json) => OtherBusesModel.fromJson(json)).toList();
          try {
            mapController
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(
                  double.parse(SchoolBusLiveLocationModel.latitude ?? "0"),
                  double.parse(SchoolBusLiveLocationModel.longitude ?? "0")),
              tilt: 0,
              zoom: 17.0,
            )));
            updateMarkerAndCircle(
                context,
                double.parse(SchoolBusLiveLocationModel.latitude ?? "0"),
                double.parse(SchoolBusLiveLocationModel.longitude ?? "0"),
                SchoolBusLiveLocationModel.orientation!,
                imageData,
                SchoolBusLiveLocationModel.otherBuses);

            busRegNo.value = SchoolBusLiveLocationModel.vehicleNumber!
                .replaceAll(' ', '')
                .toUpperCase();
            currentAddress.value = SchoolBusLiveLocationModel.address ?? "";
          } catch (error) {
            busRegNo.value = "fetching...";
            currentAddress.value = SchoolBusLiveLocationModel.address ?? "";
          }
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  //******************* Get Bus Detail Api************************//
  getSchoolBusDetails(BuildContext context) async {
    try {
      await BusTrackerRepository.schoolBusDetailRepo().then((value) {
        if (value != null) {
          log(value.toString());
          List<dynamic> schoolBusDetail = value["Data"][0];
          SchoolBusDetailModel.schoolDetailList = schoolBusDetail
              .map((json) => SchoolBusDetailListModel.fromJson(json))
              .toList();

          //Current Location
          getCurrentLocation(
              context,
              SchoolBusDetailModel.schoolDetailList!.first.busNo!
                  .replaceAll(' ', '')
                  .toUpperCase(),
              SchoolBusDetailModel.schoolDetailList!.first.trackingDeviceIMEI);
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  //Markers
  Future<Uint8List> getMarker(BuildContext context, String image) async {
    ByteData byteData = await DefaultAssetBundle.of(context).load(image);
    return byteData.buffer.asUint8List();
  }
}
