// import 'dart:async';
// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:ucms/data/beacon_result.dart';
// import 'package:ucms/socket/socket.dart';
// import 'dart:io' show Platform;
// import 'package:beacons_plugin/beacons_plugin.dart';

// class BeaconManager extends GetxService {
//   BeaconManager() {
//     initPlatformState();
//   }

//   late BeaconResult beaconResult;
//   var isRunning = false;
//   //UserSocketClient socket = Get.find<UserSocketClient>();
//   final StreamController<String> beaconEventsController = StreamController<String>.broadcast();

// void startListeningBeacons() {
//   BeaconsPlugin.listenToBeacons(beaconEventsController);
// }

// Future<void> initPlatformState() async {
//     if (Platform.isAndroid) {
//       await BeaconsPlugin.setDisclosureDialogMessage(
//         title: "Need Location Permission",
//         message: "This app collects location data to work with beacons."
//       );
//     }

//     await BeaconsPlugin.addRegion("testBeacon", "74278BDA-B644-4520-8F0C-720EAF059935");// iBeacon uuid 등록
    
//     BeaconsPlugin.setForegroundScanPeriodForAndroid(foregroundScanPeriod: 1000, foregroundBetweenScanPeriod: 10);
//     BeaconsPlugin.setBackgroundScanPeriodForAndroid( backgroundScanPeriod: 1000, backgroundBetweenScanPeriod: 10);
//     await BeaconsPlugin.runInBackground(true);

//     if (Platform.isAndroid) {
//       BeaconsPlugin.channel.setMethodCallHandler((call) async {
//         if (call.method == 'scannerReady') {
//           await BeaconsPlugin.startMonitoring();
//             isRunning = true;
//         }
//       });
//     } else if (Platform.isIOS) {
//       await BeaconsPlugin.startMonitoring();
//         isRunning = true;
//     }

//     startListeningBeacons();

//     beaconEventsController.stream.listen((data) {
//       if (data.isNotEmpty && isRunning) {
//           beaconResult = BeaconResult.fromJson(jsonDecode(data));
//         }
//       }, onDone: () {}, onError: (error) {/*print("Error: $error");*/});
//   }
// }