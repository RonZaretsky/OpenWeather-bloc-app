import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_bloc/blocs/weather/weather_bloc.dart';
import 'package:open_weather_bloc/consts/consts.dart';
import 'package:open_weather_bloc/utilities/error_dialog.dart';
import 'package:recase/recase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/temp_settings/temp_settings_bloc.dart';

Widget showWeather() {
  return BlocConsumer<WeatherBloc, WeatherState>(
    listener: (context, state) {
      if (state.weatherStatus == WeatherStatus.error) {
        errorDialog(context, state.error.errMsg);
      }
    },
    builder: (context, state) {
      if (state.weatherStatus == WeatherStatus.initial) {
        return const Center(
          child: Text(
            'Select a city',
            style: TextStyle(fontSize: 20.0),
          ),
        );
      }

      if (state.weatherStatus == WeatherStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.weatherStatus == WeatherStatus.error &&
          state.weather.name == '') {
        return const Center(
          child: Text(
            'Select a city',
            style: TextStyle(fontSize: 20.0),
          ),
        );
      }
      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Text(
            state.weather.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                TimeOfDay.fromDateTime(state.weather.lastUpdated)
                    .format(context),
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                '(${state.weather.country})',
                style: const TextStyle(fontSize: 18.0),
              )
            ],
          ),
          const SizedBox(
            height: 60.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _showTemperature(context, state.weather.temp),
                style: const TextStyle(
                    fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Column(
                children: [
                  Text(
                    _showTemperature(context, state.weather.tempMax),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    _showTemperature(context, state.weather.tempMin),
                    style: const TextStyle(fontSize: 16.0),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              _showIcon(state.weather.icon),
              Expanded(flex: 3, child: formatText(state.weather.description)),
              const Spacer(),
            ],
          )
        ],
      );
    },
  );
}

String _showTemperature(BuildContext context, num temperature) {
  final tempUnit = context.watch<TempSettingsBloc>().state.tempUnit;

  if (tempUnit == TempUnit.fahrenheit) {
    return ((temperature * 9 / 5) + 32).toStringAsFixed(2) + '℉';
  }

  return temperature.toStringAsFixed(2) + '℃';
}

Widget _showIcon(String icon) {
  return FadeInImage.assetNetwork(
    placeholder: 'assets/images/loading.gif',
    image: 'http://$kIconHost/img/wn/$icon@4x.png',
    width: 96,
    height: 96,
  );
}

Widget formatText(String desc) {
  final formattedString = desc.titleCase;
  return Text(
    formattedString,
    style: const TextStyle(fontSize: 24.0),
    textAlign: TextAlign.center,
  );
}
