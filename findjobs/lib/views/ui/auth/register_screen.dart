import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/login_provider.dart';
import 'package:findjobs/controllers/signup_provider.dart';
import 'package:findjobs/models/request/auth/register_model.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/common/my_button.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/my_textfield.dart';
import 'package:findjobs/views/ui/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();
  final TextEditingController nameTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    nameTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<RegisterNotifier>(
      builder: (context, registerNotifier, child) {
        return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: MyAppBar(
                  text: "Register",
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
              child: Form(
                key: registerNotifier.registerFormKey,
                child: ListView(
                  children: [
                    const HeightSpacer(size: 50),
                    MyText(
                        text: "Hello, Welcome",
                        style:
                            appstyle(30, Color(kDark.value), FontWeight.w600)),
                    MyText(
                        text: "Fill the details to register to your aacount",
                        style:
                            appstyle(16, Color(kDark.value), FontWeight.w300)),
                    const HeightSpacer(size: 50),
                    MyTextField(
                      controller: nameTextEditingController,
                      hintText: "Full Name",
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(CupertinoIcons.person),
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Please enter a valid full name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 20),
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
                      obscureText: registerNotifier.obscureText,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          registerNotifier.obscureText !=
                              registerNotifier.obscureText;
                        },
                        child: Icon(
                          registerNotifier.obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Color(kDark.value),
                        ),
                      ),
                      validator: (password) {
                        if (registerNotifier
                            .passwordValidator(password ?? "")) {
                          return "Please enter a valid password at least one uppercase, one lowercase, one digit, a special character and lenght of 8 character.";
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
                            Get.offAll(() => const LoginPage());
                          },
                          child: MyText(
                              text: "Login",
                              style: appstyle(
                                  14, Color(kDark.value), FontWeight.w500))),
                    ),
                    const HeightSpacer(size: 50),
                    MyButton(
                        onTap: () {
                          loginNotifier.firstTime = !loginNotifier.firstTime;
                          if (registerNotifier.validateAndSave()) {
                            RegisterModel model = RegisterModel(
                                name: nameTextEditingController.text.trim(),
                                email: emailTextEditingController.text.trim(),
                                password:
                                    passwordTextEditingController.text.trim());
                            registerNotifier.upRegister(model);
                          } else {
                            Get.snackbar("Register Failed",
                                "Please Check your credentials",
                                colorText: Color(kLight.value),
                                backgroundColor: Colors.red,
                                icon: const Icon(Icons.add_alert));
                          }
                        },
                        heightBtn: 50.h,
                        text: "Register",
                        backgroundColor: Color(kOrange.value),
                        textColor: Color(kLight.value))
                  ],
                ),
              ),
            ));
      },
    );
  }
}
