part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends ThemeEvent {
  num temp;
  ToggleThemeEvent({
    required this.temp,
  });

  @override
  List<Object> get props => [temp];
}
