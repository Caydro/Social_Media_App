import 'package:collagiey/Core/Colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.controller,
      required this.obtScure,
      this.onSub});
  final String? hintText;
  final Icon? suffixIcon;
  final Function()? onSub;
  final obtScure;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.length < 7 || value.isEmpty) {
          return "Please enter Some Data";
        }
      },
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obtScure,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: (text) {
        onSub!();
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: CaydroColors.mainColor,
            width: 2,
          ),
        ),
        hintText: hintText,
        suffix: suffixIcon,
        suffixIconColor: CaydroColors.mainColor,
      ),
    );
  }
}
