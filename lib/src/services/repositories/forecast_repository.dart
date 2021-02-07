import 'package:dio/dio.dart';
import 'package:should_i_take_an_umbrella/src/models.dart';
import 'package:should_i_take_an_umbrella/src/config.dart';
import 'package:should_i_take_an_umbrella/src/services.dart';

enum Language {
  English,
  Portuguese,
}

class ForecastRepository {
  final Dio _dio;
  final Language language;
  final Location _location;

  ForecastRepository({this.language = Language.English})
      : _dio = Dio(),
        _location = Location();

  String _mapLanguageToString(Language l) {
    switch (l) {
      case Language.English:
        return "en";
      case Language.Portuguese:
        return "pt";
      default:
        return "en";
    }
  }

  Future<Forecast> updateForecast() async {
    String cityName = await _location.getCurrentCityName();

    String url =
        'https://api.weatherbit.io/v2.0/forecast/daily?city=$cityName&key=$kApiKey&days=$kForecastNumberOfDays&lang=${_mapLanguageToString(language)}';

    try {
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        var json = response.data;

        var listOfDays = List.generate(json['data'].length, (index) {
          var weatherData = json['data'][index];

          //TODO arrumar esse cast bizarro de int pra double
          return Weather(
              double.tryParse(weatherData['temp'].toString()),
              weatherData['weather']['code'],
              weatherData['weather']['description']);
        });

        return Forecast(json['city_name'], listOfDays);
      } else
        throw Error();
    } catch (e) {
      print(e);
      return Future.error("Cannot update forecast. $e");
    }
  }
}
