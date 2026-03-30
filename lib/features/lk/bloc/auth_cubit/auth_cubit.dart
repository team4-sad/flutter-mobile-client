import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/features/lk/features/profile/models/session_model.dart';
import 'package:miigaik/features/lk/use_case/auto_login_use_case.dart';
import 'package:miigaik/features/lk/use_case/login_use_case.dart';
import 'package:miigaik/features/lk/use_case/logout_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final _loginUseCase = LoginUseCase();
  final _logoutUseCase = LogoutUseCase();
  final _autoLoginUseCase = AutoLoginUseCase();


  AuthCubit(): super(NotAuthorizedState()){
    _autoLoginUseCase().then((session) {
      if (session != null){
        emit(AuthorizedState(session: session));
      }
    });
  }

  Future<void> auth(String login, String password) async {
    emit(LoadingAuthState());
    try {
      final session = await _loginUseCase(login, password);
      emit(AuthorizedState(session: session));
    } on Object catch (e) {
      emit(ErrorAuthState(error: e));
      return;
    }
  }

  Future<void> logout() async {
    emit(LoadingAuthState());
    try {
      await _logoutUseCase();
      emit(NotAuthorizedState());
    } on Object catch (e) {
      emit(ErrorAuthState(error: e));
      return;
    }
  }
}
