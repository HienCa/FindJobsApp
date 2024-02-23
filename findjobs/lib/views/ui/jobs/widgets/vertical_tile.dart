import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/models/response/job/job_response_model.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/width_spacer.dart';
import 'package:findjobs/views/ui/jobs/job_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VerticalTileWidget extends StatelessWidget {
  const VerticalTileWidget({super.key, required this.job});
  final JobResponseModel job;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          Get.to(() => JobPage(title: job.company, id: job.id));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          height: height * 0.15,
          width: width,
          color: Color(kLightGrey.value),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(job.imageUrl),
                        ),
                        const WidthSpacer(size: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyText(
                                text: job.company,
                                style: appstyle(
                                    20, Color(kDark.value), FontWeight.w600)),
                            SizedBox(
                              width: width * 0.5,
                              child: MyText(
                                  text: job.title,
                                  style: appstyle(20, Color(kDarkGrey.value),
                                      FontWeight.w600)),
                            )
                          ],
                        ),
                      ]),
                  CircleAvatar(
                    radius: 18,
                    child: Icon(
                      CupertinoIcons.chevron_forward,
                      color: Color(kOrange.value),
                    ),
                  )
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(left: 65.w),
                  child: Row(
                    children: [
                      MyText(
                          text: job.salary,
                          style: appstyle(
                              20, Color(kDark.value), FontWeight.w600)),
                      MyText(
                          text: "/${job.period}",
                          style: appstyle(
                              20, Color(kDarkGrey.value), FontWeight.w600)),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
