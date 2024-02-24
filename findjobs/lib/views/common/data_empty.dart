import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataEmpty extends StatelessWidget {
  const DataEmpty({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/search-jobs.jpg"),
            MyText(
                text: text,
                style: appstyle(24, Color(kDark.value), FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}