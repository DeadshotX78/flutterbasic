// ignore_for_file: library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
    print('this line of code is triggered');
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
