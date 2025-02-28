import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget? widget;
  final Color color;

  final bool border;
  final void Function()? ontap;
  const CustomButton(
      {super.key,
      this.border = true,
      required this.widget,
      this.color = AppColors.button,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(10),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              border: border
                  ? Border.all(width: 1, color: AppColors.button)
                  : null),
          child: widget),
    );
  }
}
