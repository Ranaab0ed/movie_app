import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies/bloc/states/details_movie.dart';
import 'package:movies/model/movie_details_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GetMovieDetails extends Cubit<DetailsMovieStates> {
  Movie? movie;

  GetMovieDetails({this.movie}) : super(DetailsMovieStatesIni());

  void getMovieDetails(String id) async {
    try {
      emit(DetailsMovieLoadingState());
      Uri url = Uri.parse(
          "https://yts.mx/api/v2/movie_details.json?movie_id=$id&with_cast=true&with_images=true");

      http.Response res = await http.get(url);

      if (res.statusCode == 200 || res.statusCode == 201) {
        final json = jsonDecode(res.body);

        MovieDetailsModel model = MovieDetailsModel.fromJson(json);
        movie = model.data?.movie;

        emit(DetailsMovieSuccessState());
      } else {
        emit(DetailsMovieErrorState(error: "Failed to load movie details"));
      }
    } catch (e) {
      print("---------------$e");
      emit(DetailsMovieErrorState(error: e.toString()));
    }
  }

  Future<void> launchMovieUrl() async {
    Uri url = Uri.parse(movie!.url.toString());
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
