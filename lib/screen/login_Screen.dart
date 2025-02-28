import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/auth/login.dart';
import 'package:movies/bloc/states/auth/login_states.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/core/class/app_images.dart';
import 'package:movies/core/class/app_rout.dart';
import 'package:movies/customs/input_field.dart';
import 'package:movies/customs/lang_mode_btn.dart';
import 'package:movies/function/validate/email_validate.dart';
import 'package:movies/function/validate/pass_validate.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool langMode = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogInUser>(
      create: (context) => LogInUser(),
      child: Scaffold(
        body: BlocConsumer<LogInUser, LogInStates>(listener: (context, state) {
          if (state is LogInLoadingState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Text("loading".tr()),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )),
            );
          }
          if (state is LogInErrorState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("error".tr()),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "email_or_password_is_wrong".tr(),
                      style: TextStyle(color: AppColors.primary),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColors.buttonRed,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.rotate_left, color: AppColors.text),
                            Text("try_again".tr())
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is LogInSuccessState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouts.bottonNavigator, (Route<dynamic> route) => false);
          }
        }, builder: (context, state) {
          var bloc = BlocProvider.of<LogInUser>(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: Form(
                key: bloc.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      AppImages.logo,
                      height: 250,
                    ),
                    InputField(
                      controller: bloc.emailController,
                      validate: (val) =>
                          emailValidate(bloc.emailController.text),
                      lable: "email".tr(),
                      prefixIcon: Image.asset(AppImages.emailIcon),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 22, bottom: 17),
                      child: InputField(
                        controller: bloc.passwordController,
                        validate: (val) =>
                            passValidate(bloc.passwordController.text, 8, 25),
                        lable: "password".tr(),
                        prefixIcon: Image.asset(AppImages.passwordIcon),
                        suffixIcon: Icon(
                          Icons.visibility_off_rounded,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    //   Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       Navigator.pushNamed(context, AppRouts.forgetPass);
                    //     },
                    //     child: Text(
                    //       "forget_password".tr(),
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyMedium!
                    //           .copyWith(fontSize: 14, color: AppColors.button),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 33, bottom: 22),
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.logIn();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Text(
                            "login_btn".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: AppColors.textThird),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "don’t_have_account".tr(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouts.register);
                          },
                          child: Text(
                            "create_one".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 14, color: AppColors.button),
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 27, bottom: 28),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Expanded(
                    //         child: Divider(
                    //           color: AppColors.button,
                    //           endIndent: 11,
                    //           indent: 90,
                    //         ),
                    //       ),
                    //       Text(
                    //         "or".tr(),
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyMedium!
                    //             .copyWith(color: AppColors.button),
                    //       ),
                    //       Expanded(
                    //         child: Divider(
                    //           color: AppColors.button,
                    //           endIndent: 90,
                    //           indent: 11,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 33),
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(vertical: 18),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Image.asset(AppImages.googleIcon),
                    //           SizedBox(
                    //             width: 11,
                    //           ),
                    //           Text(
                    //             "login_with_Google_btn".tr(),
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyMedium!
                    //                 .copyWith(color: AppColors.textThird),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              langMode = !langMode;
                              if (langMode == false) {
                                context.setLocale(Locale("en"));
                              } else {
                                context.setLocale(Locale("ar"));
                              }
                              setState(() {});
                            },
                            child: LangModeBtn(mode: langMode)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
