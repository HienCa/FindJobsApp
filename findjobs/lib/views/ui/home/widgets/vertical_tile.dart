import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/models/response/job/jobs_response_model.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/width_spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalTile extends StatelessWidget {
  const VerticalTile({super.key, this.onTap, required this.job});
  final void Function()? onTap;
  final JobsResponseModel job;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        height: height * 0.16,
        width: width,
        color: Color(kLightGrey.value),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(kLightGrey.value),
                      radius: 30,
                      backgroundImage: NetworkImage(job.imageUrl),
                    ),
                    const WidthSpacer(size: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                            text: job.company,
                            style: appstyle(
                                20, Color(kDark.value), FontWeight.w600)),
                        SizedBox(
                          width: width * 0.5,
                          child: MyText(
                              text: job.title,
                              style: appstyle(
                                  20, Color(kDarkGrey.value), FontWeight.w600)),
                        )
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(kLight.value),
                      child: const Icon(CupertinoIcons.chevron_forward),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Row(
                children: [
                  MyText(
                      text: job.salary,
                      style: appstyle(16, Color(kDark.value), FontWeight.w600)),
                  MyText(
                      text: "/${job.period}",
                      style:
                          appstyle(16, Color(kDarkGrey.value), FontWeight.w600))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
