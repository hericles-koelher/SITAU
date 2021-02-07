import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:should_i_take_an_umbrella/src/cubits.dart';
import 'package:should_i_take_an_umbrella/src/services.dart';
import 'package:should_i_take_an_umbrella/src/widgets.dart';
import 'package:should_i_take_an_umbrella/src/models.dart';

class InitialScreen extends StatelessWidget {
  final repo = ForecastRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForecastCubit>(
      create: (context) => ForecastCubit(),
      child: Scaffold(
        body: SizedBox.expand(
          child: BlocBuilder<ForecastCubit, ForecastState>(
              builder: (context, state) {
            BlocProvider.of<ForecastCubit>(context).update();
            return Container(
              //TODO bolar cores pra essa merda
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.grey,
                    Colors.blueGrey[300],
                    Colors.blueGrey,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text((state is ForecastLoaded ? state : null)
                                  ?.forecast
                                  ?.cityName ??
                              'Casa do carai'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Icon(
                                Icons.cloud_outlined,
                                size: 75.0,
                              ),
                              Text(
                                "26.4º",
                                style: TextStyle(
                                  fontSize: 75,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "I think it's time to get your umbrella",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                          WeatherList(weather: [Weather(20.0, 192, "string")]),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
