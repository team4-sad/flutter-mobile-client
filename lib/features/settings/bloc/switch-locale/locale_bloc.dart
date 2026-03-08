import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {

  final List<Locale> _supportedLocales;

  LocaleBloc(
      this._supportedLocales,
      Locale defaultLocale
  ) : super(LocaleState(locale: defaultLocale)) {
    on<ChangeLocaleEvent>((event, emit) {
      if (event.newLocale == state.locale){
        return;
      }
      emit(LocaleState(locale: event.newLocale));
    });

    on<NextLocaleEvent>((event, emit){
      final indexCurr = _supportedLocales.indexOf(state.locale);
      final newLocaleIndex = (indexCurr + 1) % _supportedLocales.length;
      final newLocale = _supportedLocales[newLocaleIndex];
      emit(LocaleState(locale: newLocale));
    });
  }
}
