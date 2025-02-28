import 'package:flutter/material.dart';

class ScreenColor extends StatelessWidget {
  final List<Color> colors;
  final double height;
  final double width;
  const ScreenColor(
      {super.key,
      required this.colors,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: colors)),
    );
  }
}
