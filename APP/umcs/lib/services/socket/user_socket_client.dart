import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:umcs/model/dto/move_request_dto.dart';
import 'package:umcs/model/hostnames.dart';
import 'package:umcs/services/notification/noti_manager.dart';
import 'package:umcs/views/cohort/cohort_main.dart';
import 'package:umcs/views/user/user_assemble.dart';
import 'package:umcs/views/user/user_main.dart';
import 'package:umcs/controllers/cohort_controller.dart';
import 'package:umcs/controllers/place_controller.dart';
import 'package:umcs/utils/snackbar.dart';
import 'package:umcs/controllers/user_controller.dart';

class UserSocketClient extends GetxService {
  var prefs = GetStorage();
  late socket_io.Socket socket;

  void startSocket(String token) {
    socket = Get.put(socket_io.io(
        socketHost,
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setQuery({'token': 'Bearer $token'})
            .build()));
    socket.connect();

    socket.onConnect((_) {});

    //LISTEN
    socket.on("move_approval", (_) async {
      NotiManager n = Get.find<NotiManager>();

      await n.flutterLocalNotificationsPlugin
          .show(1, "test", "testBody", n.platformChannelSpecifics);
    });

    socket.on("facility_approval", (data) {
      //dynamic json = jsonDecode(utf8.decode(data));
    });

    socket.on("assemble_command", (data) {
      dynamic json = jsonDecode(utf8.decode(data));

      prefs.write("assemble_location", json["beacon_id"]);
      prefs.write("assemble_visible", true);
      debugPrint("assemble arrived");
      Get.to(UserAssemble(location: prefs.read("assemble_location")));
      Snack.warnTop("소집 지시", "소집 지시가 내려왔습니다.");
    });

    socket.on("to_cohort", (data) async {
      dynamic json = jsonDecode(utf8.decode(data));
      bool flag = false;
      String tag = prefs.read("tag");
      for (int i = 0; i < json["tag"].length; i++) {
        if (json["tag"][i] == tag) {
          flag = true;
          break;
        }
      }
      if (flag) {
        GetStorage store = GetStorage();
        UserController u = Get.find<UserController>();
        PlaceController p = Get.find<PlaceController>();
        store.writeIfNull("state", "정상");

        await u.currentPosition(store.read("tag"));
        await p.positionAllInfo();
        CohortController c = Get.find<CohortController>();
        await c.timeTableAllInfo();

        Snack.top("로그인 시도", "성공");
        Get.to(CohortMain(
          location: store.read("recent_place_name") ?? "error in LoginPage",
          state: store.read("state") ?? "",
        ));
      }
    });

    socket.on("to_normal", (_) async {
      GetStorage store = GetStorage();
      UserController u = Get.find<UserController>();
      store.write("state", "정상");

      await u.currentPosition(store.read("recent_place_name"));

      Get.to(UserMain(
        location: store.read("recent_place_name"),
        state: store.read("state"),
      ));
      Snack.top("평시로 전환", "코호트 상황이 풀렸습니다.");
    });

    socket.on("contact_alert", (_) {
      Snack.warnTop("접촉 경고", "코호트 대상자와 접촉하였습니다.");
    });
  }

  //EMIT
  void cannotAssemble({required String description}) {
    startSocket(prefs.read("token"));
    Map<String, dynamic> json = {
      "tag": prefs.read("tag"),
      "description": description
    };

    socket.emit("cannot_assemble", json);
  }

  @Deprecated("this emit is absorbed by method locationReport")
  void getIn({required String macAddress}) {
    startSocket(prefs.read("token"));
    Map<String, dynamic> json = {
      "beacon_id": macAddress,
    };

    socket.emit("get_in", json);
  }

  @Deprecated("this emit is absorbed by method locationReport")
  void getOut({required String macAddress}) {
    startSocket(prefs.read("token"));
    Map<String, dynamic> json = {
      "beacon_id": macAddress,
    };

    socket.emit("get_out", json);
  }

  void moveRequest({required String outsideId, required String desc}) {
    MoveRequestDto dto =
        MoveRequestDto(outsideId: outsideId, description: desc);
    socket.emit("move_request", dto.toJson());
  }

  void facilityRequest({required String outsideId, required String desc}) {
    MoveRequestDto dto =
        MoveRequestDto(outsideId: outsideId, description: desc);
    socket.emit("facility_request", dto.toJson());
  }

  void locationReport({required String macAddress, required double proximity}) {
    startSocket(prefs.read("token"));
    socket.io.options['extraHeaders'] = {
      'authorization': 'Bearer ${prefs.read("token")}'
    };
    socket.io
      ..disconnect()
      ..connect();

    Map<String, dynamic> json = {"beacon_id": macAddress};

    if (proximity >= 0.8) socket.emit("get_in", json);
    if (proximity <= 0.2) socket.emit("get_out", json);
  }
}