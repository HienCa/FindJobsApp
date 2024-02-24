import 'package:findjobs/controllers/bookmark_provider.dart';
import 'package:findjobs/controllers/chat_provider.dart';
import 'package:findjobs/controllers/image_provider.dart';
import 'package:findjobs/controllers/jobs_provider.dart';
import 'package:findjobs/controllers/login_provider.dart';
import 'package:findjobs/controllers/onboarding_provider.dart';
import 'package:findjobs/controllers/profile_provider.dart';
import 'package:findjobs/controllers/signup_provider.dart';
import 'package:findjobs/controllers/zoom_provider.dart';
import 'package:findjobs/views/ui/auth/login_screen.dart';
import 'package:findjobs/views/ui/home/main_screen.dart';
import 'package:findjobs/views/ui/onboarding/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget defaultHome = const OnBoardingScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences prefes = await SharedPreferences.getInstance();
  final bool loggedIn = prefes.getBool('loggedIn') ?? false;
  final bool entrypoint = prefes.getBool('entrypoint') ?? false;

  if (entrypoint & !loggedIn) {
    defaultHome = const LoginPage();
  } else if (entrypoint && loggedIn) {
    defaultHome = const MainScreen();
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => OnBoardNotifier()),
    ChangeNotifierProvider(create: (context) => LoginNotifier()),
    ChangeNotifierProvider(create: (context) => RegisterNotifier()),
    ChangeNotifierProvider(create: (context) => JobsNotifier()),
    ChangeNotifierProvider(create: (context) => ImageNotifier()),
    ChangeNotifierProvider(create: (context) => BookMarkNotifier()),
    ChangeNotifierProvider(create: (context) => ZoomNotifier()),
    ChangeNotifierProvider(create: (context) => ProfileNotifier()),
    ChangeNotifierProvider(create: (context) => ChatNotifier()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Find Jobs',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: defaultHome,
        );
      },
    );
  }
}
