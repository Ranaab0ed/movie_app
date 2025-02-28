import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/get_similer_movies.dart';
import 'package:movies/bloc/states/similer_sates.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/customs/movie_poster.dart';
import 'package:movies/function/check_image_url.dart';

class SimilarMovies extends StatelessWidget {
  final List<String>? genres;
  final int id;
  const SimilarMovies({super.key, required this.genres, required this.id});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return BlocProvider<GetSimilerMovies>(
        create: (context) => GetSimilerMovies()..getSimilerMovies(genres!, id),
        child: BlocBuilder<GetSimilerMovies, SimilerSates>(
            builder: (context, state) {
          if (state is SimilerLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SimilerErrorState) {
            return Center(
              child: Text("Erorrrr"),
            );
          }
          if (state is SimilerSuccessState) {
            var bloc = BlocProvider.of<GetSimilerMovies>(context);
            return SizedBox(
              height: 650,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  String imageUrl = bloc.movies[index].mediumCoverImage ?? "";

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRouts.movieDetails,
                          arguments: bloc.movies[index]);
                    },
                    child: FutureBuilder<bool>(
                        future: checkImageUrl(imageUrl),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CustomMoviePoster(
                                  ontap: () {
                                    Navigator.of(context).pushNamed(
                                        AppRouts.movieDetails,
                                        arguments: bloc.movies[index]);
                                  },
                                  image: bloc.movies[index].mediumCoverImage
                                      .toString(),
                                  rating: "${bloc.movies[index].rating}",
                                  height: h * 0.35,
                                  width: w * 0.45,
                                  ratingHeight: 30,
                                  ratingWidth: 60));
                        }),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
              ),
            );
          }
          return Center(
            child: Text("Someting wrong"),
          );
        }));
  }
}
