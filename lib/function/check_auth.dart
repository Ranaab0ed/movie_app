import 'package:shared_preferences/shared_preferences.dart';

class CheckAuth {
  bool skipOnBoarding;
  bool isLogin;

  CheckAuth({required this.skipOnBoarding, required this.isLogin});

  static Future<CheckAuth> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool skipOnBoarding = prefs.getBool("skipOnBoarding") ?? false;
    bool isLogin = prefs.getBool("isLogin") ?? false;

    return CheckAuth(skipOnBoarding: skipOnBoarding, isLogin: isLogin);
  }
}
