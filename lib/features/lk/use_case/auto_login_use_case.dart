import 'package:get_it/get_it.dart';
import 'package:miigaik/features/lk/features/profile/models/session_model.dart';
import 'package:miigaik/features/lk/storage/session_storage.dart';

class AutoLoginUseCase {

  final SessionStorage _sessionStorage;

  AutoLoginUseCase({SessionStorage? sessionStorage}):
    _sessionStorage = sessionStorage ?? GetIt.I.get();

  Future<SessionModel?> call() async {
    final session = await _sessionStorage.getSession();
    return session;
  }
}