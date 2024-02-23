import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyboardType,
      this.suffixIcon,
      this.obscureText,
      this.validator,
      this.prefixIcon,
      this.onEditingComplete});
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(kLightGrey.value),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintStyle: appstyle(14, Color(kDarkGrey.value), FontWeight.w500),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.red, width: 0.5)),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.zero,
                borderSide: BorderSide(color: Colors.transparent, width: 0)),
            border: InputBorder.none),
        controller: controller,
        cursorHeight: 25,
        style: appstyle(14, Color(kDark.value), FontWeight.w500),
        validator: validator,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
