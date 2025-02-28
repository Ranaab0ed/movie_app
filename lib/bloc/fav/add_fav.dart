import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/fav%20states/add_fav_states.dart';
import 'package:movies/core/class/app_links_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFavBloc extends Cubit<AddFavState> {
  AddFavBloc() : super(AddFavInitState());

  Future<void> addFav(
      int movieId, String title, num rating, String imageURL, int year) async {
    try {
      emit(AddFavLoadingState());
      Uri url = Uri.parse(AppLinksApi.addFav);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? '';

      http.Response res = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "movieId": movieId,
          "name": title,
          "rating": rating,
          "imageURL": imageURL,
          "year": year
        }),
      );
      print(imageURL);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        print("------------------------------ fav");
        emit(AddFavSuccessState());
      } else {
        print("------------------------------not fav");
        await removeFav(movieId);
      }
    } catch (e) {
      print("___________________-: $e");
      emit(AddFavErrorState());
    }
  }

  Future<void> removeFav(int movieId) async {
    try {
      print("here-------------");
      Uri urlRemove = Uri.parse("${AppLinksApi.removeFav}$movieId");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? '';

      http.Response resRemove = await http.delete(
        urlRemove,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      print(resRemove.body);
      if (resRemove.statusCode >= 200 && resRemove.statusCode < 300) {
        emit(AddFavSuccessState());
      } else {
        emit(AddFavErrorState());
      }
    } catch (e) {
      print("__________________: $e");
      emit(AddFavErrorState());
    }
  }
}
