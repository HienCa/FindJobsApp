import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyText(
            text: text,
            style: appstyle(20, Color(kDark.value), FontWeight.w600)),
        GestureDetector(
          onTap: onTap,
          child: MyText(
              text: "View all",
              style: appstyle(18, Color(kDark.value), FontWeight.w500)),
        )
      ],
    );
  }
}
