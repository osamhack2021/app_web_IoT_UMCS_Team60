import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          constraints: const BoxConstraints(maxWidth: 360, maxHeight: 800),
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const SizedBox(height: 100),
                const Text("Register",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                _buildInputs("id", "id"),
                _buildInputs("pw", "pw"),
                _buildInputs("pw check", "re-enter pw"),
                _buildInputs("division", "division"),
                TextButton(
                  onPressed: () {},
                  child: const Text("전입 등록 신청", textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputs(String name, String hint) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        const Spacer(),
        Container(
          constraints: const BoxConstraints(maxWidth: 200, minWidth: 200),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }
}
