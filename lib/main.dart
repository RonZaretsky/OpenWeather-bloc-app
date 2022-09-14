import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_weather_bloc/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:open_weather_bloc/blocs/weather/weather_bloc.dart';
import 'package:open_weather_bloc/pages/home_page/home_page.dart';
import 'package:open_weather_bloc/repositories/weather_repository.dart';
import 'package:open_weather_bloc/services/weather_api_services.dart';
import 'package:http/http.dart' as http;

import 'blocs/theme/theme_bloc.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherApiSerivices: WeatherApiSerivices(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(
                weatherRepository: context.read<WeatherRepository>()),
          ),
          BlocProvider<TempSettingsBloc>(
            create: (context) => TempSettingsBloc(),
          ),
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
        ],
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            context
                .read<ThemeBloc>()
                .add(ToggleThemeEvent(temp: state.weather.temp));
          },
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Weather App',
                debugShowCheckedModeBanner: false,
                theme: state.appTheme == AppTheme.light
                    ? ThemeData.light()
                    : ThemeData.dark(),
                home: HomePage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
