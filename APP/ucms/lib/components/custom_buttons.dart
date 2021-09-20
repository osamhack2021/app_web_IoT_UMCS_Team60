// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ucms/components/hinted_texts.dart';
import 'package:ucms/components/label.dart';

class PageButton extends StatelessWidget {
  const PageButton({required this.onPressed, required this.label});

  final Function onPressed;
  final String label; 

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed(),
          child: Text(label, textAlign: TextAlign.center),
        );
  }
}

class PostButton extends StatelessWidget {
  const PostButton({required this.onPressed, required this.label});

  final Function onPressed;
  final String label; 

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed(),
          child: Text(label, textAlign: TextAlign.center),
        );
  }
}

class ChoiceButton extends StatefulWidget {
  ChoiceButton({required this.label,required this.onPressed});

  Function onPressed;
  final String label;

  @override
  _ChoiceButtonState createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
    
  bool pressed=false;
  Function onPressed=(){};
  final String label;
    

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed(),
          child: Text(label, textAlign: TextAlign.center),
          style: ElevatedButton.styleFrom(
            primary: pressed ? Colors.blue : Colors.white,
          ),
        );
  }
}

class ChoiceButtonGroup extends StatelessWidget {
  ChoiceButtonGroup ({required this.onPressed, required this.buttonNames}){
    for(String name in buttonNames) {
      buttons!.add(ChoiceButton(label: name, onPressed: (){},));
    }
  }

  final Function onPressed;
  final List<String> buttonNames;
  int selected=-1;
  List<ChoiceButton>? buttons; 
  KTextFormField etc = KTextFormField(hint: "기타");
  

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children :[ Text("Hello"),...buttons!],
    );
  }

  void pressed(int newSelected) {
    if(selected==newSelected) {
      selected=-1;
    }

    if(selected!=-1) {
      buttons![selected].pressed=false;
    }
    
    buttons![newSelected].pressed=true;
    selected=newSelected;
  }
}

