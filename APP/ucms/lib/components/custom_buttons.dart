// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/texts.dart';

class PageButton extends StatelessWidget {
  const PageButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}

class PostButton extends StatelessWidget {
  const PostButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}

class ChoiceButton extends StatefulWidget {
  ChoiceButton({Key? key, required this.label}) : super(key: key);

  final String label;
  bool selected = false;

  @override
  _ChoiceButtonState createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      child: TextButton(
        onPressed: press(),
        child: Text(widget.label, textAlign: TextAlign.center),
        style: ElevatedButton.styleFrom(
          primary: widget.selected ? Colors.blue : Colors.white,
          onPrimary: widget.selected ? Colors.white : Colors.blue,
        ),
      ),
    );
  }

  press() => () {
        setState(() {
          widget.selected = !(widget.selected);
        });
      };
}

class ChoiceButtonGroup extends StatelessWidget {
  ChoiceButtonGroup({Key? key, required this.buttons}) : super(key: key);

  final List<ChoiceButton>? buttons;
  final etcController = TextEditingController();
  //List<ChoiceButton>? buttons;
  late KTextFormField etc =
      KTextFormField(hint: "기타", controller: etcController);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [...buttons!, etc],
    );
  }
}
