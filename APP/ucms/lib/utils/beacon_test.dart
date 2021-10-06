// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:ucms/components/custom_screen.dart';
// import 'package:ucms/components/texts.dart';

// import 'package:beacons_plugin/beacons_plugin.dart';
// import 'package:flutter/material.dart';
// import 'dart:io' show Platform;

// import 'package:ucms/socket/socket.dart';

// class BeaconTest extends StatefulWidget {
//   const BeaconTest({Key? key}) : super(key: key);

//   @override
//   State<BeaconTest> createState() => _BeaconTestState();
// }

// class _BeaconTestState extends State<BeaconTest> {
//   String _beaconResult = "";
//   var isRunning = false;
//   UserSocketClient  socket = Get.find<UserSocketClient>();

//   final StreamController<String> beaconEventsController = StreamController<String>.broadcast();

//   Future<void> initPlatformState() async {
//     if (Platform.isAndroid) {
//       await BeaconsPlugin.setDisclosureDialogMessage(
//         title: "Need Location Permission",
//         message: "This app collects location data to work with beacons."
//       );
//     }

//     BeaconsPlugin.listenToBeacons(beaconEventsController);

//     // iBeacon uuid 등록
//     await BeaconsPlugin.addRegion(
//         "testBeacon", "74278BDA-B644-4520-8F0C-720EAF059935");
    
//     BeaconsPlugin.setForegroundScanPeriodForAndroid(
//         foregroundScanPeriod: 1000, foregroundBetweenScanPeriod: 10);

//     BeaconsPlugin.setBackgroundScanPeriodForAndroid(
//         backgroundScanPeriod: 1000, backgroundBetweenScanPeriod: 10);

//     beaconEventsController.stream.listen((data) {
//       if (data.isNotEmpty && isRunning) {
//         setState(() {
//           _beaconResult = data;
//         });
//         //print(data);
        
//         // data 구조
//         // {
//         //   "name": "testBeacon",
//         //   "uuid": "74278bda-b644-4520-8f0c-720eaf059935",
//         //   "macAddress": "34:14:B5:41:A2:7E", <- uuid가 아닌 mac주소로 비콘 구분
//         //   "major": "4660",
//         //   "minor": "64001",
//         //   "distance": "0.32",
//         //   "proximity": "Immediate",
//         //   "scanTime": "02 October 2021 01:10:10 PM",
//         //   "rssi": "-47",
//         //   "txPower": "-59"
//         // }
//       }
//     }, onDone: () {}, onError: (error) {print("Error: $error");});

//     await BeaconsPlugin.runInBackground(true);

//     if (Platform.isAndroid) {
//       BeaconsPlugin.channel.setMethodCallHandler((call) async {
//         if (call.method == 'scannerReady') {
//           await BeaconsPlugin.startMonitoring();
//           setState(() {
//             isRunning = true;
//           });
//         }
//       });
//     } else if (Platform.isIOS) {
//       await BeaconsPlugin.startMonitoring();
//       setState(() {
//         isRunning = true;
//       });
//     }

//     if (!mounted) return;
//   }


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: KScreen(
//         child: ListView(
//           children: [
//             const SizedBox(height: 100),
//             title("비콘 테스트"),
//             const SizedBox(height: 20),
//             Text(_beaconResult),
//             ElevatedButton(
//               onPressed: () async {
//                 if (isRunning) {
//                   await BeaconsPlugin.stopMonitoring();
//                 } else {
//                   initPlatformState();
//                   await BeaconsPlugin.startMonitoring();
//                 }
//                 setState(() {
//                   isRunning = !isRunning;
//                 });
//               },
//               child:
//                 Text(isRunning ? 'Stop Scanning' : 'Start Scanning',
//                 style: const TextStyle(fontSize: 20)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
