# weather_app

Weather App

## Getting Started

##Set API key for Open Weather Map
- Goto directory lib/api_client/
- Rename api_keys.defaults.dart to api_keys.dart
- Replace your api key


## To Run App run the bellow command
## (Select one android device if there are multiple devicess)
flutter pub get
flutter run

## Run unit test and widget test
## Generate mock classes before run
dart run build_runner build --delete-conflicting-outputs
flutter test

##Run integration test
## Generate mock classes before run
dart run build_runner build --delete-conflicting-outputs
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/weather_app_test.dart

