
part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {}

final class UpdateThemeEvent extends ThemeEvent {
  final bool isDark;
  final ThemeData themeData;

  UpdateThemeEvent({required this.isDark, required this.themeData});

  @override
  List<Object?> get props => [isDark, themeData];

}

final class GetThemeEvent extends ThemeEvent {
  final ThemeData themeData;

   GetThemeEvent({required this.themeData});

  @override
  List<Object?> get props => [themeData];
}