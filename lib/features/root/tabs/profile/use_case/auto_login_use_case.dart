import 'package:miigaik/features/root/tabs/profile/models/session_model.dart';
import 'package:miigaik/features/root/tabs/profile/repository/lk_repository.dart';
import 'package:miigaik/features/root/tabs/profile/storages/session_storage.dart';

class AutoLoginUseCase {

  final SessionStorage sessionStorage;

  AutoLoginUseCase({required this.sessionStorage});

  Future<SessionModel?> call() async {
    final session = await sessionStorage.getSession();
    return session;
  }
}