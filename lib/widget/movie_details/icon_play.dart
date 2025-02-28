import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';

class IconPlay extends StatelessWidget {
  final void Function()? ontap;
  const IconPlay({super.key, this.ontap});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: ontap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: h * 0.3,
            width: w * 0.25,
            child: CircleAvatar(
              backgroundColor: AppColors.button,
            ),
          ),
          SizedBox(
            height: h * 0.2,
            width: w * 0.225,
            child: CircleAvatar(
              backgroundColor: AppColors.text,
            ),
          ),
          SizedBox(
            height: h * 0.25,
            width: w * 0.16,
            child: CircleAvatar(
              backgroundColor: AppColors.button,
            ),
          ),
          Icon(Icons.play_arrow_rounded, size: 50, color: AppColors.text),
        ],
      ),
    );
  }
}
