

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ucms/components/custom_buttons.dart';
import 'package:ucms/page_user/user_main.dart';
import 'package:ucms/user_util/user_controller.dart';
import 'package:ucms/utils/validate.dart';

class FormLogin extends StatelessWidget {
  
  FormLogin({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _tag = TextEditingController();
  final UserController u = Get.put(UserController());
  final _password = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return  Form(
      key : _formKey,
      child :Column(
        children : [
          TextFormField(
            controller: _tag,
            validator: validateId(),
            decoration: const InputDecoration(hintText: "군번"),
          ),
          TextFormField(
            controller: _password,
            validator: validatePw(),
            obscureText:true,
            decoration: const InputDecoration(hintText: "password"),
          ),
          Row (
            mainAxisAlignment: MainAxisAlignment.center,
            children : [
              
              PostButton(label: "용사 로그인",
                onPressed : () async {
                  if (_formKey.currentState!.validate()) {
                    int result = await u.login(_tag.text.trim(), _password.text.trim());
                    if (result == 1) {
                      Get.to(() => UserMain(location: '', state: '',));
                    } else {
                      Get.snackbar("로그인 시도", "로그인 실패");
                    }
                  }
                },
              ),
              PostButton(onPressed: (){
                Navigator.pushNamed(context, "/user/main");
              },label: "간부 로그인"),
            ],
          ),
        ],
      ),
    );
  }
}

