part of 'forecast_cubit.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();
}

class ForecastInitial extends ForecastState {
  @override
  List<Object> get props => [];
}

class ForecastLoaded extends ForecastState {
  final Forecast forecast;

  ForecastLoaded(this.forecast);

  @override
  List<Object> get props => [forecast];
}

class ForecastError extends ForecastState {
  @override
  List<Object> get props => [];
}
