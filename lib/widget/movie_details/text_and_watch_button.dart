import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/customs/button.dart';

class TextAndWatchButton extends StatelessWidget {
  final String title;
  final String year;
  final void Function()? ontap;
  const TextAndWatchButton(
      {super.key, required this.title, required this.year, this.ontap});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          title,
          style: textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        Text(
          year,
          style: textTheme.bodyLarge!.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
        CustomButton(
          ontap: ontap,
          border: false,
          widget: Text("watch_btn".tr()),
          color: AppColors.buttonRed,
        )
      ],
    );
  }
}
