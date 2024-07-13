# weather_app

Weather App

## Getting Started
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

##API key for Open Weather Map
I have generate and added a key.
For simplicity I have put the real key in the project.
But in real case we may use a debug/dev key which can be specific to developer device
and replace the key from git when build an apk from CI/CD
