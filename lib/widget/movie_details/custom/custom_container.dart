import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final String title;
  final String icon;
  const CustomContainer({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        height: h * 0.05,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon),
            Text(
              title,
              style: textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
