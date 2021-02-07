import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'src/screens.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build();

  //Posso iniciar um provider especifico para o repositorio tbm

  runApp(
    ShouldITakeAnUmbrellaApp(),
  );
}

class ShouldITakeAnUmbrellaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: InitialScreen(),
    );
  }
}
