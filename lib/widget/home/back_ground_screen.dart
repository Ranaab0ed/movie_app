import 'package:flutter/material.dart';
import 'package:movies/core/class/app_images.dart';

class BackGroundScreen extends StatelessWidget {
  const BackGroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.onboarding6,
    );
  }
}
