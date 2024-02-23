import 'package:findjobs/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalTileWidget extends StatelessWidget {
  const HorizontalTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          height: height * 0.15,
          width: width,
          color: Color(kDarkGrey.value),
        ),
      ),
    );
  }
}
