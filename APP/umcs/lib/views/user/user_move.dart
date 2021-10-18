// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umcs/model/places/place.dart';
import 'package:umcs/views/components/custom_buttons.dart';
import 'package:umcs/views/components/custom_screen.dart';
import 'package:umcs/views/components/texts.dart';
import 'package:umcs/services/socket/user_socket_client.dart';
import 'package:umcs/views/theme/color_theme.dart';
import 'package:umcs/views/theme/size.dart';
import 'package:umcs/views/theme/text_theme.dart';
import 'package:umcs/controllers/user_controller.dart';
import 'package:umcs/utils/validate.dart';

class UserMove extends StatefulWidget {
  UserMove({Key? key, required this.btns}) : super(key: key);

  List<Place> btns;

  @override
  State<UserMove> createState() => _UserMoveState();
}

class _UserMoveState extends State<UserMove> {
  final descCon = TextEditingController();
  int _value = 1;

  final u = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return KScreen(
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          topMargin(),
          title("이동 보고"),
          const SizedBox(height: 20),
          Wrap(
            children: List<Widget>.generate(
              widget.btns.length,
              (int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ChoiceChip(
                    label: Text(widget.btns[index].name,
                        style: body(
                            fontSize: 15.0)),
                    selectedColor: selectedColor(),
                    disabledColor: disabledColor(),
                    backgroundColor: chipBackcolor(),
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
          PostButton(
              onPressed: () async {
                final store = GetStorage();
                UserSocketClient socket = Get.find<UserSocketClient>();
                socket.moveRequest(
                    outsideId: widget.btns[_value].beaconId,
                    desc: descCon.text.trim());

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