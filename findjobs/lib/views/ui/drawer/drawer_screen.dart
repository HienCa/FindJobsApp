import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/zoom_provider.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/width_spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key, required this.indexSetter});
  final ValueSetter indexSetter;
  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomnotifier, child) {
        return GestureDetector(
          onTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: Scaffold(
            backgroundColor: Color(kLightBlue.value),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                drawerItem(
                  CupertinoIcons.home,
                  "Home",
                  0,
                  zoomnotifier.currentIndex == 0
                      ? Color(kLight.value)
                      : Color(kLightGrey.value),
                ),
                drawerItem(
                  CupertinoIcons.chat_bubble,
                  "Chat",
                  1,
                  zoomnotifier.currentIndex == 1
                      ? Color(kLight.value)
                      : Color(kLightGrey.value),
                ),
                drawerItem(
                  CupertinoIcons.home,
                  "Bookmark",
                  2,
                  zoomnotifier.currentIndex == 2
                      ? Color(kLight.value)
                      : Color(kLightGrey.value),
                ),
                drawerItem(
                  CupertinoIcons.home,
                  "Device mgt",
                  3,
                  zoomnotifier.currentIndex == 3
                      ? Color(kLight.value)
                      : Color(kLightGrey.value),
                ),
                drawerItem(
                  CupertinoIcons.home,
                  "Profile",
                  4,
                  zoomnotifier.currentIndex == 4
                      ? Color(kLight.value)
                      : Color(kLightGrey.value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget drawerItem(IconData icon, String text, int index, Color color) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
            ),
            const WidthSpacer(size: 12),
            MyText(text: text, style: appstyle(14, color, FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
