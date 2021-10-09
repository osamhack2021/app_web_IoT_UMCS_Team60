import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/pages/page_user/user_main.dart';
import 'package:ucms/socket/user_socket_client.dart';
import 'package:ucms/theme/color_theme.dart';
import 'package:ucms/theme/size.dart';
import 'package:ucms/theme/text_theme.dart';
import 'package:ucms/utils/user_util/user_controller.dart';

class UserMove extends StatefulWidget {
  const UserMove({Key? key}) : super(key: key);

  @override
  State<UserMove> createState() => _UserMoveState();
}

class _UserMoveState extends State<UserMove> {
  final etcCon = TextEditingController();
  final etcController = TextEditingController();
  int _value=1;

  final u = Get.find<UserController>();

  List<String> btns = ["막사", "체단실" , "노래방", "지통실", "사지방",];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KScreen(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            topMargin(),
            title("이동 보고"),
            Wrap(children: List<Widget>.generate(btns.length,(int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ChoiceChip(
                    label: Text(btns[index], style:body(fontSize: 15)),
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
            PostButton(
                onPressed: () async {
                  final store = GetStorage();
                  UserSocketClient socket = Get.find<UserSocketClient>();
                  socket.moveRequest( destination: btns[_value],);
                  
                  store.write("state","결재 대기중");
                  Get.back();
                  Get.snackbar("새로고침 필요", "화면을 끌어내려주세요",
                    backgroundColor: snackbarBackColor(),
                  );
                },
            label: "보고"),
            footer(),
          ],
        ),
      ),
    );
  }
}
