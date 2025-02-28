import 'package:flutter/material.dart';
import 'package:movies/core/class/app_images.dart';
import 'package:movies/widget/movie_details/custom/custom_container.dart';

class IconsHeartStarClock extends StatelessWidget {
  final String heart;
  final String star;
  final String clock;
  const IconsHeartStarClock(
      {super.key,
      required this.heart,
      required this.star,
      required this.clock});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Row(
      spacing: w * 0.03,
      children: [
        CustomContainer(title: heart, icon: AppImages.heart),
        CustomContainer(title: clock, icon: AppImages.clock),
        CustomContainer(title: star, icon: AppImages.star),
      ],
    );
  }
}
