import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/width_spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.ontap});
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: width * 0.81,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(CupertinoIcons.search,
                      color: Color(kOrange.value), size: 20.h),
                  const WidthSpacer(size: 20),
                  MyText(
                      text: "Search for jobs",
                      style:
                          appstyle(18, Color(kOrange.value), FontWeight.w500))
                ]),
              ),
              Icon(CupertinoIcons.sidebar_left,
                  color: Color(kDarkGrey.value), size: 20.h)
            ],
          ),
          const HeightSpacer(size: 7),
          Divider(
            color: Color(kDarkGrey.value),
            thickness: 0.5,
            endIndent: 40.w,
          )
        ],
      ),
    );
  }
}
