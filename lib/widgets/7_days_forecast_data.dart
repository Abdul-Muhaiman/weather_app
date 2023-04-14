import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/utils/utils.dart';

class SevenDaysForeCastWidget extends StatelessWidget {
  final data;
  final width;
  final height;
  SevenDaysForeCastWidget(
      {Key? key, required this.data, required this.width, required this.height})
      : super(key: key);
  Utilities _utilities = Utilities();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.33,
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.015, vertical: height * 0.005),
            padding: EdgeInsets.symmetric(
                vertical: height * 0.005, horizontal: width * 0.015),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  data[index]['weather']['description'],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Public Sans',
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: height * 0.08,
                  width: width * 0.3,
                  child: Image(
                    image: AssetImage(
                        'assets/weatherbit_icons/${data[index]['weather']['icon']}.png'),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_downward_rounded,
                              size: height * 0.02,
                            ),
                            Text(
                              '${data[index]['low_temp']}°C',
                              style: GoogleFonts.getFont('Play', fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_rounded,
                              size: height * 0.02,
                            ),
                            Text(
                              '${data[index]['high_temp']}°C',
                              style: GoogleFonts.getFont('Play', fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      _utilities.getWeekDays(data[index]['datetime']),
                      style: GoogleFonts.getFont('Public Sans', fontSize: 16),
                    ),
                    // Text(data[index]['datetime']),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
