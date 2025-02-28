import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/explor_states.dart';
import 'package:movies/model/movies_model.dart';

class GetExplore extends Cubit<ExploreState> {
  List<Movies> movies = [];
  GetExplore() : super(ExploreInitState());

  void getExplore(String genre) async {
    try {
      emit(ExploreLoadingState());
      Uri url =
          Uri.parse("https://yts.mx/api/v2/list_movies.json?genre=$genre");
      http.Response res = await http.get(url);
      if (res.statusCode == 200 || res.statusCode == 201) {
        final json = jsonDecode(res.body);
        MoviesModel model = MoviesModel.fromJson(json);
        movies = model.data?.movies ?? [];
        emit(ExploreSuccessState());
      } else {
        emit(ExploreErrorState());
      }
    } catch (e) {
      print("--------------$e");
      emit(ExploreErrorState());
    }
  }
}
