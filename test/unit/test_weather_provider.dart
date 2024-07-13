import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/api_client/resource.dart';
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/repository/weather_repository.dart';
import 'package:weather_app/utils/temparature.dart';

import 'test_weather_provider.mocks.dart';


@GenerateMocks([WeatherRepository])
final _repository = MockWeatherRepository();

void main() {
  group('WeatherProvider unit Test', () {
    test('Data assigned correctly', () async{
      WeatherData data = WeatherData(
          temp: Temperature.celsius(20),
          minTemp: Temperature.celsius(19),
          maxTemp: Temperature.celsius(21),
          description: "Cloudy",
          icon: "09d",
          cityName: "Dhaka");
      final resource = Resources<WeatherData>.fromStatus(status: ResourceStatus.SUCCESS);
      resource.model = data;
      when(_repository.getWeatherData("Dhaka"))
          .thenAnswer((_) => Future.value(resource));
      final provider = WeatherProvider(_repository);
      await provider.searchTemperatureByCityName("Dhaka");
      expect(provider.resources.model?.description, "Cloudy");
      expect(provider.cityName, "Dhaka");
      expect(provider.resources.model?.temp.celsius,20);
    });
  });
}
