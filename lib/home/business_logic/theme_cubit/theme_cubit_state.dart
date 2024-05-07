part of 'theme_mode_cubit.dart';

class ThemeModeInfo extends Equatable {
  final ThemeMode mode;

  ThemeModeInfo([this.mode=ThemeMode.system]);

  @override
  List<Object> get props => [mode];
}
