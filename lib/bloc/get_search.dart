import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/search_movies.dart';
import 'package:movies/model/movies_model.dart';

class GetSearchMovies extends Cubit<SearchMoviesStates> {
  List<Movies> movies = [];
  GetSearchMovies() : super(SearchMoviesInitStates());

  void getSearchMovies(String search) async {
    try {
      emit(SearchMoviesLoadingState());
      Uri url = Uri.parse(
          "https://yts.mx/api/v2/list_movies.json?query_term=$search");
      http.Response res = await http.get(url);
      if (res.statusCode == 200 || res.statusCode == 201) {
        final json = jsonDecode(res.body);
        MoviesModel model = MoviesModel.fromJson(json);
        if (model.status == "ok") {
          if (model.data!.movieCount == 0) {
            emit(SearchMoviesEmptyStates());
          }
          movies = model.data?.movies ?? [];
          print(movies!.length);
          emit(SearchMoviesSuccessStates());
        } else {
          emit(SearchMoviesErrorStates(error: model.statusMessage));
        }
      } else {
        emit(SearchMoviesErrorStates(error: "Error"));
      }
    } catch (e) {
      emit(SearchMoviesErrorStates(error: e.toString()));
    }
  }
}
