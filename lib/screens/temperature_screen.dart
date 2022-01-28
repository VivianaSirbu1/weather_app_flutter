import 'package:flutter/material.dart';
import 'package:wwather_app_a/model/weather_model.dart';
import 'package:wwather_app_a/utils/styles.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TemperatureScreen extends StatelessWidget {
  final WeatherData weather;
  final String city;

  const TemperatureScreen(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
    LottieBuilder showIcon(double temperature) {
      if (temperature < 0) {
        return Lottie.asset('assets/cold.json');
      } else if (temperature > 0 && temperature < 13) {
        return Lottie.asset('assets/cloudy.json');
      } else if (temperature >= 13 && temperature <= 25) {
        return Lottie.asset('assets/sun.json');
      } else if (temperature > 25) {
        return Lottie.asset('assets/hot.json');
      } else {
        return Lottie.asset('assets/weather.json');
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[50],
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  city.toUpperCase(),
                  style: titleStyle,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: showIcon(weather.temperature),
                    ),
                    const SizedBox(
                      width: 18.0,
                    ),
                    Text(
                      "${weather.temperature.toString()}°C",
                      style: temperatureStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
