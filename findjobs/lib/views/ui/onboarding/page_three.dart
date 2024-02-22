
import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_button.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/ui/auth/login_screen.dart';
import 'package:findjobs/views/ui/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

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
          MyText(
              text: "Welcome To FIND JOBS",
              style: appstyle(30, Color(kLight.value), FontWeight.w600)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
                "We help you find your dream job to your skillset, location and reference to build your career",
                textAlign: TextAlign.center,
                style: appstyle(14, Color(kLight.value), FontWeight.normal)),
          ),
          const HeightSpacer(size: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyButton(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('entrypoint', true);
                    Get.to(() => const LoginPage());
                  },
                  heightBtn: height * 0.06,
                  widthBtn: width * 0.4,
                  text: "Login",
                  backgroundColor: kLight,
                  textColor: kOrange),
              MyButton(
                  onTap: () {
                    Get.to(() => const RegisterPage());
                  },
                  heightBtn: height * 0.06,
                  widthBtn: width * 0.4,
                  text: "Signup",
                  backgroundColor: kLightGrey,
                  textColor: kLight)
            ],
          ),
          const HeightSpacer(size: 30),
          MyText(
              text: "Continue as guest",
              style: appstyle(16, Color(kLight.value), FontWeight.w400))
        ],
      ),
    );
  }
}
