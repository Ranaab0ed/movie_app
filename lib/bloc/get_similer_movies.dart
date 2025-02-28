import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/similer_sates.dart';
import 'package:movies/model/movies_model.dart';

class GetSimilerMovies extends Cubit<SimilerSates> {
  List<Movies> movies = [];
  GetSimilerMovies() : super(SimilerMovesInitStates());

  void getSimilerMovies(List<String> genres, int id) async {
    try {
      emit(SimilerLoadingState());
      movies.clear();

      for (String genre in genres) {
        Uri url = Uri.parse(
            "https://yts.mx/api/v2/list_movies.json?sort_by=year&genre=$genre");
        http.Response res = await http.get(url);

        if (res.statusCode == 200 || res.statusCode == 201) {
          final json = jsonDecode(res.body);

          if (json['data'] != null && json['data']['movies'] != null) {
            List<dynamic> moviesList = json['data']['movies'];

            for (var movie in moviesList) {
              if (movie['id'] != id) {
                movies.add(Movies.fromJson(movie));
              }
            }
          }
        } else {
          emit(SimilerErrorState(error: "----------- $genre"));
        }
      }

      emit(SimilerSuccessState());
    } catch (e) {
      print(e);
      emit(SimilerErrorState(error: "Error is => $e"));
    }
  }
}
