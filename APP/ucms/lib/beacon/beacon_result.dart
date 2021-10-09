import 'package:get/get.dart';

class BeaconResult extends GetxService {
  late String name;
  late String uuid;
  late String macAddress;
  late int major;
  late int minor;
  late double distance;
  late String proximity;
  late String scanTime;
  late int rssi;
  late int txPower;

  BeaconResult({
    required this.name,
    required this.uuid,
    required this.macAddress,
    required this.major,
    required this.minor,
    required this.distance,
    required this.proximity,
    required this.scanTime,
    required this.rssi,
    required this.txPower
    });

  BeaconResult.fromJson(Map<String,dynamic> json) {
    name =json["name"];
    uuid =json["uuid"];
    macAddress = json["macAddress"];
    major = json["major"];
    minor = json["minor"];
    distance = json["distance"];
    proximity = json["proximity"];
    scanTime = json["scanTime"];
    rssi = json["rssi"];
    txPower = json["txPower"];
  }

}
// data 구조
// {
//   "name": "testBeacon",
//   "uuid": "74278bda-b644-4520-8f0c-720eaf059935",
//   "macAddress": "34:14:B5:41:A2:7E", <- uuid가 아닌 mac주소로 비콘 구분
//   "major": "4660",
//   "minor": "64001",
//   "distance": "0.32",
//   "proximity": "Immediate",
//   "scanTime": "02 October 2021 01:10:10 PM",
//   "rssi": "-47",
//   "txPower": "-59"
// }