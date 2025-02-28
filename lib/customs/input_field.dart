import 'package:flutter/material.dart';
import 'package:movies/core/class/app_colors.dart';

class InputField extends StatelessWidget {
  final String lable;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function validate;
  void Function(String)? onClick;
  final TextEditingController? controller;
  final bool isObscure;
  InputField(
      {super.key,
      this.lable = "",
      required this.validate,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.isObscure = false,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onClick,
      validator: (value) => validate(value),
      controller: controller,
      obscureText: isObscure,
      cursorColor: AppColors.text,
      decoration: InputDecoration(
        hintText: lable,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.secondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.greyScreen),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.greyScreen),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }
}
