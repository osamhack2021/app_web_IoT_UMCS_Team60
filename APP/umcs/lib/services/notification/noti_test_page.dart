import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umcs/views/components/custom_buttons.dart';
import 'package:umcs/views/components/custom_screen.dart';
import 'package:umcs/views/components/texts.dart';
import 'package:umcs/services/notification/noti_manager.dart';

class NotiTestPage extends StatefulWidget {
  const NotiTestPage({Key? key}) : super(key: key);

  @override
  _NotiTestPageState createState() => _NotiTestPageState();
}

class _NotiTestPageState extends State<NotiTestPage> {
  @override
  Widget build(BuildContext context) {
    return KScreen(
      child: Column(
        children: [
          PageButton(
            onPressed: () async {
              NotiManager n = Get.find<NotiManager>();

              await n.flutterLocalNotificationsPlugin
                  .show(1, "test", "testBody", n.platformChannelSpecifics);
            },
            label: quote("test"),
          ),
        ],
      ),
    );
  }
}