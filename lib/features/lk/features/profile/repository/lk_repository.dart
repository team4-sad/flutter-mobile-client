import 'package:dio/dio.dart';
import 'package:miigaik/features/lk/features/profile/models/profile_model.dart';
import 'package:miigaik/features/lk/features/profile/models/session_model.dart';

abstract class LkRepository {
  Future<SessionModel> login(String username, String password);
  Future<ProfileModel> getMe();
}

class LkRepositoryImpl implements LkRepository {
  final Dio _dio;

  LkRepositoryImpl({required Dio dio}): _dio = dio;

  @override
  Future<ProfileModel> getMe() async {
    final response = await _dio.get("lk/me", options: Options(
      headers: {
        "Authorization": ""
      }
    ));
    final model = ProfileModel.fromJson(response.data);
    return model;
  }

  @override
  Future<SessionModel> login(String username, String password) async {
    // @TODO implement login
    return Future.delayed(
      Duration(milliseconds: 300),
      () => SessionModel(accessToken: "123", refreshToken: '123')
    );
  }
}