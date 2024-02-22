import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_button.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:flutter/material.dart';

class DiviceInfo extends StatelessWidget {
  const DiviceInfo(
      {super.key,
      required this.location,
      required this.device,
      required this.platform,
      required this.date,
      required this.ipAdress});
  final String location;
  final String device;
  final String platform;
  final String date;
  final String ipAdress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
            text: platform,
            style: appstyle(22, Color(kDark.value), FontWeight.bold)),
        MyText(
            text: device,
            style: appstyle(22, Color(kDark.value), FontWeight.bold)),
        const HeightSpacer(size: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                    text: date,
                    style: appstyle(16, Color(kDarkGrey.value), FontWeight.w400)),
                MyText(
                    text: ipAdress,
                    style: appstyle(16, Color(kDarkGrey.value), FontWeight.w400)),
              ],
            ),
            MyButton(
              heightBtn: height * 0.05,
              widthBtn: width * 0.5,
              text: "Sign Out",
              backgroundColor: Color(kOrange.value),
              textColor: Color(kLight.value),
            )
          ],
        ),
      ],
    );
  }
}
