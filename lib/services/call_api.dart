import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/utils/utils.dart';

class GetAPIData {
  static String baseUrl =
      'https://api.weatherbit.io/v2.0/forecast/daily?&city=risalpur&days=7';
  String APIKey = "YOUR_API_KEY";
  // https://api.weatherbit.io/v2.0/current
  Future<Map<String, dynamic>> getWeatherData(String key, String city) async {
    String currentWeatherUrl =
        'https://api.weatherbit.io/v2.0/current?key=${key}&city=${city}&include=minutely';
    String forecastUrl =
        'https://api.weatherbit.io/v2.0/forecast/daily?key=${key}&city=${city}&days=7';
    try {
      final currentWeatherResponse =
          await http.get(Uri.parse(currentWeatherUrl));
      final forecastResponse = await http.get(Uri.parse(forecastUrl));
      if (currentWeatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        var currentWeatherData = jsonDecode(currentWeatherResponse.body);
        var forecastData = jsonDecode(forecastResponse.body);
        return {"current": currentWeatherData, "forecast": forecastData};
      } else {
        return Utilities().showMessage('Error occurred');
      }
    } catch (e) {
      Utilities().showMessage(e);
    }
    return {"current": null, "forecast": null};
  }
}
