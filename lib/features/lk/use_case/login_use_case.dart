import 'package:get_it/get_it.dart';
import 'package:miigaik/features/lk/features/profile/models/session_model.dart';
import 'package:miigaik/features/lk/repository/auth_repository.dart';
import 'package:miigaik/features/lk/storage/session_storage.dart';

class LoginUseCase {

  final AuthRepository authRepository;
  final SessionStorage sessionStorage;

  LoginUseCase({AuthRepository? repository, SessionStorage? sessionStorage}):
    authRepository = repository ?? GetIt.I.get(),
    sessionStorage = sessionStorage ?? GetIt.I.get();

  Future<SessionModel> call(String login, String password) async {
    final session = await authRepository.login(login, password);
    await sessionStorage.saveSession(session);
    return session;
  }
}