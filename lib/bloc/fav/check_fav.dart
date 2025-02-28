import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/fav%20states/check_fav_state.dart';
import 'package:movies/core/class/app_links_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckFavBloc extends Cubit<CheckFavState> {
  bool isFav = false;

  CheckFavBloc() : super(CheckFavInitState());

  Future<void> checkFav(int movieId) async {
    try {
      emit(CheckFavLoadingState());
      Uri url = Uri.parse(AppLinksApi.isFav + movieId.toString());

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? '';

      http.Response res = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      print(res.body);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final resBody = jsonDecode(res.body);
        isFav = resBody["data"];
        emit(isFav ? CheckFavSuccessState() : CheckNotFavState());
      } else {
        emit(CheckFavErrorState());
      }
    } catch (e) {
      print("Error checking favorite: $e");
      emit(CheckFavErrorState());
    }
  }
}
