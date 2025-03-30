part of 'theme_bloc.dart';

final class ThemeLoad extends Equatable {
  final ThemeData themeData;

  const ThemeLoad({required this.themeData});

  @override
  List<Object?> get props => [themeData];
}
