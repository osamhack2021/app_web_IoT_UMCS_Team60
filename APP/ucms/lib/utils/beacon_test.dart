import 'dart:async';
import 'package:beacons_plugin/beacons_plugin.dart';
import 'package:flutter/material.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';

class BeaconTest extends StatefulWidget {
  const BeaconTest({Key? key}) : super(key: key);

  @override
  State<BeaconTest> createState() => _BeaconTestState();
}

class _BeaconTestState extends State<BeaconTest> {
  String _beaconResult = "";

  @override
  Widget build(BuildContext context) {
    final StreamController<String> beaconEventsController =
        StreamController<String>.broadcast();
    BeaconsPlugin.listenToBeacons(beaconEventsController);

    beaconEventsController.stream.listen((data) {
      setState(() {
        _beaconResult += "stream listen 시작.\n이 아래에 beacon data 들이 찍힙니다.";
      });
      if (data.isNotEmpty) {
        setState(() {
          _beaconResult += (data + "\n");
        });
      }
    }, onDone: () {}, onError: (error) {});

    return MaterialApp(
      home: KScreen(
        child: ListView(
          children: [
            const SizedBox(height: 100),
            title("비콘 테스트"),
            const SizedBox(height: 20),
            Text(_beaconResult),
          ],
        ),
      ),
    );
  }
}
