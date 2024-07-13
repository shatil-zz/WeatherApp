import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_search_box.dart';
import 'package:weather_app/screens/current_weather.dart';
import 'package:weather_app/utils/app_colors.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child: const SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
              ),
              CitySearchBox(),
              SizedBox(
                height: 40,
              ),
              CurrentWeather(),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
