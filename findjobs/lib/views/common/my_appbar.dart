import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar(
      {super.key,
      required this.text,
       this.child,
       this.actions});
  final String? text;
  final Widget? child;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(),
      backgroundColor: Color(kLight.value),
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 70.w,
      title: MyText(
          text: text ?? "",
          style: appstyle(16, Color(kDark.value), FontWeight.w600)),
      leading: child ?? const Icon(CupertinoIcons.arrow_left),
      centerTitle: true,
      actions: actions,
    );
  }
}
