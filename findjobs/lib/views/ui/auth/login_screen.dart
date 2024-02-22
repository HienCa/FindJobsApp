import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/login_provider.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/common/my_button.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/my_textfield.dart';
import 'package:findjobs/views/ui/auth/register_screen.dart';
import 'package:findjobs/views/ui/home/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(
      builder: (context, loginNotifier, child) {
        return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: MyAppBar(
                  text: "Login",
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.arrow_left),
                  ),
                )),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: ListView(
                children: [
                  const HeightSpacer(size: 50),
                  MyText(
                      text: "Welcome Back",
                      style: appstyle(30, Color(kDark.value), FontWeight.w600)),
                  MyText(
                      text: "Fill the details to login to your aacount",
                      style: appstyle(16, Color(kDark.value), FontWeight.w600)),
                  const HeightSpacer(size: 50),
                  MyTextField(
                    controller: emailTextEditingController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail),
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  MyTextField(
                    controller: passwordTextEditingController,
                    hintText: "Password",
                    obscureText: loginNotifier.obscureText,
                    keyboardType: TextInputType.text,
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        loginNotifier.obscureText != loginNotifier.obscureText;
                      },
                      child: Icon(
                        loginNotifier.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Color(kDark.value),
                      ),
                    ),
                    validator: (password) {
                      if (password!.isEmpty || password.trim().length < 7) {
                        return "Please enter a valid password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          Get.to(() => const RegisterPage());
                        },
                        child: MyText(
                            text: "Register",
                            style: appstyle(
                                14, Color(kDark.value), FontWeight.w500))),
                  ),
                  const HeightSpacer(size: 50),
                  MyButton(
                      onTap: () {
                        Get.to(() => const MainScreen());
                      },
                      heightBtn: 50.h,
                      text: "Login",
                      backgroundColor: Color(kOrange.value),
                      textColor: Color(kLight.value))
                ],
              ),
            ));
      },
    );
  }
}
