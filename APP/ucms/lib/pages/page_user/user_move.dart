import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/pages/page_user/user_main.dart';
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
            const SizedBox(height: 100),
            title("이동 보고"),
            Wrap(children: List<Widget>.generate(3,(int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ChoiceChip(
                    label: Text(btns[index]),
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
                  int result = await u.move(
                    where: btns[_value],
                  );
                  if (result == 1) {
                    Get.to(() => UserMain(
                          location: store.read("location")??"not found",
                          state: store.read("state")??"not found",
                        ));
                  } else {
                    Get.snackbar("로그인 시도", "로그인 실패");
                  }
                },
            label: "보고"),
          ],
        ),
      ),
    );
  }
}