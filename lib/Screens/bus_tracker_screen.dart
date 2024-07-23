import 'package:campuspro/Controllers/bus_tracker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class BusTrackerScreen extends StatelessWidget {
  const BusTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BusTrackerController busTrackerController =
        Get.find<BusTrackerController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      busTrackerController.getSchoolBusRoute(context);
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bus Tracker"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (busTrackerController.markers.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            children: [
              GoogleMap(
                polylines: busTrackerController.polylines.toSet(),
                markers: busTrackerController.markers.toSet(),
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  busTrackerController.mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: busTrackerController.initialLocation,
                  zoom: 17,
                ),
                buildingsEnabled: true,
                zoomGesturesEnabled: true,
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            busTrackerController.busRegNo.value,
                            textScaler: TextScaler.noScaling,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.green,
                            highlightColor: Colors.grey[100]!,
                            enabled: true,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 6.0,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "Live",
                                  textScaler: TextScaler.noScaling,
                                  style: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }
          // FutureBuilder(
          //   future: busTrackerController.getSchoolBusRoute(context),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (snapshot.connectionState == ConnectionState.done) {
          //       return GoogleMap(
          //         polylines: busTrackerController.polylines,
          //         markers: busTrackerController.markers,
          //         // circles: ,
          //         zoomControlsEnabled: false,
          //         onMapCreated: (GoogleMapController controller) {
          //           busTrackerController.mapController = controller;
          //         },
          //         initialCameraPosition: const CameraPosition(
          //             target: LatLng(28.7041, 77.1025), zoom: 17),
          //         buildingsEnabled: true,
          //         //minMaxZoomPreference: MinMaxZoomPreference(100, 2000),
          //         zoomGesturesEnabled: true,
          //         mapType: MapType.normal,
          //         myLocationEnabled: true,
          //         compassEnabled: true,
          //         // trafficEnabled: true,
          //       );
          //     } else {
          //       return Padding(
          //         padding: EdgeInsets.only(bottom: 20.h),
          //         child: Center(
          //             child: Lottie.asset('assets/lottie_json/no_data.json',
          //                 height: MediaQuery.sizeOf(context).height * 0.3)),
          //       );
          //     }
          //   },
          // ),
          ),
    );
  }

  // GoogleMap buildGoogleMaps(
  //     BuildContext context, BusTrackerController busTrackerController) {
  //   return
  // }

  void _onMapCreated(GoogleMapController controllerParam) async {
    final BusTrackerController busTrackerController =
        Get.find<BusTrackerController>();
    busTrackerController.mapController = controllerParam;
    // Uint8List imageData = await getMarker();

    // print("marker length${markersList.length}");
    // markersList.forEach((element) {
    //   print("markersList items 2 => ${element.stopName}");
    // });

    // _polyline.add(Polyline(
    //   polylineId: PolylineId('Pickup'),
    //   visible: true,
    //   points: polyList,
    //   width: 4,
    //   color: Colors.black,
    // ));
  }
}
