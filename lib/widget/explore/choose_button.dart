import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/const/genre_list.dart';

class ChooseButton extends StatefulWidget {
  final bool isSelected;
  final int index;
  const ChooseButton(
      {super.key, required this.isSelected, required this.index});

  @override
  State<ChooseButton> createState() => _ChooseButtonState();
}

class _ChooseButtonState extends State<ChooseButton> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        margin: EdgeInsets.only(left: w * 0.03),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppColors.button),
            color: widget.isSelected ? AppColors.button : Colors.transparent,
            borderRadius: BorderRadius.circular(16)),
        child: Text(
          genre[widget.index],
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: widget.isSelected ? AppColors.primary : AppColors.button),
        ));
  }
}
