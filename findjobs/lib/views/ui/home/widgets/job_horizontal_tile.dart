import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/models/response/job/jobs_response_model.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/width_spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobHorizontalTile extends StatelessWidget {
  const JobHorizontalTile({super.key, this.onTap, required this.job});
  final void Function()? onTap;
  final JobsResponseModel job;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          width: width * 0.7,
          height: height * 0.27,
          color: Color(kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(job.imageUrl),
                  ),
                  const WidthSpacer(size: 15),
                  MyText(
                      text: job.company,
                      style: appstyle(20, Color(kDark.value), FontWeight.w600))
                ],
              ),
              const HeightSpacer(size: 15),
              MyText(
                  text: job.title,
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600)),
              MyText(
                  text: job.location,
                  style: appstyle(16, Color(kDarkGrey.value), FontWeight.w600)),
              const HeightSpacer(size: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                          text: job.salary,
                          style: appstyle(
                              16, Color(kDark.value), FontWeight.w600)),
                      MyText(
                          text: "/${job.period}",
                          style: appstyle(
                              16, Color(kDarkGrey.value), FontWeight.w600)),
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
        ),
      ),
    );
  }
}
