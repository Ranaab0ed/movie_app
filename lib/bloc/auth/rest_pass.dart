import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/auth/rest_pass.dart';
import 'package:movies/core/class/app_links_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestPassBloc extends Cubit<RestPassStates> {
  RestPassBloc() : super(RestPassInitState());

  TextEditingController oldPass = TextEditingController();

  TextEditingController newPass = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  restPass() async {
    try {
      if (formKey.currentState!.validate()) {
        emit(RestPasLoadingState());

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("token") ?? '';

        Uri url = Uri.parse(AppLinksApi.restPass);
        http.Response res = await http.patch(
          url,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "oldPassword": oldPass.text,
            "newPassword": newPass.text,
          }),
        );

        if (res.statusCode >= 200 && res.statusCode < 300) {
          emit(RestPassSuccessState());
        } else {
          emit(RestPassErrorState(error: res.statusCode.toString()));
        }
      }
    } catch (e) {
      emit(RestPassErrorState(error: e.toString()));
    }
  }
}
