import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/socket/user_socket_client.dart';
import 'package:ucms/theme/color_theme.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/theme/text_theme.dart';
import 'package:ucms/utils/snackbar.dart';
import 'package:ucms/utils/user_util/user_controller.dart';

class CohortMove extends StatefulWidget {
  CohortMove({Key? key, required this.name, required this.btns}) : super(key: key);

  List<String> btns;
  String name; //외부 or 건물 내
  // List<String> btns = ["막사", "체단실" , "노래방", "지통실", "사지방","샤워실", "통신과"];

  @override
  State<CohortMove> createState() => _CohortMoveState();
}

class _CohortMoveState extends State<CohortMove> {
  final etcCon = TextEditingController();
  final etcController = TextEditingController();
  int _value=1;

  final u = Get.find<UserController>();

 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KScreen(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            topMargin(),
            title("${widget.name} 이동 보고"),
            const SizedBox(height: 20),
            Wrap(children: List<Widget>.generate(widget.btns.length,(int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ChoiceChip(
                    label: Text(widget.btns[index], style:body(fontSize: 15)),
                    selectedColor: selectedColor(),
                    disabledColor: disabledColor(),
                    backgroundColor: chipBackcolor(),
                    elevation :5,
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
            const SizedBox(height: 15),
            WarnButton(
                onPressed: () async {
                  final store = GetStorage();
                  UserSocketClient socket = Get.find<UserSocketClient>();
                  socket.moveRequest( destination: widget.btns[_value],);
                  
                  store.write("state","결재 대기중 ( ${store.read("location")} ▶ ${widget.btns[_value]} )");
                  Get.back();
                  Snack.top("새로고침 필요", "화면을 끌어내려주세요");
                },
            label: "보고"),
            const SizedBox(height: 20),
            footer(),
          ],
        ),
      ),
    );
  }
}
