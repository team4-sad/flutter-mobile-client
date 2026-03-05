part of 'locale_bloc.dart';

abstract class LocaleEvent {}

final class ChangeLocaleEvent extends LocaleEvent {
  final Locale newLocale;

  ChangeLocaleEvent({required this.newLocale});
}

final class NextLocaleEvent extends LocaleEvent {}