import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wwather_app_a/model/weather_model.dart';
import 'package:wwather_app_a/repo/weather_repo.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repository;

  WeatherCubit(this._repository) : super(NoWeatherSearchedState());

  final cityController = TextEditingController();

  Future getWeatherSearched() async {
    emit(WeatherSearchingState());

    try {
      final weather = await _repository.getWeatherFromApi(cityController.text);

      if (weather == null) {
        emit(ErrorState("There is some issue"));
      } else {
        emit(WeatherSearchedState(weather));
        emit(NoWeatherSearchedState());
      }
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}

abstract class WeatherState {}

class NoWeatherSearchedState extends WeatherState {}

class WeatherSearchingState extends WeatherState {}

class WeatherSearchedState extends WeatherState {
  final WeatherData weatherData;

  WeatherSearchedState(this.weatherData);
}

class ErrorState extends WeatherState {
  final message;

  ErrorState(this.message);
}
