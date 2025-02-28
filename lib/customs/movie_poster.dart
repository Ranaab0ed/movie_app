import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';

class CustomMoviePoster extends StatelessWidget {
  final String image;
  final String rating;
  final double height;
  final double width;
  final double ratingHeight;
  final double ratingWidth;
  final void Function() ontap;
  const CustomMoviePoster(
      {super.key,
      required this.image,
      required this.rating,
      required this.height,
      required this.width,
      required this.ratingHeight,
      required this.ratingWidth,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: AppColors.primary)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    height: height * 0.95,
                    fit: BoxFit.cover,
                    width: width,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AppImages.logo,
                      height: height * 0.95,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    alignment: Alignment.center,
                    height: ratingHeight,
                    width: ratingWidth,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(rating),
                        const Icon(
                          Icons.star,
                          color: AppColors.button,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
