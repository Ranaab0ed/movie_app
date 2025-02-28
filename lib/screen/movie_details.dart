import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/fav/add_fav.dart';
import 'package:movies/bloc/fav/check_fav.dart';
import 'package:movies/bloc/get_movie_details.dart';
import 'package:movies/bloc/states/details_movie.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';
import 'package:movies/model/fav.dart';
import 'package:movies/model/movies_model.dart';
import 'package:movies/widget/movie_details/app_bar.dart';
import 'package:movies/widget/movie_details/cast_movie.dart';
import 'package:movies/widget/movie_details/custom_gener.dart';
import 'package:movies/widget/movie_details/icon_play.dart';
import 'package:movies/widget/movie_details/icons_heart_star_clock.dart';
import 'package:movies/widget/movie_details/screen_shot.dart';
import 'package:movies/widget/movie_details/similar_movies.dart';
import 'package:movies/widget/movie_details/summary_movie.dart';
import 'package:movies/widget/movie_details/text_and_watch_button.dart';
import 'package:movies/widget/onboarding/screen_color.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    final Object? args = ModalRoute.of(context)!.settings.arguments;

    Movies? movieChossen;
    DataFav? favMovie;

    if (args is Movies) {
      movieChossen = args;
    } else if (args is DataFav) {
      favMovie = args;
    } else {
      throw Exception();
    }

    return Scaffold(
      body: BlocProvider(
        create: (context) => GetMovieDetails()
          ..getMovieDetails(
            movieChossen?.id?.toString() ?? favMovie?.movieId?.toString() ?? '',
          ),
        child: BlocBuilder<GetMovieDetails, DetailsMovieStates>(
          builder: (context, state) {
            if (state is DetailsMovieLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DetailsMovieErrorState) {
              return Center(child: Text("error_loading_movie_details".tr()));
            }

            if (state is DetailsMovieSuccessState) {
              final bloc = context.read<GetMovieDetails>();
              final movie = bloc.movie;

              if (movie == null) {
                return Center(child: Text("no_movie_details_available".tr()));
              }

              return ListView(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: movie.largeCoverImage ?? '',
                        height: size.height * 0.8,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            CachedNetworkImage(
                                imageUrl: movie.largeCoverImage ?? '',
                                height: size.height * 0.8,
                                width: size.width,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                      AppImages.logo,
                                      height: size.height * 0.8,
                                      width: size.width,
                                      fit: BoxFit.cover,
                                    )),
                      ),
                      ScreenColor(
                        height: size.height * 0.8,
                        width: double.infinity,
                        colors: [
                          AppColors.primary,
                          const Color.fromARGB(0, 18, 19, 18)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          spacing: h * 0.15,
                          children: [
                            MultiBlocProvider(
                              providers: [
                                BlocProvider(create: (context) => AddFavBloc()),
                                BlocProvider(
                                    create: (context) => CheckFavBloc()
                                      ..checkFav(bloc.movie!.id!)),
                              ],
                              child: AppBarDetails(
                                movieId: bloc.movie!.id!,
                                title: bloc.movie!.title ?? "",
                                imageURL: bloc.movie!.mediumCoverImage ?? '',
                                year: bloc.movie!.year ?? 0,
                                rating: bloc.movie!.rating ?? 0,
                              ),
                            ),
                            IconPlay(
                              ontap: () {
                                bloc.launchMovieUrl();
                              },
                            ),
                            Column(
                              spacing: h * 0.02,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextAndWatchButton(
                                  ontap: () {
                                    bloc.launchMovieUrl();
                                  },
                                  title: movie.title ?? '',
                                  year: movie.year?.toString() ?? '',
                                ),
                                IconsHeartStarClock(
                                  clock: movie.runtime?.toString() ?? '0',
                                  heart: movie.likeCount?.toString() ?? '0',
                                  star: movie.rating?.toString() ?? '0',
                                ),
                                Text(
                                  "screen_shots".tr(),
                                  style: textTheme.titleMedium,
                                ),
                                if (movie.mediumScreenshotImage1 != null)
                                  CustomScreenShot(
                                      image: movie.mediumScreenshotImage1!),
                                if (movie.mediumScreenshotImage2 != null)
                                  CustomScreenShot(
                                      image: movie.mediumScreenshotImage2!),
                                if (movie.mediumScreenshotImage3 != null)
                                  CustomScreenShot(
                                      image: movie.mediumScreenshotImage3!),
                                if (movie.genres != null)
                                  Text(
                                    "similar".tr(),
                                    style: textTheme.titleMedium,
                                  ),
                                if (movie.genres != null)
                                  SizedBox(
                                    height: h * 0.7,
                                    child: SimilarMovies(
                                      genres: movie.genres!,
                                      id: movie.id!,
                                    ),
                                  ),
                                if (movieChossen != null)
                                  if (movieChossen!.summary?.isNotEmpty ??
                                      false)
                                    Text("summary".tr(),
                                        style: textTheme.titleMedium),
                                if (movieChossen != null)
                                  SummaryMovie(
                                      title: movieChossen!.summary ?? ''),
                                if (movie.cast != null &&
                                    movie.cast!.isNotEmpty)
                                  Text("cast".tr(),
                                      style: textTheme.titleMedium),
                                if (movie.cast != null)
                                  ...movie.cast!.map((cast) => CastMovie(
                                        name: cast.name ?? '',
                                        character: cast.characterName ?? '',
                                        image: cast.urlSmallImage ?? '',
                                      )),
                                if (movie.genres != null)
                                  Text("genres".tr(),
                                      style: textTheme.titleMedium),
                                Wrap(
                                    spacing: 5,
                                    runSpacing: 10,
                                    children: movie.genres!
                                        .map((genre) =>
                                            CustomGenre(genre: genre))
                                        .toList()),
                                SizedBox(height: h * 0.05)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            }

            return Center(child: Text("unexpected_error".tr()));
          },
        ),
      ),
    );
  }
}
