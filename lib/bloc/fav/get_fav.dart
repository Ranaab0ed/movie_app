import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/fav%20states/get_fav_state.dart';
import 'package:movies/core/class/app_links_api.dart';
import 'package:movies/model/fav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetFavBloc extends Cubit<GetFavState> {
  List<DataFav> favModel = [];
  GetFavBloc() : super(GetFavInitState());

  Future<void> getFav() async {
    try {
      emit(GetFavLoadingState());
      Uri url = Uri.parse(AppLinksApi.getFav);
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
        print("------------------------------ fav");
        final json = jsonDecode(res.body);

        FavModel model = FavModel.fromJson(json);

        favModel = model.data ?? [];
        print(favModel[1].imageURL);
        emit(GetFavSuccessState());
      }
    } catch (e) {
      print("___________________-: $e");
      emit(GetFavErrorState());
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
        emit(GetFavSuccessState());
      } else {
        emit(GetFavErrorState());
      }
    } catch (e) {
      print("__________________: $e");
      emit(GetFavErrorState());
    }
  }
}
