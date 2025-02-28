import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/core/static/app_theme.dart';
import 'package:movies/function/check_auth.dart';
import 'package:movies/routs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = await CheckAuth.init();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: [
      Locale("en"),
      Locale("ar"),
    ],
    path: "assets/translations",
    fallbackLocale: Locale("en"),
    child: MyApp(
      auth: auth,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final CheckAuth auth;
  const MyApp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: auth.skipOnBoarding == false
          ? AppRouts.onBoarding
          : auth.isLogin == false
              ? AppRouts.login
              : AppRouts.bottonNavigator,
      routes: routs,
    );
  }
}
