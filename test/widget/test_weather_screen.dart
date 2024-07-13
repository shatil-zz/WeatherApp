import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/api_client/resource.dart';
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/utils/temparature.dart';

import 'test_weather_screen.mocks.dart';

@GenerateMocks([WeatherRepository])
final _repository = MockWeatherRepository();

void main() {
  group('WeatherProvider unit Test', () {
    testWidgets('Data displayed successfully', (WidgetTester tester) async {
      WeatherData data = WeatherData(
          temp: Temperature.celsius(20),
          minTemp: Temperature.celsius(19),
          maxTemp: Temperature.celsius(21),
          description: "Cloudy",
          icon: "09d",
          cityName: "Dhaka");
      final resource =
          Resources<WeatherData>.fromStatus(status: ResourceStatus.SUCCESS);
      resource.model = data;
      when(_repository.getWeatherData("Dhaka"))
          .thenAnswer((_) => Future.value(resource));
      final provider = WeatherProvider(_repository);
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => provider,
          child: const MaterialApp(
            home: WeatherScreen(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Dhaka');
      await tester.tap(find.byKey(const Key("search_city")));
      await tester.pumpAndSettle();
      expect(find.text("Dhaka"), findsNWidgets(2));
      expect(find.text("20°"), findsOneWidget);
      expect(find.text("H:21° L:19°"), findsOneWidget);
      expect(find.text("Cloudy"), findsOneWidget);
    });

    testWidgets('Display Error', (WidgetTester tester) async {
      final resource =
      Resources<WeatherData>.error(message: "City not found");
      when(_repository.getWeatherData(any))
          .thenAnswer((_) => Future.value(resource));
      final provider = WeatherProvider(_repository);
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => provider,
          child: const MaterialApp(
            home: WeatherScreen(),
          ),
        ),
      );
      await tester.pump();

      await tester.enterText(find.byType(TextField), 'No city');
      await tester.tap(find.byKey(const Key("search_city")));
      await tester.pumpAndSettle();

      expect(find.text('City not found'), findsOneWidget);

    });
  });
}
