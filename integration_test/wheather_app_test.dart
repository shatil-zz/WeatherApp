import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/main.dart' as app;

@GenerateMocks([WeatherRepository])
final _repository = MockWeatherRepository();

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Weather integration test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Tap the add button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter the title and description
    await tester.enterText(find.byType(TextField), 'Dhaka');
    await tester.enterText(find.byType(TextField).last, 'Description');
    await tester.tap(find.text('Add Todo'));
    await tester.pumpAndSettle();

    // Verify the new todo is displayed
    expect(find.text('New Todo'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
  });
}
