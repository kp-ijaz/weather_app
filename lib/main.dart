import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/controller/weather_repository.dart';
import 'package:weather_app/view/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: BlocProvider(
        create: (context) =>
            WeatherBloc(WeatherRepository('86666cddd625e7cdd81533161bba41e2')),
        child: const WeatherScreen(),
      ),
    );
  }
}
