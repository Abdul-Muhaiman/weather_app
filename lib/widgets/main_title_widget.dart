import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTitleWidget extends StatelessWidget {
  String title;
  MainTitleWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.getFont('Comfortaa', fontSize: 22),
        ),
      ),
    );
  }
}
