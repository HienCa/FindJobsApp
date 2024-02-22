import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/zoom_provider.dart';
import 'package:findjobs/views/ui/bookmarks/bookmark_screen.dart';
import 'package:findjobs/views/ui/chats/chat_screen.dart';
import 'package:findjobs/views/ui/devide_mgt/device_management_screen.dart';
import 'package:findjobs/views/ui/drawer/drawer_screen.dart';
import 'package:findjobs/views/ui/home/home_screen.dart';
import 'package:findjobs/views/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(
      builder: (context, zoomnotifier, child) {
        return ZoomDrawer(
          menuScreen: DrawerScreen(
            indexSetter: (index) {
              zoomnotifier.currentIndex = index;
            },
          ),
          mainScreen: currentScreen(),
          borderRadius: 30,
          showShadow: true,
          angle: 0.0,
          slideWidth: 250,
          menuBackgroundColor: Color(kLightBlue.value),
        );
      },
    );
  }

  Widget currentScreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatPage();
      case 2:
        return const BookMarkPage();
      case 3:
        return const DeviceManagementPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
    }
  }
}
