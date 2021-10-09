import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:ucms/data/dto/move_request_dto.dart';
import 'package:ucms/data/hostnames.dart';

class UserSocketClient extends GetxService {
  var prefs = GetStorage();
  late socket_io.Socket socket;

  void startSocket() {
    socket = Get.put(socket_io.io(
        socketHost,
        socket_io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({
          'authorization': prefs.read("token") == null
              ? ""
              : ("Bearer " + prefs.read("token")!)
        }) // optional
            .build()));
    socket.connect();

    socket.onConnect((_) {});

    socket.on("permission", (_) {
      socket.emit('msg', 'test');
    });

    socket.on("your_status", (_) {});
    socket.on("refresh_status", (_) {});
    socket.on("assemble", (_) {});
    socket.on("cohort_start", (_) {});
    socket.on("cohort_stop", (_) {});
  }

  void moveRequest({required String destination}) {
    MoveRequestDto dto = MoveRequestDto(destination: destination);
    socket.emit("move_request", dto.toJson());
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
