import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:should_i_take_an_umbrella/src/models.dart';
import 'package:should_i_take_an_umbrella/src/services.dart';

part 'forecast_state.dart';

class ForecastCubit extends HydratedCubit<ForecastState> {
  ForecastCubit() : super(ForecastInitial());

  @override
  ForecastState fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return ForecastLoaded(Forecast.fromJson(json['forecast']));
    } else
      return ForecastError();
  }

  @override
  Map<String, dynamic> toJson(ForecastState state) {
    if (state is ForecastLoaded) {
      return {'forecast': state.forecast.toJson()};
    } else
      return null;
  }

  @override
  void onChange(Change<ForecastState> change) {
    print("Mudança de estado!\n");
    if (change.nextState is ForecastLoaded) {
      print("Foi para Loaded\n");
    }
    super.onChange(change);
  }

  void update() async {
    final repo = ForecastRepository();
    final forecast = await repo.updateForecast();
    emit(ForecastLoaded(forecast));
  }
}
