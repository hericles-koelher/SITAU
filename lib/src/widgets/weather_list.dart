import 'package:flutter/material.dart';
import 'package:should_i_take_an_umbrella/src/models.dart';

class WeatherList extends StatelessWidget {
  final List<Weather> _weather;

  const WeatherList({List<Weather> weather}) : _weather = weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_weather.length,
          (index) => WeatherListTile(weather: _weather[index])),
    );
  }
}

//TODO melhorar isso aqui

class WeatherListTile extends StatelessWidget {
  final String day;
  final int temperature;
  final IconData weatherStatus;

  WeatherListTile({Weather weather})
      : day = 'SUNDAY',
        temperature = weather.temp.round(),
        weatherStatus = Icons.wb_sunny_outlined;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
        ),
        Row(
          children: [
            Text(
              '$temperatureº',
            ),
            SizedBox(
              width: 25.0,
            ),
            Icon(
              weatherStatus,
            ),
          ],
        ),
      ],
    );
  }
}
