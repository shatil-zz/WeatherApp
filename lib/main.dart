import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/utils/text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return ChangeNotifierProvider<WeatherProvider>(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
          title: 'Weather App',
          theme: ThemeData(
            brightness: Brightness.dark,
            textTheme: TextTheme(
              displayLarge: defTextStyle,
              displayMedium: defTextStyle,
              displaySmall: defTextStyle,
              headlineMedium: defTextStyle,
              headlineSmall: defTextStyle,
              titleMedium: const TextStyle(color: Colors.white),
              bodyMedium: const TextStyle(color: Colors.white),
              bodyLarge: const TextStyle(color: Colors.white),
              bodySmall: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          home: const WeatherScreen()),
    );
  }
}
