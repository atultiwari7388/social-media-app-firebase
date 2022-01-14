import 'package:flutter/material.dart';

class TextFieldInputWidget extends StatelessWidget {
  const TextFieldInputWidget({
    Key? key,
    required this.hintText,
    required this.textEditingController,
    required this.textInputType,
    required this.icon,
    this.isPass = false,
  }) : super(key: key);

  final String hintText;
  final TextEditingController textEditingController;
  final bool isPass;
  final TextInputType textInputType;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8.0),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
