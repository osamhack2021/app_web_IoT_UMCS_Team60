// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/model/places/place.dart';
import 'package:ucms/views/components/custom_buttons.dart';
import 'package:ucms/views/components/custom_screen.dart';
import 'package:ucms/views/components/texts.dart';
import 'package:ucms/services/socket/user_socket_client.dart';
import 'package:ucms/views/theme/color_theme.dart';
import 'package:ucms/views/theme/size.dart';
import 'package:ucms/views/theme/text_theme.dart';
import 'package:ucms/controllers/user_controller.dart';
import 'package:ucms/utils/validate.dart';

class CohortMove extends StatefulWidget {
  CohortMove({Key? key, required this.name, required this.btns})
      : super(key: key);

  List<Place> btns;
  String name; //외부 or 건물 내
  // List<String> btns = ["막사", "체단실" , "노래방", "지통실", "사지방","샤워실", "통신과"];

  @override
  State<CohortMove> createState() => _CohortMoveState();
}

class _CohortMoveState extends State<CohortMove> {
  final descCon = TextEditingController();
  int _value = 0;

  final u = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return KScreen(
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          topMargin(),
          title("${widget.name} 이동 보고"),
          const SizedBox(height: 20),
          Wrap(
            children: List<Widget>.generate(
              widget.btns.length,
              (int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ChoiceChip(
                    label: Text(widget.btns[index].name,
                        style: body(fontSize: 15)),
                    selectedColor: warningColor(),
                    disabledColor: disabledColor(),
                    backgroundColor: warningEnabledColor(),
                    elevation: 5,
                    selected: _value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _value = selected ? index : -1;
                      });
                    },
                  ),
                );
              },
            ).toList(),
          ),
          KTextFormFieldMultiLine(
              hint: "구체적인 사유를 입력하세요",
              controller: descCon,
              validator: validateNothing()),
          const SizedBox(height: 15),
          WarnButton(
              onPressed: () async {
                final store = GetStorage();
                UserSocketClient socket = Get.find<UserSocketClient>();
                if (widget.name == "외부시설") {
                  socket.moveRequest(
                      outsideId: widget.btns[_value].beaconId,
                      desc: descCon.text.trim());
                } else if (widget.name == "건물 내") {
                  socket.facilityRequest(
                      outsideId: widget.btns[_value].beaconId,
                      desc: descCon.text.trim());
                }

                store.write("state",
                    "결재 대기중 ( ${store.read("location")} ▶ ${widget.btns[_value].name} )");
                Get.back();
              },
              label: "보고"),
          const SizedBox(height: 20),
          footer(),
        ],
      ),
    );
  }
}