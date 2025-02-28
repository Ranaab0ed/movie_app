import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';

class LangModeBtn extends StatelessWidget {
  LangModeBtn({super.key, required this.mode});
  bool mode;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30,
        width: 73,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.button, width: 2),
            borderRadius: BorderRadius.circular(30)),
        child: _onSelectMode(
          context,
          mode: mode,
        ));
  }

  Widget _onSelectMode(BuildContext context, {required bool mode}) {
    return mode == false
        ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 3, color:  AppColors.button),
                  shape: BoxShape.circle,
                  color:  AppColors.button,
                ),
                child: Image.asset(AppImages.usaIcon)),
            Image.asset(AppImages.egIcon),
          ])
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                AppImages.usaIcon,
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 3, color:  AppColors.button),
                    shape: BoxShape.circle,
                    color:  AppColors.button,
                  ),
                  child: Image.asset(
                    AppImages.egIcon,
                  )),
            ],
          );
  }
}
