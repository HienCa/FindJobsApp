import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Color(kDarkBlue.value),
      child: Column(
        children: [
          const HeightSpacer(size: 70),
          Lottie.asset('assets/animations/pageone_animation.json'),
          const HeightSpacer(size: 40),
          
        ],
      ),
    );
  }
}
