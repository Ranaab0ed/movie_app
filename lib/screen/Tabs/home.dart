import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/bottom_nav/buttom_na.dart';
import 'package:movies/bloc/home/get_all_movies.dart';
import 'package:movies/bloc/home/get_movies_avilable_now.dart';
import 'package:movies/bloc/states/bloc_home_states.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/customs/movie_poster.dart';
import 'package:movies/customs/title_list.dart';
import 'package:movies/widget/home/movies_available_now.dart';
import 'package:movies/widget/onboarding/screen_color.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.55);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                GetMoviesAvailableNow()..getMoviesAvailableNow()),
        BlocProvider(create: (context) => HomeGetMovies()..getMovies()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<GetMoviesAvailableNow, HomeStates>(
            builder: (context, state) {
              if (state is HomeGetLoadingStateMVN) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is HomeGetErrorStateMVN) {
                return Center(child: Text("Error loading movies"));
              }
              if (state is HomeGetSuccessStateMAN) {
                var blocAvailableNow = context.read<GetMoviesAvailableNow>();

                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    CachedNetworkImage(
                      imageUrl: blocAvailableNow
                          .moviesAvailableNow![_currentPage.toInt()]
                          .largeCoverImage!,
                      height: h * 0.8,
                      width: w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppImages.logo,
                        height: h * 0.8,
                        width: w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ScreenColor(
                        height: h * 0.8,
                        width: double.infinity,
                        colors: [
                          AppColors.primary,
                          const Color.fromARGB(183, 40, 47, 40),
                          const Color.fromARGB(172, 18, 19, 18),
                        ]),
                    ListView(
                      children: [
                        SizedBox(height: 10),
                        /////////////////////////////////////////////////////////////
                        ////////////////////// image availableNow //////////////////
                        /////////////////////////////////////////////////////////////
                        Image.asset(AppImages.availableNow),
                        /////////////////////////////////////////////////////////////
                        ////////////////////// movies availableNow //////////////////
                        /////////////////////////////////////////////////////////////
                        MoviesAvailableNow(
                          image: blocAvailableNow
                                  .moviesAvailableNow![_currentPage.toInt()]
                                  .mediumCoverImage! ??
                              "",
                          pageController: _pageController,
                          currentPage: _currentPage,
                        ),
                        SizedBox(height: 10),

                        /////////////////////////////////////////////////////////////
                        ////////////////////// image watch now //////////////////
                        /////////////////////////////////////////////////////////////
                        Image.asset(AppImages.watchNow),

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////// TITLE WATCH MORE /////////////////////////......//////
/////////////////////////////////////////////////////////////////////////////////////////////////////
                        CustomTitleList(
                            ontap: () {
                              var bloc =
                                  BlocProvider.of<ButtomNavBloc>(context);
                              bloc.changePage(2);
                            },
                            title: "Action",
                            subTitle: "See more"),
                        SizedBox(height: 16),
                        /////////////////////////////////////////////////////////////
                        //////////////////////  BLOC NUMBER 2  //////////////////
                        /////////////////////////////////////////////////////////////
                        BlocBuilder<HomeGetMovies, HomeStates>(
                          builder: (context, state) {
                            /////////////////////////////////////////////////////////////
                            ////////////////////// LOADING //////////////////
                            /////////////////////////////////////////////////////////////
                            if (state is HomeGetLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            }

                            /////////////////////////////////////////////////////////////
                            ////////////////////// ERROR //////////////////
                            /////////////////////////////////////////////////////////////
                            if (state is HomeGetErrorState) {
                              return Center(
                                  child: Text("Error loading movies"));
                            }

                            /////////////////////////////////////////////////////////////
                            ////////////////////// SUCCESS //////////////////////////////
                            /////////////////////////////////////////////////////////////
                            if (state is HomeGetSuccessState) {
                              var bloc = context.read<HomeGetMovies>();
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: SizedBox(
                                  height: 300,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 16),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, index) =>

/////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////// POSTER /////////////////////////......//////
/////////////////////////////////////////////////////////////////////////////////////////////////////
                                        CustomMoviePoster(
                                      ontap: () {
                                        Navigator.of(context).pushNamed(
                                            AppRouts.movieDetails,
                                            arguments: bloc.moviesAll![index]);
                                      },
                                      image: bloc.moviesAll?[index]
                                              .mediumCoverImage ??
                                          "",
                                      rating:
                                          '${bloc.moviesAll?[index].rating}',
                                      height: 250,
                                      width: 150,
                                      ratingHeight: 30,
                                      ratingWidth: 50,
                                    ),
                                  ),
                                ),
                              );
                            }

                            /////////////////////////////////////////////////////////////
                            ////////////////////// ERROR //////////////////////////////
                            /////////////////////////////////////////////////////////////
                            return Center(child: Text("No movies available"));
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }
              return Center(child: Text(" error"));
            },
          ),
        ),
      ),
    );
  }
}
