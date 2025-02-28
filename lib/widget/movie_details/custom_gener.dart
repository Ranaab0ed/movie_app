import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';

class CustomGenre extends StatelessWidget {
  final String genre;
  const CustomGenre({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          alignment: Alignment.center,

          // width: 110,
          decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            genre,
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
