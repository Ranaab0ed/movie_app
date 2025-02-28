import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/get_explore.dart';
import 'package:movies/bloc/states/explor_states.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/core/const/genre_list.dart';
import 'package:movies/customs/movie_poster.dart';
import 'package:movies/widget/explore/list_choose.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  int _currentIndex = 0;
  late GetExplore getExploreBloc;

  @override
  void initState() {
    super.initState();
    getExploreBloc = GetExplore()..getExplore(genre[_currentIndex]);
  }

  @override
  void dispose() {
    getExploreBloc.close();
    super.dispose();
  }

  void _onSelected(int i) {
    if (_currentIndex != i) {
      setState(() {
        _currentIndex = i;
        getExploreBloc.getExplore(genre[_currentIndex]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: BlocProvider(
        create: (context) => getExploreBloc,
        child: Column(
          children: [
            ListChoose(
              onSelected: _onSelected,
              selected: _currentIndex,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocConsumer<GetExplore, ExploreState>(
                listener: (context, state) {
                  if (state is ExploreErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('حدث خطأ أثناء تحميل البيانات')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ExploreLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ExploreErrorState) {
                    return const Center(child: Text("فشل تحميل الأفلام"));
                  }
                  if (state is ExploreSuccessState) {
                    var movies = getExploreBloc.movies;
                    if (movies.isEmpty) {
                      return const Center(
                          child: Text("لم يتم العثور على أفلام"));
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: movies.length > 30 ? 30 : movies.length,
                      itemBuilder: (context, index) => CustomMoviePoster(
                        ontap: () {
                          Navigator.of(context).pushNamed(
                            AppRouts.movieDetails,
                            arguments: movies[index],
                          );
                        },
                        image: movies[index].mediumCoverImage!,
                        rating: movies[index].rating.toString(),
                        height: h * 0.35,
                        width: w * 0.45,
                        ratingHeight: 35,
                        ratingWidth: 70,
                      ),
                    );
                  }
                  return const Center(child: Text("لا توجد بيانات "));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
