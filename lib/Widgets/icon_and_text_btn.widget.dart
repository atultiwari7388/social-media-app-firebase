import 'package:flutter/material.dart';

class TextAndIconWidget extends StatelessWidget {
  const TextAndIconWidget(
      {Key? key, required this.icon, required this.text, required this.color})
      : super(key: key);

  final String text;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 27, color: color),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
