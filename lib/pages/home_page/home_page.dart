import 'package:flutter/material.dart';
import 'package:open_weather_bloc/blocs/weather/weather_bloc.dart';
import 'package:open_weather_bloc/pages/home_page/widgets/show_weather_widget.dart';
import 'package:open_weather_bloc/pages/search_page/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_bloc/pages/settings_page/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
              if (_city != null) {
                context
                    .read<WeatherBloc>()
                    .add(FetchWeatherEvent(city: _city!));
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage();
                  },
                ),
              );
            },
          )
        ],
      ),
      body: showWeather(),
    );
  }
}
