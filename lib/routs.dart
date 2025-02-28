import 'package:flutter/material.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/screen/OnBoarding.dart';
import 'package:movies/screen/Tabs/BottomNavigationBarScreen.dart';
import 'package:movies/screen/Tabs/explore_tab.dart';
import 'package:movies/screen/Tabs/home.dart';
import 'package:movies/screen/fav_screen.dart';
import 'package:movies/screen/forget_password_screen.dart';
import 'package:movies/screen/login_Screen.dart';
import 'package:movies/screen/movie_details.dart';
import 'package:movies/screen/register_screen.dart';
import 'package:movies/screen/rest_pass.dart';
import 'package:movies/screen/update_profile_Screen.dart';

Map<String, Widget Function(BuildContext)> routs = {
  AppRouts.onBoarding: (context) => const OnBoarding(),
  AppRouts.home: (context) => const Home(),
  AppRouts.movieDetails: (context) => const MovieDetails(),
  AppRouts.login: (context) => LoginScreen(),
  AppRouts.register: (context) => const RegisterScreen(),
  AppRouts.forgetPass: (context) => const ForgetPasswordScreen(),
  AppRouts.updateProfile: (context) => const UpdateProfileScreen(),
  AppRouts.bottonNavigator: (context) => const BottomNavigationBarScreen(),
  AppRouts.restPass: (context) => const RestPass(),
  AppRouts.explor: (context) => const ExploreTab(),
  AppRouts.fav: (context) => const FavScreen(),
};
