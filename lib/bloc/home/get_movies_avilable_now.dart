import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/bloc_home_states.dart';
import 'package:movies/core/class/app_links_api.dart';
import 'package:movies/model/movies_model.dart';

class GetMoviesAvailableNow extends Cubit<HomeStates> {
  List<Movies>? moviesAvailableNow;
  GetMoviesAvailableNow() : super(HomeInitState());

  void getMoviesAvailableNow() async {
    try {
      emit(HomeGetLoadingStateMVN());
      Uri url = Uri.parse(AppLinksApi.getMoviesAvailableNow);
      final http.Response res = await http.get(url);
      if (res.statusCode == 200 || res.statusCode == 201) {
        var json = jsonDecode(res.body);
        MoviesModel moviesModel = MoviesModel.fromJson(json);
        moviesAvailableNow = moviesModel.data?.movies ?? [];
        emit(HomeGetSuccessStateMAN());
      } else {
        emit(HomeGetErrorStateMVN());
      }
    } catch (e) {
      print("---------------------------------$e");
      emit(HomeGetErrorStateMVN());
    }
  }
}
