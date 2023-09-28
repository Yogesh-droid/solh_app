import 'package:solh/services/cache_manager/cache_manager.dart';

class AppRatingStatus {
  static bool appRatingStatus = false;

  static Future<void> setRatingReminderTime() async {
    await SolhCacheManager.instance.writeJsonCache(
        key: "appRatingReminderTime",
        json: {'appRatingReminderTime': DateTime.now().toString()},
        duration: Duration(hours: 48));
  }

  static Future<bool> shouldShowRatingReminder() async {
    var response = await SolhCacheManager.instance
        .readJsonCache(key: "appRatingReminderTime");
    print(response.toString() + "shouldShowRatingReminder");
    if (response != null) return false;
    return true;
  }
}
