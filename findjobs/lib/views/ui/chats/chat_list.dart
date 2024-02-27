// ignore_for_file: avoid_print

import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/chat_provider.dart';
import 'package:findjobs/models/response/chat/get_chat_model.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/data_empty.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/ui/chats/chat_screen.dart';
import 'package:findjobs/views/ui/home/widgets/drawer_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: MyAppBar(
            text: "Chat",
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
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          chatNotifier.getChats();
          chatNotifier.getPrefs();
          print(chatNotifier.userId);
          return FutureBuilder<List<GetChatsModel>>(
            future: chatNotifier.chats,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return MyText(
                    text: "Error: ${snapshot.error}",
                    style: appstyle(20, Color(kOrange.value), FontWeight.w600));
              } else if (snapshot.data!.isEmpty) {
                return const DataEmpty(text: 'No Chats Available!');
              } else {
                final chats = snapshot.data;
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                  itemCount: chats!.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    var user = chat.users
                        .where((user) => user.id != chatNotifier.userId);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ChatPage(
                                title: user.first.username,
                                id: chat.id,
                                profile: user.first.profile,
                                user: [chat.users[0].id, chat.users[1].id],
                              ));
                        },
                        child: Container(
                          height: height * 0.26,
                          width: width,
                          decoration: BoxDecoration(
                              color: Color(kLight.value),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12))),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                            ),
                            minLeadingWidth: 0,
                            minVerticalPadding: 0,
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(user.first.profile),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                    text: user.first.username,
                                    style: appstyle(16, Color(kDark.value),
                                        FontWeight.w600)),
                                const HeightSpacer(size: 5),
                                MyText(
                                    text: chat.latestMessage.content,
                                    style: appstyle(16, Color(kDarkGrey.value),
                                        FontWeight.normal)),
                              ],
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(
                                right: 4.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(
                                      text: chatNotifier
                                          .msgTime(chat.updatedAt.toString()),
                                      style: appstyle(16, Color(kDark.value),
                                          FontWeight.normal)),
                                  Icon(chat.chatName == chatNotifier.userId
                                      ? Icons.arrow_forward_outlined
                                      : Icons.arrow_back_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
