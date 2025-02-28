import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';

List<Map<String, dynamic>> onBoarding = [
  {
    "title": "onboarding_1_title".tr(),
    "description": "onboarding_1_content".tr(),
    "image": AppImages.onboarding1,
    "colors": [
      AppColors.primary,
      const Color.fromARGB(142, 18, 19, 18),
      const Color.fromARGB(0, 255, 255, 255)
    ]
  },
  {
    "title": "onboarding_2_title".tr(),
    "description": "onboarding_2_content".tr(),
    "image": AppImages.onboarding2,
    "colors": [
      AppColors.blueScreen,
      const Color.fromARGB(126, 8, 66, 80),
      const Color.fromARGB(0, 8, 66, 80),
    ]
  },
  {
    "title": "onboarding_3_title".tr(),
    "description": "onboarding_3_content".tr(),
    "image": AppImages.onboarding3,
    "colors": [
      AppColors.redScreen,
      const Color.fromARGB(54, 133, 34, 14),
      const Color.fromARGB(0, 133, 34, 14),
    ]
  },
  {
    "title": "onboarding_4_title".tr(),
    "description": "onboarding_4_content".tr(),
    "image": AppImages.onboarding4,
    "colors": [
      AppColors.moveScreen,
      const Color.fromARGB(114, 76, 36, 113),
      const Color.fromARGB(0, 76, 36, 113),
    ]
  },
  {
    "title": "onboarding_5_title".tr(),
    "description": "onboarding_5_content".tr(),
    "image": AppImages.onboarding5,
    "colors": [
      AppColors.redSecondScreen,
      const Color.fromARGB(131, 96, 19, 33),
      const Color.fromARGB(0, 96, 19, 33),
    ]
  },
  {
    "title": "onboarding_6_title".tr(),
    "description": "",
    "image": AppImages.onboarding6,
    "colors": [
      AppColors.greyScreen,
      const Color.fromARGB(109, 42, 44, 48),
      const Color.fromARGB(0, 42, 44, 48),
    ]
  },
];
