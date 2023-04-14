import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/services/call_api.dart';
import 'package:weather_app/services/current_location.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/widgets/7_days_forecast_data.dart';
import 'package:weather_app/widgets/main_title_widget.dart';

import '../utils/dummy_data.dart';
import '../widgets/card_widget.dart';
import '../widgets/heading_n_content.dart';
import 'getx_services.dart';

class CurrentWeatherScreen extends StatefulWidget {
  const CurrentWeatherScreen({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherScreen> createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  //getx controller
  final getxController = Get.put(GetxServices());
  //dump data for making app UI
  final GetAPIData getData = GetAPIData();
  final dummyData = DummyData();
  //Instances
  //Utilities
  final Utilities utilities = Utilities();
  //Getting current location
  CurrentLocation currentLocation = CurrentLocation();

  //Media Query shorthand
  late final width = MediaQuery.of(context).size.width;
  late final height = MediaQuery.of(context).size.height;

  Future showSomething({required context, required builder}) {
    return showDialog(context: context, builder: builder);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => getxController.isLoading.value
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: Column(
                children: [
                  FutureBuilder(
                    future: getData.getWeatherData(
                        getData.APIKey, getxController.location.value),
                    builder: (context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: width,
                          height: height,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        // var current = dummyData.Data['current']['data'][0];
                        var current = snapshot.data!['current']['data'][0];
                        // var forecast = dummyData.Data['forecast']['data'];
                        var forecast = snapshot.data!['forecast']['data'];
                        return Column(
                          children: [
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        getxController.isLoading.value = true;
                                        currentLocation
                                            .getCurrentLocation()
                                            .then((value) {
                                          getxController.location.value = value;
                                          getxController.isLoading.value =
                                              false;
                                        });
                                      },
                                      icon: const Icon(Icons.location_on)),
                                  const Spacer(),
                                  getxController.search.value
                                      ? Container(
                                          width: width * 0.5,
                                          margin: EdgeInsets.symmetric(
                                              vertical: height * 0.007),
                                          child: TextFormField(
                                            controller: getxController
                                                .searchController.value,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Enter something here...',
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
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
                                                      color: Colors.red,
                                                      width: 2)),
                                              errorStyle: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 0,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.center,
                                          child: MainTitleWidget(
                                              title: 'Current Weather'),
                                        ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        getxController.searchOnOff();
                                      },
                                      icon: const Icon(Icons.search)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                  vertical: height * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(width * 0.05),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            description:
                                                utilities.convertUTCtoLocal(
                                                    current['sunrise']),
                                            assetImage:
                                                'assets/icons/sun_icon.png',
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
                                            description:
                                                utilities.convertUTCtoLocal(
                                                    current['sunset']),
                                            assetImage:
                                                'assets/icons/sun_set.png',
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
                                              titleContext:
                                                  '${current['clouds']}%'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          HeadingNContext(
                                              title: 'Humidity',
                                              titleContext:
                                                  '${current['rh']}%'),
                                          HeadingNContext(
                                              title: 'Pressure',
                                              titleContext:
                                                  '${current['pres']}mb'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            MainTitleWidget(title: '7-days forecast'),
                            SevenDaysForeCastWidget(
                                data: forecast, width: width, height: height),
                          ],
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ));
  }
}
