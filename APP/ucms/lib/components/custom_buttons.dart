// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/texts.dart';

class PageButton extends StatelessWidget {
  const PageButton({Key? key, required this.onPressed, required this.label}) : super(key: key);

  final Function() onPressed;
  final String label; 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(onPressed: onPressed,
            child: Text(label, textAlign: TextAlign.center),
          ),
    );
  }
}

class PostButton extends StatelessWidget {
  const PostButton({Key? key, required this.onPressed, required this.label}) : super(key: key);

  final Function() onPressed;
  final String label; 


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(onPressed: onPressed,
            child: Text(label, textAlign: TextAlign.center),
          ),
    );
  }
}

class ChoiceButton extends StatefulWidget {
  ChoiceButton({Key? key, required this.label}) : super(key: key);

  static String selected = "기타";
  final String label;
  Function? check;

  @override
  _ChoiceButtonState createState() => _ChoiceButtonState();
  
}

class _ChoiceButtonState extends State<ChoiceButton> {

  @override
  void initState() {
    super.initState();
    widget.check = () {setState(() {});};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding : const EdgeInsets.all(7),
      child: TextButton(onPressed:press(),
            child: Text(widget.label, textAlign: TextAlign.center),
            style: ElevatedButton.styleFrom(
              primary: ChoiceButton.selected==widget.label ? Colors.blue : Colors.white,
              onPrimary: ChoiceButton.selected==widget.label ? Colors.white :Colors.blue, 
            ),
          ),
    );
  }

  press() => () {
    setState(() {
      ChoiceButton.selected = (ChoiceButton.selected!=widget.label) ? widget.label : "기타";
      ChoiceButtonGroup.check!();
    });
  };


  
}

class ChoiceButtonGroup extends StatefulWidget {
  ChoiceButtonGroup ({Key? key, required this.buttons}) : super(key: key) ;

  int selected=-1;
  static Function? check;

  final List<ChoiceButton>? buttons;
  //List<ChoiceButton>? buttons;
  KTextFormField etc = KTextFormField(hint: "기타");

  @override
  _ChoiceButtonGroupState createState() => _ChoiceButtonGroupState();
}

class _ChoiceButtonGroupState extends State<ChoiceButtonGroup> {
  
  @override
  void initState() {
    super.initState();
    ChoiceButtonGroup.check = () {
   for(ChoiceButton b in widget.buttons!) {b.check!();}
    };
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children :[ ...widget.buttons!, widget.etc],
    );
  }
}
