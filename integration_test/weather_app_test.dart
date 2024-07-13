import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/api_client/resource.dart';
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/main.dart' as app;
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/screens/weather_screen.dart';
import 'package:weather_app/utils/temparature.dart';

import '../test/unit/test_weather_provider.mocks.dart';

@GenerateMocks([WeatherRepository])
final _repository = MockWeatherRepository();

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Weather integration test', (WidgetTester tester) async {
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
    app.main();
    await tester.pumpAndSettle();
    await tester.pump();
    final widgetFinder = find.byType(WeatherScreen);
    expect(widgetFinder, findsOneWidget);
    BuildContext? widgetContext;
    widgetFinder.evaluate().forEach((element) {
      widgetContext = element;
    });
    expect(widgetContext!=null, true);
    Provider.of<WeatherProvider>(widgetContext!,listen: false).weatherRepository=_repository;

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
}
