import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWidget extends StatelessWidget {
  String title;
  String description;
  String assetImage;
  CardWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.assetImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final width = MediaQuery.of(context).size.width;
    late final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.015),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.05),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: const Offset(
                0.0, // Move to right 5  horizontally
                1.0,
              ),
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.015),
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image(
                  image: AssetImage(assetImage),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: width * 0.01),
              child: Text(
                title,
                style: GoogleFonts.publicSans(fontSize: 18),
              ),
            ),
            Text(
              description,
              style:
                  GoogleFonts.play(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
