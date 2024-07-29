// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';

// class LocationController extends GetxController {
//   late LocationSettings locationSettings;
//   StreamSubscription<Position>? positionStreamSubscription;
//   RxString currentPosition = 'Unknown'.obs;

//   Future<void> checkPermissions() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//   }

//   void initLocationSettings() {
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       locationSettings = AndroidSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 100,
//         forceLocationManager: true,
//         intervalDuration: const Duration(seconds: 10),
//         foregroundNotificationConfig: const ForegroundNotificationConfig(
//           notificationText:
//               "Example app will continue to receive your location even when you aren't using it",
//           notificationTitle: "Running in Background",
//           enableWakeLock: true,
//         ),
//       );
//     } else if (defaultTargetPlatform == TargetPlatform.iOS ||
//         defaultTargetPlatform == TargetPlatform.macOS) {
//       locationSettings = AppleSettings(
//         accuracy: LocationAccuracy.high,
//         activityType: ActivityType.fitness,
//         distanceFilter: 100,
//         pauseLocationUpdatesAutomatically: true,
//         showBackgroundLocationIndicator: false,
//       );
//     } else {
//       locationSettings = const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 100,
//       );
//     }
//   }

//   Future<void> startListeningToLocation() async {
//     try {
//       await checkPermissions();
//       initLocationSettings();
//       positionStreamSubscription =
//           Geolocator.getPositionStream(locationSettings: locationSettings)
//               .listen(
//         (Position? position) {
//           if (position != null) {
//             currentPosition.value =
//                 '${position.latitude}, ${position.longitude}';
//           } else {
//             currentPosition.value = 'Position is unknown';
//           }
//         },
//       );
//     } catch (e) {
//       currentPosition.value = 'Error: $e';
//     }
//   }

//   void stopListeningToLocation() {
//     positionStreamSubscription?.cancel();
//   }
// }
