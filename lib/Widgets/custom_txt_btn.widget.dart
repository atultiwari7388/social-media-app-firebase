import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/utils/colors.dart';

class CustomTextButtonWidget extends StatelessWidget {
  const CustomTextButtonWidget({Key? key, this.textName = "Click", this.onTap})
      : super(key: key);

  final String? textName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          textName!,
          style: GoogleFonts.actor(
            fontWeight: FontWeight.bold,
            color: blueColor,
          ),
        ),
      ),
    );
  }
}
