import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/fav/get_fav.dart';
import 'package:movies/bloc/states/fav%20states/get_fav_state.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/customs/movie_poster.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorite"),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => GetFavBloc()..getFav(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<GetFavBloc, GetFavState>(
                  builder: (context, state) {
                    if (state is GetFavLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is GetFavErrorState) {
                      return const Center(child: Text("فشل تحميل الأفلام"));
                    }
                    if (state is GetFavSuccessState) {
                      var bloc = BlocProvider.of<GetFavBloc>(context);
                      var movies = bloc.favModel;
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
                          image: movies[index].imageURL!,
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
      ),
    );
  }
}
