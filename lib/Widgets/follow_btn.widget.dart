import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowButtonWidget extends StatelessWidget {
  const FollowButtonWidget({
    Key? key,
    this.function,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  final Function()? function;
  final Color backgroundColor, borderColor, textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2.0),
      child: TextButton(
        onPressed: function,
        child: Container(
          height: 50,
          width: 130,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(13.0),
          ),
          child: Text(
            text,
            style: GoogleFonts.lato(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
