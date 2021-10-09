import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/texts.dart';
import 'package:ucms/theme/text_theme.dart';

class LabelFormInput extends StatelessWidget {
  const LabelFormInput(
      {Key? key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.validator,})
      : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom : 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold()),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: KTextFormField(hint: hint, controller: controller, validator: validator,),
          ),
        ],
      ),
    );
  }
}
class LabelFormIntInput extends StatelessWidget {
  const LabelFormIntInput(
      {Key? key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.validator,})
      : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom : 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold()),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: KTextFormField(hint: hint, controller: controller, validator: validator, type:TextInputType.number),
          ),
        ],
      ),
    );
  }
}

class LabelFormDropDown extends StatefulWidget {
  const LabelFormDropDown(
      {Key? key,
      required this.label,
      required this.hint,
      required this.controller,
      required this.validator,
      required this.labels,
      })
      : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final List<String> labels;

  @override
  State<LabelFormDropDown> createState() => _LabelFormDropDownState();
}

class _LabelFormDropDownState extends State<LabelFormDropDown> {
  var dropdownValue="";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom : 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label, style: bold()),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: DropdownButton<String>(
                value: dropdownValue,
                hint: const Text("선택하세요"),
                style: const TextStyle(color: Colors.blue),
                alignment: AlignmentDirectional.centerEnd,
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[...widget.labels]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
          ),
        ],
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  const LabelText({Key? key, required this.label, required this.content})
      : super(key: key);

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom : 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
