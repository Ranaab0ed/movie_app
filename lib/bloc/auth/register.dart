import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/auth/register_states.dart';
import 'package:movies/model/post_user_model.dart';
import 'package:movies/model/registor_model.dart';

class RegisterUser extends Cubit<RegisterStates> {
  DataUser? user;
  RegisterUser() : super(RegisterInitState()) {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();
    avaterId = 0;
    modelU = PostUserModel(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      phone: passwordController.text,
      avaterId: avaterId,
    );
  }

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;
  var formKey = GlobalKey<FormState>();
  late int avaterId;
  late PostUserModel modelU;

  void register() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(RegisterLoadingState());
        modelU = PostUserModel(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          phone: "+2${phoneController.text}",
          avaterId: avaterId,
        );
        Uri url =
            Uri.parse("https://route-movie-apis.vercel.app/auth/register");

        String requestBody = jsonEncode(modelU.toJson());

        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: requestBody,
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          //   var json = jsonDecode(response.body);
          // RegisterModel model = RegisterModel.fromJson(json);
          // user = model.data;
          // SharedPreferences shPref = await SharedPreferences.getInstance();
          // shPref.setString("name", user!.name.toString());
          //  shPref.setString("id", user!.sId.toString());
          // shPref.setString("email", user!.email.toString());
          // shPref.setString("phone", user!.phone.toString());
          // shPref.setString("pass", user!.password.toString());
          // shPref.setInt("avaterId", user!.avaterId!.toInt());
          // shPref.setBool("isLogin", true);
          emit(RegisterSuccessState());
        } else {
          print("Error : ${response.body}");
          emit(RegisterErrorState());
        }
      } catch (e) {
        print("Exception: $e");
        emit(RegisterErrorState());
      }
    }
  }
}
