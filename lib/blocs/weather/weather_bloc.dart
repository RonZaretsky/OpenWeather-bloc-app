// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:open_weather_bloc/repositories/weather_repository.dart';

import '../../models/custom_error.dart';
import '../../models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc({
    required this.weatherRepository,
  }) : super(WeatherState.initial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  void _fetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(state.copyWith(weatherStatus: WeatherStatus.loading));

    try {
      final Weather weather = await weatherRepository.fetchWeather(event.city);
      emit(state.copyWith(
        weatherStatus: WeatherStatus.loaded,
        weather: weather,
      ));
    } on CustomError catch (e) {
      emit(state.copyWith(
        weatherStatus: WeatherStatus.error,
        error: e,
      ));
    }
  }
}
