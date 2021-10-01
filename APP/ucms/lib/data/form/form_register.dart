import 'package:flutter/material.dart';
import 'package:ucms/components/label.dart';

class FormRegister extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  FormRegister(
      {Key? key,
      required this.tagCon,
      required this.pwCon,
      required this.pwCheckCon,
      required this.divisionCon})
      : super(key: key);

  final TextEditingController tagCon;
  final TextEditingController pwCon;
  final TextEditingController pwCheckCon;
  final TextEditingController divisionCon;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          LabelFormInput(
            label: "tag",
            hint: "군번",
            controller: tagCon,
          ),
          LabelFormInput(label: "pw", hint: "pw",controller: tagCon,),
          LabelFormInput(label: "pw check", hint: "re-enter pw",controller: pwCheckCon),
          LabelFormInput(label: "division", hint: "division",controller: divisionCon),
        ],
      ),
    );
  }
}
