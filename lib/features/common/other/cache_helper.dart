import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheHelper {
  final CacheManager cacheManager;

  CacheHelper({required this.cacheManager});

  Future<void> save(String key, dynamic jsonObj) async {
    final jsonString = jsonEncode(jsonObj);
    final bytes = utf8.encode(jsonString);
    await cacheManager.putFile(key, bytes);
  }

  Future<dynamic> get(String key) async {
    final cacheFile = await cacheManager.getFileFromCache(key);
    if (cacheFile != null) {
      final bytes = await cacheFile.file.readAsBytes();
      final jsonString = utf8.decode(bytes);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }
}