import 'dart:convert';

import 'package:cache_manager/cache_manager.dart';
import 'package:solh/services/shared_prefrences/shared_prefrences_singleton.dart';

class SolhCacheManager {
  SolhCacheManager._();

  static final instance = SolhCacheManager._();

  Future<void> writeJsonCache(
      {required String key,
      required dynamic json,
      required Duration duration}) async {
    Prefs.setString(
        "${key}duration", jsonEncode(DateTime.now().add(duration).toString()));
    await WriteCache.setJson(key: key, value: json);
  }

  Future<Map<String, dynamic>?> readJsonCache({required String key}) async {
    String? value = await Prefs.getString("${key}duration");
    if (value != null) {
      DateTime response = DateTime.parse(jsonDecode(value));

      if (response.isAfter(DateTime.now())) {
        return await ReadCache.getJson(key: key);
      } else {
        DeleteCache.deleteKey(key);
        return null;
      }
    } else {
      return null;
    }
  }

  Future<void> clearAllCache() async {
    await DeleteCache.deleteKey("sessionCookie");
    await DeleteCache.deleteKey("appRatingReminderTime");
  }
}
