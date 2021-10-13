import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:ucms/data/dto/move_request_dto.dart';
import 'package:ucms/data/hostnames.dart';
import 'package:ucms/notification/noti_manager.dart';
import 'package:ucms/pages/page_user/user_assemble.dart';
import 'package:ucms/utils/snackbar.dart';

class UserSocketClient extends GetxService {
  var prefs = GetStorage();
  late socket_io.Socket socket;

  void startSocket() {
    socket = Get.put(socket_io.io(socketHost, <String, dynamic>{
            'transports': ['websocket'],
            'Authorization' : "Bearer ${prefs.read("token")}"
      }));
    debugPrint("Socket on");
    socket.connect();

    socket.onConnect((_) {});

    socket.on("move_approval", (_) async {
      //TODO:  impelment

      NotiManager n = Get.find<NotiManager>();

      await n.flutterLocalNotificationsPlugin.show(
    1,"test", "testBody",n.platformChannelSpecifics);
    });

    socket.on("facility_approval", (_){
      //TODO:  impelment
    });

    socket.on("assemble_command", (data) {
      dynamic json = jsonDecode(utf8.decode(data));
      
      prefs.write("assemble_location", json["beacon_id"]);
      prefs.write("assemble_visible",true);
      debugPrint("assemble");
      Get.to(UserAssemble(location: prefs.read("assemble_location")));
      Snack.warnTop("소집 지시", "소집 지시가 내려왔습니다.");
    });
    socket.on("to_cohort", (data) {
      dynamic json = jsonDecode(utf8.decode(data));
      bool flag =false;
      String tag = prefs.read("tag");
      for(int i=0; i<json["tag"].length;i++) {
        if(json["tag"][i]==tag) {
          flag =true;
          break;
        }
      }
      if(flag) {
        
      }
    });
    socket.on("to_normal", (_) {
      //TODO:  impelment
    });
  }

  void moveRequest({required String destination}) {
    MoveRequestDto dto = MoveRequestDto(destination: destination);
    socket.emit("move_request", dto.toJson());
    //TODO : outside_id 로 바꿔야 함.
  }

  void getIn() {
    //TODO : impelment
    //beacon_id
  }

  void getOut() {
    //TODO : impelment 
    //beacon_id
  }

  void locationReport({required String macAddress, required String scanTime}) {
    startSocket();
    Map<String, dynamic> json = {
      "tag": prefs.read("tag"),
      "beacon_id": macAddress,
      "time": scanTime,
    };

    socket.emit("location_report", json);
  }

  void cannotAssemble({required String description}) {
    startSocket();
    Map<String, dynamic> json = {
      "tag": prefs.read("tag"),
      "description" : description
    };

    socket.emit("cannot_assemble", json);
  }
}
