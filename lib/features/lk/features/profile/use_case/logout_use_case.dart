import 'package:miigaik/features/lk/features/profile/storages/session_storage.dart';

class LogoutUseCase {

  final SessionStorage sessionStorage;

  LogoutUseCase({required this.sessionStorage});

  Future<void> call() async {
    return sessionStorage.clearSession();
  }
}