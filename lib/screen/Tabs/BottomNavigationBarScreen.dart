import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/bottom_nav/buttom_na.dart';
import 'package:movies/bloc/states/bottom_nav/buttom_nav.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';
import 'package:movies/screen/Tabs/explore_tab.dart';
import 'package:movies/screen/Tabs/home.dart';
import 'package:movies/screen/Tabs/profiel_tab.dart';
import 'package:movies/screen/Tabs/search_tab.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  static const String roteName = "BottomNavigationBarScreen";
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _bottomState();
}

class _bottomState extends State<BottomNavigationBarScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ButtomNavBloc>(
      create: (context) => ButtomNavBloc(),
      child: BlocConsumer<ButtomNavBloc, ButtomNavState>(
          listener: (context, state) {},
          builder: (context, state) {
            var bloc = BlocProvider.of<ButtomNavBloc>(context);
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  onTap: (value) {
                    bloc.changePage(value);
                  },
                  currentIndex: bloc.currentIndex,
                  backgroundColor: AppColors.secondary,
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  selectedItemColor: AppColors.button,
                  unselectedItemColor: AppColors.text,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  items: [
                    BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage(AppImages.home)), label: ""),
                    BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage(AppImages.search)),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage(AppImages.explore)),
                        label: ""),
                    BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage(AppImages.profile)),
                        label: ""),
                  ]),
              body: tabs[bloc.currentIndex],
            );
          }),
    );
  }

  List<Widget> tabs = [
    Home(),
    SearchTab(),
    ExploreTab(),
    ProfileTab(),
  ];
}
