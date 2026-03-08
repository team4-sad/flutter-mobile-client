import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/theme/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(AppTheme defaultAppTheme) : super(ThemeState(appTheme: defaultAppTheme)) {
    on<ChangeAppThemeEvent>((event, emit) {
      if (state.appTheme == event.newAppTheme){
        return;
      }

      emit(ThemeState(appTheme: event.newAppTheme));
    });

    on<NextAppThemeEvent>((event, emit){
      emit(ThemeState(appTheme: state.appTheme.next()));
    });
  }
}
