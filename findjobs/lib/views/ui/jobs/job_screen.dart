import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/common/my_button.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.title, required this.id});
  final String title;
  final String id;
  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: MyAppBar(
            text: widget.title,
            actions: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(CupertinoIcons.bookmark),
              )
            ],
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left),
            ),
          )),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  const HeightSpacer(size: 30),
                  Container(
                      width: width,
                      height: height * 0.27,
                      color: Color(kLightGrey.value),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/logo.jpg"),
                          ),
                          const HeightSpacer(size: 10),
                          MyText(
                              text: "Senior Flutter Developer",
                              style: appstyle(
                                  22, Color(kDark.value), FontWeight.w600)),
                          const HeightSpacer(size: 5),
                          MyText(
                              text: "Ho Chi Minh",
                              style: appstyle(
                                  16, Color(kDark.value), FontWeight.w600)),
                          const HeightSpacer(size: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                    text: "Full-time",
                                    backgroundColor: Color(kOrange.value),
                                    textColor: Color(kLight.value)),
                                Row(
                                  children: [
                                    MyText(
                                        text: "10k",
                                        style: appstyle(22, Color(kDark.value),
                                            FontWeight.w600)),
                                    SizedBox(
                                      width: width * 0.2,
                                      child: MyText(
                                          text: "/monthly",
                                          style: appstyle(
                                              22,
                                              Color(kDark.value),
                                              FontWeight.w600)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  const HeightSpacer(size: 20),
                  MyText(
                      text: "Job Description",
                      style: appstyle(22, Color(kDark.value), FontWeight.w600)),
                  const HeightSpacer(size: 10),
                  Text(desc,
                      textAlign: TextAlign.justify,
                      maxLines: 8,
                      style: appstyle(
                          22, Color(kDarkGrey.value), FontWeight.normal)),
                  const HeightSpacer(size: 20),
                  MyText(
                      text: "Requirements",
                      style: appstyle(22, Color(kDark.value), FontWeight.w600)),
                  const HeightSpacer(size: 10),
                  SizedBox(
                    height: height * 0.6,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: requirements.length,
                        itemBuilder: (context, index) {
                          final req = requirements[index];
                          String bullet = "\u2022";
                          return Text("$bullet $req\n",
                              maxLines: 4,
                              textAlign: TextAlign.justify,
                              style: appstyle(
                                  22, Color(kDark.value), FontWeight.w600));
                        }),
                  ),
                  const HeightSpacer(size: 20),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: MyButton(
                      onTap: () {
                        
                      },
                      widthBtn: width,
                      heightBtn: height * 0.06,
                      text: "Apply Now",
                      backgroundColor: Color(kOrange.value),
                      textColor: Color(kLight.value)),
                ),
              )
            ],
          )),
    );
  }
}
