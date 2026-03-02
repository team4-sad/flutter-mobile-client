import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:miigaik/features/root/tabs/profile/models/session_model.dart';

abstract class SessionStorage {
  Future<void> saveSession(SessionModel session);
  Future<SessionModel?> getSession();
  Future<void> clearSession();
}

class SessionStorageImpl implements SessionStorage {

  final FlutterSecureStorage _secureStorage;

  SessionStorageImpl({FlutterSecureStorage? secureStorage}):
      _secureStorage = secureStorage ?? GetIt.I.get();

  static const _key = "session_key";

  @override
  Future<void> clearSession() {
    return _secureStorage.deleteAll();
  }

  @override
  Future<SessionModel?> getSession() async {
    final jsonString = await _secureStorage.read(key: _key);
    if (jsonString == null) {
      return null;
    }
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return SessionModel.fromJson(jsonMap);
  }

  @override
  Future<void> saveSession(SessionModel session) {
    final jsonMap = session.toJson();
    final jsonString = jsonEncode(jsonMap);
    return _secureStorage.write(key: _key, value: jsonString);
  }
}