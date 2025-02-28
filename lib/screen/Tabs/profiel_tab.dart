import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/profile/get_user.dart';
import 'package:movies/bloc/profile/states.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/customs/button.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: BlocProvider(
        create: (context) => GetProfileUser()..getUser(),
        child: BlocBuilder<GetProfileUser, ProfileState>(
            builder: (context, state) {
          if (state is ProfileLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var bloc = BlocProvider.of<GetProfileUser>(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                color: AppColors.secondary,
                child: Column(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  AppImages.avatars[bloc.avaterId],
                                  height: h * 0.13,
                                  width: w * 0.25,
                                  fit: BoxFit.cover,
                                ),
                              )),
                              Text(
                                bloc.name,
                                style: textTheme.bodyLarge,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "33",
                                style: textTheme.titleSmall,
                              ),
                              Text(
                                "watch_list".tr(),
                                style: textTheme.bodyLarge,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "33",
                                style: textTheme.titleSmall,
                              ),
                              Text(
                                "history".tr(),
                                style: textTheme.bodyLarge,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    /////button
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomButton(
                            ontap: () {
                              Navigator.pushNamed(
                                  context, AppRouts.updateProfile);
                            },
                            color: AppColors.button,
                            widget: Text("edit_profile_btn".tr(),
                                style: textTheme.bodyMedium!
                                    .copyWith(color: AppColors.primary)),
                          ),
                        ),
                        Expanded(
                          child: CustomButton(
                            ontap: () {
                              bloc.logOut(context);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, AppRouts.login, (route) => false);
                            },
                            border: false,
                            color: AppColors.buttonRed,
                            widget: Row(
                              spacing: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("exit_btn".tr()),
                                Icon(
                                  Icons.exit_to_app_rounded,
                                  color: AppColors.text,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    /////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRouts.fav);
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.menu,
                                color: AppColors.button,
                                size: 40,
                              ),
                              Text("watch_list".tr())
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.folder,
                              color: AppColors.button,
                              size: 40,
                            ),
                            Text("history".tr())
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  AppImages.empty,
                  height: h * 0.2,
                  width: w * 0.4,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
