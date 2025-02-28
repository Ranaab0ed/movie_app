import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/auth/login_states.dart';
import 'package:movies/core/class/app_links_api.dart';
import 'package:movies/model/registor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInUser extends Cubit<LogInStates> {
  DataUser? user;
  LogInUser() : super(LogInInitState()) {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  late TextEditingController emailController;
  late TextEditingController passwordController;
  var formKey = GlobalKey<FormState>();

  void logIn() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(LogInLoadingState());
        emailController = emailController;
        passwordController = passwordController;

        Uri url = Uri.parse("https://route-movie-apis.vercel.app/auth/login");
        final response = await http.post(
          url,
          body: {
            "email": emailController.text,
            "password": passwordController.text
          },
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          final responseData = jsonDecode(response.body);
          String token = responseData["data"];

          if (await getProfile(token)) {
            emit(LogInSuccessState());
          }
        } else {
          print("Error : ${response.body}");
          emit(LogInErrorState());
        }
      } catch (e) {
        print("Exception: $e");
        emit(LogInErrorState());
      }
    }
  }

  Future<bool> getProfile(String token) async {
    try {
      print("---------------------------------------");
      Uri url = Uri.parse(AppLinksApi.getProfile);
      http.Response res = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      print("----------${res.body}-----------------------------");

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final json = jsonDecode(res.body);
        RegisterModel model = RegisterModel.fromJson(json);
        user = model.data;
        SharedPreferences shPref = await SharedPreferences.getInstance();

        shPref.setString("id", user!.sId.toString());
        shPref.setString("name", user!.name.toString());
        shPref.setString("email", user!.email.toString());
        shPref.setString("phone", user!.phone.toString());
        shPref.setString("pass", user!.password.toString());
        shPref.setString("token", token);
        shPref.setInt("avaterId", user!.avaterId!.toInt());
        shPref.setBool("isLogin", true);
        print("------------- success get profile ----------");

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
