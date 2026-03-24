import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miigaik/core/bloc/with_error_state.dart';
import 'package:miigaik/features/lk/features/profile/models/session_model.dart';
import 'package:miigaik/features/lk/features/profile/use_case/auto_login_use_case.dart';
import 'package:miigaik/features/lk/features/profile/use_case/login_use_case.dart';
import 'package:miigaik/features/lk/features/profile/use_case/logout_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final AutoLoginUseCase autoLoginUseCase;


  AuthCubit({required this.loginUseCase, required this.autoLoginUseCase, required this.logoutUseCase}) : super(NotAuthorizedState()){
    autoLoginUseCase().then((session) {
      if (session != null){
        emit(AuthorizedState(session: session));
      }
    });
  }

  Future<void> auth(String login, String password) async {
    emit(LoadingAuthState());
    try {
      final session = await loginUseCase(login, password);
      emit(AuthorizedState(session: session));
    } on Object catch (e) {
      emit(ErrorAuthState(error: e));
      return;
    }
  }

  Future<void> logout() async {
    emit(LoadingAuthState());
    try {
      await logoutUseCase();
      emit(NotAuthorizedState());
    } on Object catch (e) {
      emit(ErrorAuthState(error: e));
      return;
    }
  }
}
