import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wwather_app_a/bloc/weather_cubit.dart';
import 'package:wwather_app_a/repo/weather_repo.dart';
import 'package:wwather_app_a/screens/home_screen.dart';
import 'package:wwather_app_a/utils/string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        child: const HomeScreen(),
        create: (BuildContext context) => WeatherCubit(WeatherRepository()),
      ),
    );
  }
}
