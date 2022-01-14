import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:instagram_clone/utils/global_var.dart';

class CustomBtnWidget extends StatelessWidget {
  const CustomBtnWidget({Key? key, this.btnName = APPNAME, this.onPressed})
      : super(key: key);

  final String? btnName;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          btnName!,
          style: GoogleFonts.lato(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
