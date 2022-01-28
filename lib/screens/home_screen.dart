import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wwather_app_a/bloc/weather_cubit.dart';
import 'package:wwather_app_a/utils/string.dart';
import 'package:lottie/lottie.dart';
import 'package:wwather_app_a/utils/styles.dart';
import 'temperature_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  getWeatherFromWidget(BuildContext context) {
    final cubit = context.watch<WeatherCubit>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Lottie.asset('assets/weather.json'),
          ),
          const Text(
            title,
            style: titleStyle,
          ),
          const Text(
            subTitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          TextField(
            controller: cubit.cityController,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              fillColor: Colors.grey[100],
              filled: true,
              prefixIcon: const Icon(Icons.search),
              hintStyle: const TextStyle(color: Colors.black),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                cubit.getWeatherSearched();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: Colors.indigo,
                padding: const EdgeInsets.all(
                  16,
                ),
              ),
              child: const Text(
                search,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getLoadingWidget() {
    return const Center(child: CircularProgressIndicator());
  }

  getErrorWidget(message) {
    return Center(
        child: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<WeatherCubit>();

    return BlocListener(
      listener: (context, state) {
        if (state is WeatherSearchedState && state.weatherData != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TemperatureScreen(
                state.weatherData,
                cubit.cityController.text,
              ),
            ),
          );
        }
      },
      bloc: cubit,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.blueGrey[50],
            body: cubit.state is WeatherSearchingState
                ? getLoadingWidget()
                : cubit.state is ErrorState
                    ? getErrorWidget("Some Error")
                    : cubit.state is NoWeatherSearchedState
                        ? getWeatherFromWidget(context)
                        : Container()),
      ),
    );
  }
}
