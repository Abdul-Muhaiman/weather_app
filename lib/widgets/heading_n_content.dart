import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingNContext extends StatelessWidget {
  String title;
  String titleContext;
  HeadingNContext({Key? key, required this.title, required this.titleContext})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    late final width = MediaQuery.of(context).size.width;
    late final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.005, left: width * 0.02, right: width * 0.02),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.publicSans(fontSize: 20),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.005),
            child: Text(
              titleContext,
              style:
                  GoogleFonts.play(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
