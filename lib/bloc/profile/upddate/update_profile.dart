import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/profile/update_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileBloc extends Cubit<UpdateStates> {
  UpdateProfileBloc() : super(UpdateInitState());

  late int avaterId = 0;

  late TextEditingController cName = TextEditingController();

  late TextEditingController cPhone = TextEditingController();

  getUser() async {
    emit(UpdateLoadingState());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name')!;
    String phone = prefs.getString('phone')!;
    avaterId = prefs.getInt('avaterId')!;
    cName.text = name;
    cPhone.text = phone;
    emit(UpdateInitState());
  }

  bool selectedAvatar(int i) {
    bool isSelected = avaterId == i;
    emit(UpdateInitState());
    return isSelected;
  }

  updateUser() async {
    try {
      emit(UpdateLoadingState());

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? '';
      String email = prefs.getString("email") ?? '';
      Uri url = Uri.parse("https://route-movie-apis.vercel.app/profile");
      http.Response res = await http.patch(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "avaterId": avaterId,
          "name": cName.text,
          "phone": cPhone.text
        }),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        prefs.setString("name", cName.text);
        prefs.setString("phone", cPhone.text);
        prefs.setInt("avaterId", avaterId);

        emit(UpdateSuccessState());
      } else {
        print("Error : ${res.body}");
        emit(UpdateErrorState());
      }
    } catch (e) {
      print("Exception: $e");
      emit(UpdateErrorState());
    }
  }
}
