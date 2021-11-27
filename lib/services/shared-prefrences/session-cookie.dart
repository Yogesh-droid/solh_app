import 'package:shared_preferences/shared_preferences.dart';

class SessionCookie {
  static const sessionCookieSharedPrefKey = "sessionCookieKey";

  Future<String?> getSessionCookie() async {
    Stopwatch stopwatch = Stopwatch()..start();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sessionCookie = prefs.getString(sessionCookieSharedPrefKey);
    print('getSessionCookie() executed in ${stopwatch.elapsed}');
    return sessionCookie;
  }

  Future<bool> setSessionKey() async {
    Stopwatch stopwatch = new Stopwatch()..start();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isUpdated =
        await prefs.setString(sessionCookieSharedPrefKey, "cookie");
    print('setSessionKey() executed in ${stopwatch.elapsed}');
    return isUpdated;
  }
}
