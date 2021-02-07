import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Weather extends Equatable {
  final double temp;
  final int code;
  final String description;

  @override
  List<Object> get props => [temp, code, description];

  Weather(this.temp, this.code, this.description);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  @override
  String toString() {
    return "Temperature: $temp - Description: $description";
  }
}
