import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/get_search.dart';
import 'package:movies/bloc/states/search_movies.dart';
import 'package:movies/core/class/app_images.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/customs/input_field.dart';
import 'package:movies/customs/movie_poster.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  late TextEditingController cTextSearch;

  @override
  void initState() {
    cTextSearch = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cTextSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    double w = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => GetSearchMovies(),
      child: Builder(
        builder: (context) {
          var bloc = context.read<GetSearchMovies>();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 21),
                  InputField(
                    onClick: (v) {
                      if (v != null && v.isNotEmpty) {
                        bloc.getSearchMovies(v);
                      }
                    },
                    validate: () {},
                    controller: cTextSearch,
                    lable: "search".tr(),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        AppImages.search,
                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                  BlocBuilder<GetSearchMovies, SearchMoviesStates>(
                    builder: (context, state) {
                      if (state is SearchMoviesLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is SearchMoviesErrorStates) {
                        return const Center(child: Text("Error"));
                      }
                      if (state is SearchMoviesEmptyStates) {
                        return Center(child: Image.asset(AppImages.empty));
                      }
                      if (state is SearchMoviesSuccessStates) {
                        return Expanded(
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.6,
                              ),
                              itemCount: bloc.movies.length > 20
                                  ? 20
                                  : bloc.movies.length,
                              itemBuilder: (context, index) =>
                                  CustomMoviePoster(
                                      ontap: () {
                                        Navigator.of(context).pushNamed(
                                            AppRouts.movieDetails,
                                            arguments: bloc.movies![index]);
                                      },
                                      image:
                                          bloc.movies[index].mediumCoverImage!,
                                      rating:
                                          bloc.movies[index].rating.toString(),
                                      height: h * 0.35,
                                      width: w * 0.45,
                                      ratingHeight: 35,
                                      ratingWidth: 70)),
                        );
                      }
                      return Expanded(
                        child: Image.asset(
                          AppImages.empty,
                          height: h * 0.3,
                          width: w * 0.4,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
