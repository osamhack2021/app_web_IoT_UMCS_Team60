import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:ucms/data/hostnames.dart';

void startSocket() {
  var prefs = Get.find<SharedPreferences>();
  socket_io.Socket socket = Get.put(socket_io.io(socketHost, 
    OptionBuilder()
    .setTransports(['websocket']) // for Flutter or Dart VM
    .setExtraHeaders({'authorization': prefs.getString("token")==null?"":("Bearer "+prefs.getString("token")!)}) // optional
    .build())
  );
  
  socket.onConnect((_) {
  });

  socket.on("permission", (_) {
    socket.emit('msg', 'test');
  });
  
  socket.on("your_status", (_) {});
  socket.on("refresh_status", (_) {});
  socket.on("assemble", (_) {});
  socket.on("cohort_start", (_) {});
  socket.on("cohort_stop", (_) {});
}

