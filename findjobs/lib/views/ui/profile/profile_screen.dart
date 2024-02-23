import 'package:cached_network_image/cached_network_image.dart';
import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/image_provider.dart';
import 'package:findjobs/controllers/profile_provider.dart';
import 'package:findjobs/models/response/user/profile_response_model.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/width_spacer.dart';
import 'package:findjobs/views/ui/home/widgets/drawer_widget.dart';
import 'package:findjobs/views/ui/profile/profile_update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: const MyAppBar(
              text: "Personal infomation",
              child: DrawerWidget(),
            )),
        body: Consumer<ProfileNotifier>(
          builder: (context, profileNotifier, child) {
            profileNotifier.getProfile();
            return FutureBuilder<ProfileResponseModel>(
                future: profileNotifier.profile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else {
                    final userData = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() =>  ProfileUpdatePage(profile: userData,));
                            },
                            child: Container(
                              width: width,
                              height: height * 0.12,
                              color: Color(kLight.value),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Consumer<ImageNotifier>(
                                        builder:
                                            (context, imageNotifier, child) {
                                          return GestureDetector(
                                            onTap: () {
                                              // imageNotifier.pickImage();
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              child: CachedNetworkImage(
                                                imageUrl: userData?.profile ??
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTEBqYEUHs9SPync2bo8AmdYjzW5WYicOWF8lreCXnMcQ&s",
                                                width: 80.w,
                                                height: 100.h,
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  const WidthSpacer(size: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          MyText(
                                              text: userData!.username,
                                              style: appstyle(
                                                  20,
                                                  Color(kDark.value),
                                                  FontWeight.w600)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_location_alt_outlined,
                                                color: Color(kDarkGrey.value),
                                                size: 16.w,
                                              ),
                                              const WidthSpacer(size: 5),
                                              MyText(
                                                  text: userData.location,
                                                  style: appstyle(
                                                      14,
                                                      Color(kDarkGrey.value),
                                                      FontWeight.w600)),
                                            ],
                                          )
                                        ],
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Get.to(
                                      //         () => const ProfileUpdatePage());
                                      //   },
                                      //   child: const Icon(Icons.edit, size: 18),
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          Stack(
                            children: [
                              Container(
                                width: width,
                                height: height * 0.12,
                                color: Color(kLightGrey.value),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 10.w),
                                      width: 50.w,
                                      height: 50.h,
                                      color: Color(kLight.value),
                                      child: const Icon(
                                        Icons.file_upload,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MyText(
                                            text: "Resume from VH",
                                            style: appstyle(
                                                18,
                                                Color(kDark.value),
                                                FontWeight.w600)),
                                        MyText(
                                            text: "VH Resume",
                                            style: appstyle(
                                                16,
                                                Color(kDark.value),
                                                FontWeight.w600)),
                                      ],
                                    ),
                                    const WidthSpacer(size: 1)
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 2.h,
                                  right: 5.w,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: MyText(
                                        text: "Edit",
                                        style: appstyle(
                                            16,
                                            Color(kOrange.value),
                                            FontWeight.w500)),
                                  ))
                            ],
                          ),
                          const HeightSpacer(size: 20),
                          Container(
                              padding: EdgeInsets.only(left: 8.w),
                              width: width,
                              height: height * 0.06,
                              color: Color(kLight.value),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const Icon(CupertinoIcons.mail),
                                    const WidthSpacer(size: 15),
                                    MyText(
                                        text: userData.email,
                                        style: appstyle(16, Color(kDark.value),
                                            FontWeight.w600)),
                                  ],
                                ),
                              )),
                          const HeightSpacer(size: 20),
                          Container(
                              padding: EdgeInsets.only(left: 8.w),
                              width: width,
                              height: height * 0.06,
                              color: Color(kLight.value),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    const Icon(CupertinoIcons.phone),
                                    const WidthSpacer(size: 15),
                                    MyText(
                                        text: userData.phone,
                                        style: appstyle(16, Color(kDark.value),
                                            FontWeight.w600)),
                                  ],
                                ),
                              )),
                          const HeightSpacer(size: 20),
                          Container(
                            color: Color(kLightGrey.value),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.h),
                                  child: MyText(
                                      text: "Skills",
                                      style: appstyle(20, Color(kDark.value),
                                          FontWeight.w600)),
                                ),
                                const HeightSpacer(size: 10),
                                SizedBox(
                                  height: height * 0.35,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: userData.skills.length,
                                          itemBuilder: (context, index) {
                                            final skill =
                                                userData.skills[index];
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                vertical: 2.h,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                              ),
                                              width: width,
                                              height: height * 0.06,
                                              color: Color(kLight.value),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: MyText(
                                                    text: skill,
                                                    style: appstyle(
                                                        16,
                                                        Color(kDark.value),
                                                        FontWeight.normal)),
                                              ),
                                            );
                                          })),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                });
          },
        ));
  }
}
