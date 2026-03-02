import 'package:miigaik/features/root/tabs/profile/models/profile_model.dart';
import 'package:miigaik/features/root/tabs/profile/repository/lk_repository.dart';

class GetProfileUseCase {
  final LkRepository repository;

  GetProfileUseCase({required this.repository});

  Future<ProfileModel> call() async {
    final profile = await repository.getMe();
    return profile;
  }
}