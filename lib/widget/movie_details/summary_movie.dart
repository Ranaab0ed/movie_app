import 'package:flutter/material.dart';

class SummaryMovie extends StatelessWidget {
  final String title;
  const SummaryMovie({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Text(title, style: textTheme.bodyMedium);
  }
}
