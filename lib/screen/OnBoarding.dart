import 'package:flutter/material.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/widget/onboarding/screen_color.dart';
import 'package:movies/widget/onboarding/static/onboarding_list.dart';
import 'package:movies/widget/onboarding/text_and_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({
    super.key,
  });

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int i = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            i = index;
          });
        },
        itemCount: 6,
        itemBuilder: (context, index) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Image.asset(onBoarding[index]["image"])),
            ScreenColor(
              height: 300,
              width: double.infinity,
              colors: onBoarding[index]['colors'],
            ),
            index == 0
                ? TextAndButton(
                    ontapTItleButton: () {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutCirc);

                      setState(() {});
                    },
                    ontapSecondTItleButton: () {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInSine);

                      setState(() {});
                    },
                    title: "${onBoarding[index]["title"]}",
                    description: "${onBoarding[index]["description"]}",
                  )
                : TextAndButton(
                    ontapTItleButton: () async {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeOutCirc);
                      if (index == 5) {
                        SharedPreferences shPre =
                            await SharedPreferences.getInstance();
                        shPre.setBool("skipOnBoarding", true);
                        Navigator.pushNamed(context, AppRouts.login);
                      }
                      ;
                      setState(() {});
                    },
                    ontapSecondTItleButton: () {
                      _pageController.previousPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInSine);
                      setState(() {});
                    },
                    i: index,
                    title: onBoarding[index]['title'],
                    description: onBoarding[index]['description'])
          ],
        ),
      ),
    );
  }
}
