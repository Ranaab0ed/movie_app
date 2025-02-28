import 'package:flutter/widgets.dart';
import 'package:movies/core/const/genre_list.dart';
import 'package:movies/widget/explore/choose_button.dart';

class ListChoose extends StatelessWidget {
  final int selected;
  final void Function(int)? onSelected;

  const ListChoose(
      {super.key, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          genre.length,
          (index) => GestureDetector(
            onTap: () {
              if (onSelected != null) {
                onSelected!(index);
              }
            },
            child: ChooseButton(isSelected: selected == index, index: index),
          ),
        ),
      ),
    );
  }
}
