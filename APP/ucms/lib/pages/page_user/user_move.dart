import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/components/custom_screen.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/data/form/form_move.dart';
import 'package:ucms/pages/page_user/user_main.dart';
import 'package:ucms/utils/user_util/user_controller.dart';

class UserMove extends StatelessWidget {
  UserMove({Key? key}) : super(key: key);

  final etcCon = TextEditingController();
  final form = FormMove();
  final u = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KScreen(
        child: ListView(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 100),
            title("이동 보고"),
            form,
            PostButton(
                onPressed: () async {
                  GetStorage store = Get.find<GetStorage>(tag: "user_storage");
                  int result = await u.move(
                    where: form.destination,
                  );
                  if (result == 1) {
                    Get.to(() => UserMain(
                          location: store.read("location"),
                          state: store.read("state"),
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
