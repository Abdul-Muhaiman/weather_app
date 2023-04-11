import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/call_api.dart';
import 'package:weather_app/utils/dummy_data.dart';
import 'package:weather_app/utils/utils.dart';

import '../widgets/card_widget.dart';
import '../widgets/heading_n_content.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  final GetAPIData getData = GetAPIData();
  final DummyData dummyData = DummyData();
  final Utilities utilities = Utilities();
  static String apiKey = 'e95f6309a4d44379aa86afa2ee08fc80';
  late final width = MediaQuery.of(context).size.width;
  late final height = MediaQuery.of(context).size.height;
  bool search = false;
  var getCity = 'risalpur';
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          children: [
            FutureBuilder(
              future: getData.getWeatherData(apiKey, getCity),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: width,
                    height: height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  var current = dummyData.Data['current']['data'][0];
                  var forecast = dummyData.Data['forecast']['data'];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            search
                                ? AnimatedContainer(
                                    width: width * 0.5,
                                    duration: Duration(milliseconds: 500),
                                    child: TextFormField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter something here...',
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide.none),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.red, width: 2)),
                                        errorStyle: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 0,
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Current weather',
                                    style: GoogleFonts.getFont('Comfortaa',fontSize: 22),
                                  ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    if (search) {
                                      setState(() {
                                        getCity = searchController.text;
                                        searchController.clear();
                                        search = false;
                                      });
                                    } else {
                                      setState(() {
                                        search = true;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.search)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.05, vertical: height * 0.03),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '${current['city_name']}, ${current['country_code']}',
                                        style: GoogleFonts.getFont(
                                            'Public Sans',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        current['weather']['description'],
                                        style: GoogleFonts.publicSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        '${current['temp']}°C',
                                        style: GoogleFonts.teko(
                                          fontSize: 48,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Image(
                                      image: AssetImage(
                                          'assets/weatherbit_icons/${current['weather']['icon']}.png')),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.015),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CardWidget(
                                      title: 'Sunrise',
                                      description: utilities.convertUTCtoLocal(
                                          current['sunrise']),
                                      assetImage: 'assets/icons/sun_icon.png',
                                    ),
                                  ),
                                  Expanded(
                                    child: CardWidget(
                                      title: 'Wind',
                                      description:
                                          '${current['wind_spd'].toStringAsFixed(1)} m/s',
                                      assetImage: 'assets/icons/wind.png',
                                    ),
                                  ),
                                  Expanded(
                                    child: CardWidget(
                                      title: 'Sunset',
                                      description: utilities
                                          .convertUTCtoLocal(current['sunset']),
                                      assetImage: 'assets/icons/sun_set.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    HeadingNContext(
                                      title: 'Part of day',
                                      titleContext: current['pod'] == 'd'
                                          ? 'Day'
                                          : 'Night',
                                    ),
                                    HeadingNContext(
                                        title: 'Clouds',
                                        titleContext: '${current['clouds']}%'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    HeadingNContext(
                                        title: 'Humidity',
                                        titleContext: '${current['rh']}%'),
                                    HeadingNContext(
                                        title: 'Pressure',
                                        titleContext: '${current['pres']}mb'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: Center(
                          child: Text(
                            '7-days forecast',
                            style: GoogleFonts.getFont('Comfortaa',fontSize: 22),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: ListView.builder(
                          itemCount: forecast.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.33,
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.015,
                                  vertical: height * 0.005),
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.005,
                                  horizontal: width * 0.015),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    forecast[index]['weather']['description'],
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
                                          'assets/weatherbit_icons/${forecast[index]['weather']['icon']}.png'),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_downward_rounded,
                                                size: height * 0.02,
                                              ),
                                              Text(
                                                '${forecast[index]['low_temp']}°C',
                                                style: GoogleFonts.getFont(
                                                    'Play',
                                                    fontSize: 12),
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
                                                '${forecast[index]['high_temp']}°C',
                                                style: GoogleFonts.getFont(
                                                    'Play',
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        utilities.getWeekDays(
                                            forecast[index]['datetime']),
                                        style: GoogleFonts.getFont(
                                            'Public Sans',
                                            fontSize: 16),
                                      ),
                                      // Text(forecast[index]['datetime']),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.8,
                      //   child: ListView.builder(
                      //     itemCount: forecast.length,
                      //     scrollDirection: Axis.horizontal,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 5),
                      //         child: Container(
                      //           width: MediaQuery.of(context).size.width * 0.35,
                      //           padding: const EdgeInsets.symmetric(
                      //               vertical: 15, horizontal: 10),
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(15),
                      //             boxShadow: [
                      //               BoxShadow(
                      //                 color: Colors.grey.shade400,
                      //                 blurRadius: 5, // soften the shadow
                      //                 spreadRadius: 2.0, //extend the shadow
                      //                 offset: const Offset(
                      //                   0.0, // Move to right 5  horizontally
                      //                   1.0,
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //           child: Column(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               Text(
                      //                 forecast[index]['weather']['description'],
                      //                 textAlign: TextAlign.center,
                      //                 style: const TextStyle(
                      //                   fontSize: 16,
                      //                 ),
                      //               ),
                      //               const SizedBox(
                      //                 height: 50,
                      //                 width: 50,
                      //                 child: Image(
                      //                     image: AssetImage(
                      //                         'assets/icons/snow_icon.png')),
                      //               ),
                      //               Column(
                      //                 children: [
                      //                   Row(
                      //                     mainAxisAlignment:
                      //                         MainAxisAlignment.spaceBetween,
                      //                     children: [
                      //                       Row(
                      //                         children: [
                      //                           const Icon(
                      //                             Icons.arrow_downward_rounded,
                      //                             size: 18,
                      //                           ),
                      //                           Text(forecast[index]['low_temp']
                      //                               .toString()),
                      //                         ],
                      //                       ),
                      //                       Row(
                      //                         children: [
                      //                           const Icon(
                      //                             Icons.arrow_upward_rounded,
                      //                             size: 18,
                      //                           ),
                      //                           Text(forecast[index]['high_temp']
                      //                               .toString()),
                      //                         ],
                      //                       ),
                      //                     ],
                      //                   ),
                      //                   // Text(forecast[index]['datetime']),
                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
