import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/bloc/auth/rest_pass.dart';
import 'package:movies/bloc/states/auth/rest_pass.dart';
import 'package:movies/core/class/app_colors.dart';
import 'package:movies/customs/button.dart';
import 'package:movies/customs/input_field.dart';
import 'package:movies/function/validate/pass_validate.dart';

class RestPass extends StatelessWidget {
  const RestPass({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RestPassBloc>(
      create: (context) => RestPassBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Rest Password"),
        ),
        body: BlocConsumer<RestPassBloc, RestPassStates>(
            listener: (context, state) {
          if (state is RestPasLoadingState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                  title: Text("Loading.."),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )),
            );
          }
          if (state is RestPassErrorState) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Error"),
                content: Column(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Your old password is wrong ",
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
                            Text("Try again")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is RestPassSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          var bloc = BlocProvider.of<RestPassBloc>(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: bloc.formKey,
                child: Column(
                  spacing: 20,
                  children: [
                    InputField(
                      controller: bloc.oldPass,
                      lable: "Old password",
                      validate: (pass) => passValidate(pass, 8, 30),
                    ),
                    InputField(
                      controller: bloc.newPass,
                      lable: "New password",
                      validate: (pass) => passValidate(pass, 8, 30),
                    )
                  ],
                ),
              ),
              CustomButton(
                widget: Text("Done"),
                color: AppColors.button,
                ontap: () {
                  bloc.restPass();
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
