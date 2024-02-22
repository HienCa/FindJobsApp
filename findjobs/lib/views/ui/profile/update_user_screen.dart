import 'dart:io';

import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/image_provider.dart';
import 'package:findjobs/controllers/login_provider.dart';
import 'package:findjobs/models/request/user/profile_update_model.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_button.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController profileTextEditingController = TextEditingController();
  TextEditingController skill1TextEditingController = TextEditingController();
  TextEditingController skill2TextEditingController = TextEditingController();
  TextEditingController skill3TextEditingController = TextEditingController();
  TextEditingController skill4TextEditingController = TextEditingController();
  TextEditingController skill5TextEditingController = TextEditingController();
  @override
  void dispose() {
    locationTextEditingController.dispose();
    phoneTextEditingController.dispose();
    skill1TextEditingController.dispose();
    skill2TextEditingController.dispose();
    skill3TextEditingController.dispose();
    skill4TextEditingController.dispose();
    skill5TextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      return Form(
        key: loginNotifier.profileFormKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(
                    text: "Personal Details",
                    style: appstyle(35, Color(kDark.value), FontWeight.bold)),
                Consumer<ImageNotifier>(
                  builder: (context, imageNotifier, child) {
                    return imageNotifier.imageFil.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              imageNotifier.pickImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(kLightBlue.value),
                              child: const Center(
                                child: Icon(Icons.photo_filter_rounded),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              imageNotifier.imageFil.clear();
                              setState(() {});
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(kLightBlue.value),
                              backgroundImage:
                                  FileImage(File(imageNotifier.imageFil[0])),
                            ),
                          );
                  },
                ),
                const HeightSpacer(size: 20),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      controller: locationTextEditingController,
                      hintText: 'Location',
                      keyboardType: TextInputType.text,
                      validator: (location) {
                        if (location!.isEmpty) {
                          return "Please enter a valid location!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    MyTextField(
                      controller: locationTextEditingController,
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "Please enter a valid phone!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    MyText(
                        text: "Professional Skills",
                        style:
                            appstyle(33, Color(kDark.value), FontWeight.bold)),
                    const HeightSpacer(size: 10),
                    MyTextField(
                      controller: skill1TextEditingController,
                      hintText: '',
                      keyboardType: TextInputType.text,
                      validator: (location) {
                        if (location!.isEmpty) {
                          return "Please enter a valid skill!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    MyTextField(
                      controller: skill2TextEditingController,
                      hintText: '',
                      keyboardType: TextInputType.text,
                      validator: (location) {
                        if (location!.isEmpty) {
                          return "Please enter a valid skill!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    MyTextField(
                      controller: skill3TextEditingController,
                      hintText: '',
                      keyboardType: TextInputType.text,
                      validator: (location) {
                        if (location!.isEmpty) {
                          return "Please enter a valid skill!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    MyTextField(
                      controller: skill4TextEditingController,
                      hintText: '',
                      keyboardType: TextInputType.text,
                      validator: (location) {
                        if (location!.isEmpty) {
                          return "Please enter a valid skill!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    MyTextField(
                      controller: skill5TextEditingController,
                      hintText: '',
                      keyboardType: TextInputType.text,
                      validator: (location) {
                        if (location!.isEmpty) {
                          return "Please enter a valid skill!";
                        } else {
                          return null;
                        }
                      },
                    ),
                    Consumer<ImageNotifier>(
                      builder: (context, imageNotifier, child) {
                        return MyButton(
                          onTap: () {
                            if (imageNotifier.imageFil.isEmpty &&
                                imageNotifier.imageUrl == null) {
                              Get.snackbar(
                                  "Image Missing", "Please Please upload an image to procced!",
                                  colorText: Color(kLight.value),
                                  backgroundColor: Color(kLightBlue.value),
                                  icon: const Icon(Icons.add_alert));
                            } else {
                              ProfileUpdateReq model = ProfileUpdateReq(
                                  location:
                                      locationTextEditingController.text.trim(),
                                  phone: phoneTextEditingController.text.trim(),
                                  profile: profileTextEditingController.text,
                                  skills: [
                                    skill1TextEditingController.text.trim(),
                                    skill2TextEditingController.text.trim(),
                                    skill3TextEditingController.text.trim(),
                                    skill4TextEditingController.text.trim(),
                                    skill5TextEditingController.text.trim(),
                                  ]);
                              loginNotifier.updateProfile(model);
                            }
                          },
                          text: "Update profile",
                          backgroundColor: Color(kOrange.value),
                          textColor: Color(kLight.value),
                        );
                      },
                    )
                  ],
                ))
              ],
            )
          ],
        ),
      );
    }));
  }
}
