import 'package:findjobs/controllers/onboarding_provider.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/ui/onboarding/page_one.dart';
import 'package:findjobs/views/ui/onboarding/page_three.dart';
import 'package:findjobs/views/ui/onboarding/page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/app_constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Consumer<OnBoardNotifier>(builder: (context, onBoardNotifier, child) {
        return Stack(
          children: [
            PageView(
              physics: onBoardNotifier.isLastPage
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (page) {
                onBoardNotifier.isLastPage = page == 2;
              },
              children: const [PageOne(), PageTwo(), PageThree()],
            ),
            Positioned(
              bottom: height * 0.12,
              left: 0,
              right: 0,
              child: onBoardNotifier.isLastPage
                  ? const SizedBox.shrink()
                  : Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                            dotHeight: 12,
                            dotWidth: 12,
                            dotColor: Color(kDarkGrey.value),
                            spacing: 10,
                            activeDotColor: Color(kLight.value)),
                      ),
                    ),
            ),
            Positioned(
                child: onBoardNotifier.isLastPage
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 30.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      pageController.jumpToPage(2);
                                    },
                                    child: MyText(
                                        text: "Skip",
                                        style: appstyle(16, Color(kLight.value),
                                            FontWeight.w500))),
                                GestureDetector(
                                    onTap: () {
                                      pageController.nextPage(
                                          duration: const Duration(microseconds: 300),
                                          curve: Curves.ease);
                                    },
                                    child: MyText(
                                        text: "Next",
                                        style: appstyle(16, Color(kLight.value),
                                            FontWeight.w500)))
                              ]),
                        )))
          ],
        );
      }),
    );
  }
}
