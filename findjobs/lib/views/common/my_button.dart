import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      this.heightBtn,
      this.widthBtn,
      required this.text,
      required this.backgroundColor,
      this.onTap,
      required this.textColor,
      this.borderColor});
  final double? heightBtn;
  final double? widthBtn;
  final String text;
  final Color backgroundColor;
  final void Function()? onTap;
  final Color textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: widthBtn ?? (height * 0.06),
        height: heightBtn ?? (width * 0.4),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor ?? backgroundColor, width: 1)),
        child: Center(
            child: MyText(
                text: text, style: appstyle(16, textColor, FontWeight.w600))),
      ),
    );
  }
}
