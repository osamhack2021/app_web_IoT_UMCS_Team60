import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:ucms/data/hostnames.dart';

void startSocket() {
  var prefs = GetStorage();
  socket_io.Socket socket = Get.put(socket_io.io(
      socketHost,
      socket_io.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .setExtraHeaders({
        'authorization': prefs.read("token") == null
            ? ""
            : ("Bearer " + prefs.read("token")!)
      }) // optional
          .build()));

  socket.onConnect((_) {});

  socket.on("permission", (_) {
    socket.emit('msg', 'test');
  });

  socket.on("your_status", (_) {});
  socket.on("refresh_status", (_) {});
  socket.on("assemble", (_) {});
  socket.on("cohort_start", (_) {
    
  });
  socket.on("cohort_stop", (_) {});
}
