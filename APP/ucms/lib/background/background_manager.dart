// import 'dart:async';

// import 'package:get/get.dart';
// import 'package:ucms/socket/user_socket_client.dart';
// import 'package:ucms/beacon/beacon_manager.dart';
// import 'package:workmanager/workmanager.dart';

// class BackgroundManager extends GetxService {
//   Workmanager man = Workmanager();

  

//   void callbackDispatcher() {
//     man.executeTask((task, inputData) async {
//       switch (task) {
//         case "refresh_beacon": //각 task 분류해두기.
//           {
//             var beaconMan = Get.find<BeaconManager>();
//             var socketClient = Get.find<UserSocketClient>();
//             var beaconResult = beaconMan.beaconResult;
//             int min15 = 900;

//             beaconMan.startListeningBeacons();
//             Timer.periodic(const Duration(minutes: 2), (timer) {
//               if (min15 >= 0) {
//                 socketClient.locationReport(
//                     macAddress: beaconResult.macAddress,
//                     scanTime: beaconResult.scanTime);
//                 min15 -= 120;
//               } else {
//                 timer.cancel();
//               }
//             });
//           }
//           break;
//       }
//       return Future.value(true);
//     });
//   }
// }
