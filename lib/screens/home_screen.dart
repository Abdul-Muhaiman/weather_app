import 'package:flutter/material.dart';
import 'package:weather_app/screens/current_weather_screen.dart';
import 'package:weather_app/screens/getx_services.dart';
import 'package:weather_app/services/current_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final currentLocation = CurrentLocation();
  GetxServices _getxController = GetxServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLocation.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: const SafeArea(
        child: CurrentWeatherScreen(),
      ),
    );
  }
}
