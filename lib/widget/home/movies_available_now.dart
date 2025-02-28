import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/home/get_movies_avilable_now.dart';
import 'package:movies/customs/movie_poster.dart';

import '../../core/class/app_rout.dart';

class MoviesAvailableNow extends StatefulWidget {
  final String image;
  final double currentPage;
  final PageController pageController;
  const MoviesAvailableNow(
      {super.key,
      required this.pageController,
      required this.currentPage,
      required this.image});

  @override
  State<MoviesAvailableNow> createState() => _MoviesAvailableNowState();
}

class _MoviesAvailableNowState extends State<MoviesAvailableNow> {
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
        controller: widget.pageController,
        itemCount: 20,
        itemBuilder: (context, index) {
          double scale = (widget.currentPage - index).abs() <= 1
              ? 1 - (widget.currentPage - index).abs() * 0.3
              : 0.7;
          var bloc = BlocProvider.of<GetMoviesAvailableNow>(context);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                  scale: scale,
                  child: CustomMoviePoster(
                      ontap: () {
                        Navigator.of(context).pushNamed(AppRouts.movieDetails,
                            arguments: bloc.moviesAvailableNow![index]);
                      },
                      image:
                          "${bloc.moviesAvailableNow?[index].largeCoverImage!}",
                      rating: "${bloc.moviesAvailableNow?[index].rating}",
                      height: 310,
                      width: double.infinity,
                      ratingHeight: 30,
                      ratingWidth: 50)),
            ],
          );
        },
      ),
    );
  }
}
