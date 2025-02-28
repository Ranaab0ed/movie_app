import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/fav/add_fav.dart';
import 'package:movies/bloc/fav/check_fav.dart';
import 'package:movies/bloc/states/fav%20states/check_fav_state.dart';
import 'package:movies/core/class/app_colors.dart';

class AppBarDetails extends StatelessWidget {
  final int movieId;
  final String title;
  final int year;
  final num rating;
  final String imageURL;

  const AppBarDetails({
    super.key,
    required this.movieId,
    required this.title,
    required this.year,
    required this.rating,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    final addFavBloc = BlocProvider.of<AddFavBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.text,
            size: 30,
          ),
        ),
        BlocBuilder<CheckFavBloc, CheckFavState>(
          builder: (context, state) {
            bool isFav = state is CheckFavSuccessState;
            return IconButton(
              onPressed: () async {
                if (isFav) {
                  await addFavBloc.removeFav(movieId);
                } else {
                  await addFavBloc.addFav(
                      movieId, title, rating, imageURL, year);
                }
                context.read<CheckFavBloc>().checkFav(movieId);
              },
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? AppColors.buttonRed : AppColors.text,
                size: 30,
              ),
            );
          },
        ),
      ],
    );
  }
}
