import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/customs/button.dart';

class TextAndButton extends StatelessWidget {
  final String title;
  final String description;
  final String titleButton;
  final String secondTItleButton;
  final int i;
  final Function() ontapTItleButton;
  final Function() ontapSecondTItleButton;
  const TextAndButton(
      {super.key,
      required this.title,
      required this.description,
      this.i = 0,
      this.titleButton = "Next",
      this.secondTItleButton = "Back",
      required this.ontapTItleButton,
      required this.ontapSecondTItleButton});

  @override
  Widget build(BuildContext context) {
    TextTheme textStyle = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: i > 0
              ? BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                )
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 0,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: i > 0 ? textStyle.titleSmall : textStyle.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Text(
                  description,
                  style: textStyle.bodyMedium!.copyWith(
                      color: i > 0
                          ? AppColors.text
                          : AppColors.text.withOpacity(0.5)),
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                onTap: ontapTItleButton,
                child: CustomButton(
                  widget: i > 4
                      ? Text(
                          "finish_btn".tr(),
                          style: TextStyle(color: AppColors.primary),
                        )
                      : Text(
                          "next_btn".tr(),
                          style: TextStyle(color: AppColors.primary),
                        ),
                ),
              ),
              i > 0
                  ? i >= 2
                      ? InkWell(
                          onTap: ontapSecondTItleButton,
                          child: CustomButton(
                            widget: Text(
                              "back_btn".tr(),
                            ),
                            color: Colors.transparent,
                          ),
                        )
                      : SizedBox()
                  : SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
