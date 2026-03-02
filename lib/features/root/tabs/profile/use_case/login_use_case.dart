import 'package:miigaik/features/root/tabs/profile/models/session_model.dart';
import 'package:miigaik/features/root/tabs/profile/repository/lk_repository.dart';
import 'package:miigaik/features/root/tabs/profile/storages/session_storage.dart';

class LoginUseCase {

  final LkRepository repository;
  final SessionStorage sessionStorage;

  LoginUseCase({required this.repository, required this.sessionStorage});

  Future<SessionModel> call(String login, String password) async {
    final session = await repository.login(login, password);
    await sessionStorage.saveSession(session);
    return session;
  }
}