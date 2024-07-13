import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/weather_icon_image.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (BuildContext context, WeatherProvider provider, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(provider.cityName,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(
              height: 10,
            ),
            if (provider.resources.isLoading)
              const Center(child: CircularProgressIndicator()),
            if (provider.resources.isSuccess)
              CurrentWeatherContents(data: provider.resources.model!),
            if (provider.resources.isError)
              Text(provider.resources.message ?? "",
                  style: Theme.of(context).textTheme.bodyLarge)
          ],
        );
      },
    );
  }
}

class CurrentWeatherContents extends StatelessWidget {
  const CurrentWeatherContents({super.key, required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final temp = "${data.temp.celsius.toInt().toString()}°";
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 100),
        Text(temp, style: textTheme.displayMedium),
        Text(highAndLow, style: textTheme.bodyLarge),
        Text(data.description, style: textTheme.bodyLarge),
      ],
    );
  }
}
