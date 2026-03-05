part of 'theme_bloc.dart';

abstract class ThemeEvent {}

final class ChangeAppThemeEvent extends ThemeEvent {
  final AppTheme newAppTheme;

  ChangeAppThemeEvent({required this.newAppTheme});
}

final class NextAppThemeEvent extends ThemeEvent {}