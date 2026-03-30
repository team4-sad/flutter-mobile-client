import 'package:get_it/get_it.dart';
import 'package:miigaik/features/lk/storage/session_storage.dart';

class LogoutUseCase {

  final SessionStorage _sessionStorage;

  LogoutUseCase({SessionStorage? sessionStorage}):
    _sessionStorage = sessionStorage ?? GetIt.I.get();

  Future<void> call() async {
    return _sessionStorage.clearSession();
  }
}