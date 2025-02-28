import 'package:flutter/material.dart';
import 'package:movies/bloc/profile/upddate/update_profile.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';
import 'package:movies/customs/avatar_item.dart';

class AvatarsSheetSection extends StatefulWidget {
  UpdateProfileBloc bloc;
  AvatarsSheetSection({super.key, required this.bloc});

  @override
  State<AvatarsSheetSection> createState() => _AvatarsSheetSectionState();
}

class _AvatarsSheetSectionState extends State<AvatarsSheetSection> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(bottom: 17, left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Scaffold(
          backgroundColor: AppColors.greyScreen,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceAround,
                      runAlignment: WrapAlignment.spaceAround,
                      children: [
                        ...List.generate(
                          AppImages.avatars.length,
                          (index) => AvatarItem(
                            ontap: () {
                              widget.bloc.avaterId = index;
                              setState(() {});
                            },
                            index: index,
                            isSelected: widget.bloc.selectedAvatar(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
