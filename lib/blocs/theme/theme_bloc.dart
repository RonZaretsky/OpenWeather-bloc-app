import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_bloc/consts/consts.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.inital()) {
    on<ToggleThemeEvent>(_toggleTheme);
  }

  void _toggleTheme(ToggleThemeEvent event, Emitter<ThemeState> emit) {
    emit(state.copyWith(
        appTheme: event.temp > kWarmOrNot ? AppTheme.light : AppTheme.dark));
    print(emit.toString());
  }
}
