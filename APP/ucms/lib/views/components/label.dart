// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/views/components/texts.dart';
import 'package:ucms/views/theme/color_theme.dart';
import 'package:ucms/views/theme/text_theme.dart';

class LabelFormInput extends StatelessWidget {
  LabelFormInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.isCohort = false,
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  bool isCohort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold()),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: KTextFormField(
              hint: hint,
              controller: controller,
              validator: validator,
              isCohort: isCohort,
            ),
          ),
        ],
      ),
    );
  }
}

class LabelFormIntInput extends StatelessWidget {
  LabelFormIntInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.isCohort = false,
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  bool isCohort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold()),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: KTextFormField(
              hint: hint,
              controller: controller,
              validator: validator,
              type: TextInputType.number,
              isCohort: isCohort,
            ),
          ),
        ],
      ),
    );
  }
}

class LabelFormFloatInput extends StatelessWidget {
  LabelFormFloatInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.isCohort = false,
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  bool isCohort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold()),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: KTextFormField(
              hint: hint,
              controller: controller,
              validator: validator,
              type: TextInputType.number,
              isCohort: isCohort,
            ),
          ),
        ],
      ),
    );
  }
}

class LabelFormDateTimeInput extends StatelessWidget {
  LabelFormDateTimeInput({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.isCohort = false,
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  bool isCohort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold()),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: KTextFormField(
              hint: hint,
              controller: controller,
              validator: validator,
              type: TextInputType.datetime,
              isCohort: isCohort,
            ),
          ),
        ],
      ),
    );
  }
}

class LabelFormDropDown extends StatefulWidget {
  LabelFormDropDown({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    required this.labels,
    this.isCohort = false,
  }) : super(key: key);

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final List<String> labels;
  bool isCohort;

  @override
  State<LabelFormDropDown> createState() => _LabelFormDropDownState();
}

class _LabelFormDropDownState extends State<LabelFormDropDown> {
  String dropdownValue = "훈련병";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.label, style: bold()),
          Container(
            constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
            child: DropdownButton<String>(
              value: dropdownValue == "" ? widget.labels[0] : dropdownValue,
              hint: const Text("선택하세요", textAlign: TextAlign.end),
              style: TextStyle(
                  color: (widget.isCohort) ? warningColor() : enabledColor()),
              alignment: AlignmentDirectional.centerEnd,
              underline: Container(
                height: 2,
                color: (widget.isCohort) ? warningColor() : enabledColor(),
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
      padding: const EdgeInsets.only(bottom: 10.0),
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
