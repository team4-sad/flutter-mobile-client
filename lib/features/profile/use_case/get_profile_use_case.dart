import 'package:miigaik/features/profile/models/profile_model.dart';
import 'package:miigaik/features/profile/repository/lk_repository.dart';

class GetProfileUseCase {
  final LkRepository repository;

  GetProfileUseCase({required this.repository});

  Future<ProfileModel> call() async {
    final profile = await repository.getMe();
    return profile;
  }
}