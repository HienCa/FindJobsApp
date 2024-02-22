import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/login_provider.dart';
import 'package:findjobs/controllers/onboarding_provider.dart';
import 'package:findjobs/controllers/zoom_provider.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/ui/devide_mgt/device_info_widget.dart';
import 'package:findjobs/views/ui/home/drawer_widget.dart';
import 'package:findjobs/views/ui/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DeviceManagementPage extends StatefulWidget {
  const DeviceManagementPage({super.key});

  @override
  State<DeviceManagementPage> createState() => _DeviceManagementPageState();
}

class _DeviceManagementPageState extends State<DeviceManagementPage> {
  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var onBoardNotifier = Provider.of<OnBoardNotifier>(context);
    String date = DateTime.now().toString();
    var logiDate = date.substring(0, 11);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: MyAppBar(
            text: "Devide Management",
            actions: [
              Padding(
                padding: EdgeInsets.all(12.h),
                child: CircleAvatar(
                    child: Image.asset("assets/images/logo.jpg",
                        width: 30.w, height: 30.h)),
              )
            ],
            child: const DrawerWidget(),
          )),
      body: SafeArea(
          child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                const HeightSpacer(size: 20),
                Text("You ara logged in into your account on these devices",
                    style: appstyle(16, Color(kDark.value), FontWeight.normal)),
                const HeightSpacer(size: 20),
                DiviceInfo(
                    location: "Hoc Mon",
                    device: "Iphone 15 PRM",
                    platform: "APPle Webkit",
                    date: logiDate,
                    ipAdress: "10.0.12.000"),
                const HeightSpacer(size: 50),
                DiviceInfo(
                    location: "Hoc Mon",
                    device: "Iphone 14 PRM",
                    platform: "APPle Webkit",
                    date: logiDate,
                    ipAdress: "10.0.12.000"),
              ],
            ),
          ),
          Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  zoomNotifier.currentIndex = 0;
                  onBoardNotifier.isLastPage = false;
                  Get.to(() => const OnBoardingScreen());
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: MyText(
                      text: "Sign out of all devices",
                      style:
                          appstyle(16, Color(kOrange.value), FontWeight.w600)),
                ),
              ),
            );
          })
        ],
      )),
    );
  }
}
