// ignore_for_file: avoid_print, library_prefixes

import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/chat_provider.dart';
import 'package:findjobs/models/request/chat/send_message_model.dart';
import 'package:findjobs/models/response/messaging/messaging_res_model.dart';
import 'package:findjobs/services/config.dart';
import 'package:findjobs/services/helpers/messaging_helper.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/data_empty.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/ui/chats/widgets/message_textfield.dart';
import 'package:findjobs/views/ui/home/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key,
      required this.title,
      required this.id,
      required this.profile,
      required this.user});
  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  int offset = 1;

  String receiver = '';
  late List<ReceivedMessageModel> messages = [];
  late Future<List<ReceivedMessageModel>> msgList;
  final ScrollController _scrollController = ScrollController();
  TextEditingController messageTextEditingController = TextEditingController();
  @override
  void initState() {
    getMessages(offset);
    connect();
    joinChat();
    handleNext();
    super.initState();
  }

  void getMessages(int offset) {
    msgList = MessagingHelper.getMessages(widget.id, offset);
  }

  void handleNext() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          print("<<><><><>LOADING<><><><<>>");
          if (messages.length >= 12) {
            getMessages(offset++);
            setState(() {});
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io("https://${Config.apiUrl}", <String, dynamic>{
      "transport": ["websocket"],
      "autoConnect": false,
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((data) {
      print("Connect to front end");
      socket!.on('online-users', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
      });

      socket!.on('typing', (status) {
        chatNotifier.typingStatus = true;
      });

      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = true;
      });

      socket!.on('message received', (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessageModel receivedMessage =
            ReceivedMessageModel.fromJson(newMessageReceived);
        if (receivedMessage.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessage);
          });
        }
      });
    });
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessageModel model =
        SendMessageModel(content: content, chatId: chatId, receiver: receiver);
    MessagingHelper.sendMessage(model).then((response) {
      var emission = response[2];
      socket!.emit('new message', emission);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageTextEditingController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiver = widget.user.firstWhere((id) => id != chatNotifier.userId);

        return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(50.h),
                child: MyAppBar(
                  text: !chatNotifier.typing ? widget.title : "typing...",
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.profile),
                          ),
                          Positioned(
                              right: 3,
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                    chatNotifier.online.contains(receiver)
                                        ? Colors.green
                                        : Colors.grey,
                              ))
                        ],
                      ),
                    )
                  ],
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const MainScreen());
                    },
                    child: const Icon(CupertinoIcons.arrow_left),
                  ),
                )),
            body: SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<ReceivedMessageModel>>(
                      future: msgList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return MyText(
                              text: "Error: ${snapshot.error}",
                              style: appstyle(
                                  20, Color(kOrange.value), FontWeight.w600));
                        } else if (snapshot.data!.isEmpty) {
                          return const DataEmpty(
                              text: 'You do not have message!');
                        } else {
                          final msgList = snapshot.data;

                          messages = messages + msgList!;
                          return ListView.builder(
                            reverse: true,
                            controller: _scrollController,
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final data = messages[index];

                              return Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 12.h),
                                child: Column(
                                  children: [
                                    MyText(
                                        text: chatNotifier.msgTime(
                                            data.chat.updatedAt.toString()),
                                        style: appstyle(16, Color(kDark.value),
                                            FontWeight.normal)),
                                    const HeightSpacer(size: 15),
                                    ChatBubble(
                                      alignment:
                                          data.sender.id == chatNotifier.userId
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      backGroundColor:
                                          data.sender.id == chatNotifier.userId
                                              ? Color(kOrange.value)
                                              : Color(kLightBlue.value),
                                      elevation: 0,
                                      clipper: ChatBubbleClipper4(
                                          radius: 8,
                                          type: data.sender.id ==
                                                  chatNotifier.userId
                                              ? BubbleType.sendBubble
                                              : BubbleType.receiverBubble),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: width * 0.8),
                                        child: MyText(
                                            text: data.content,
                                            style: appstyle(
                                                14,
                                                Color(kLight.value),
                                                FontWeight.normal)),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.h),
                    alignment: Alignment.bottomCenter,
                    child: MessagingTextField(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              String msg =
                                  messageTextEditingController.text.trim();

                              sendMessage(msg, widget.id, receiver);
                            },
                            child: const Icon(
                              Icons.send,
                              size: 24,
                            )),
                        onChanged: (_) {
                          sendTypingEvent(widget.id);
                        },
                        onTapOutside: (_) {
                          sendStopTypingEvent(widget.id);
                        },
                        onEditingComplete: () {
                          String msg = messageTextEditingController.text.trim();
                          sendMessage(msg, widget.id, receiver);
                        },
                        onSubmitted: (_) {
                          String msg = messageTextEditingController.text.trim();
                          sendMessage(msg, widget.id, receiver);
                        },
                        messageTextEditingController:
                            messageTextEditingController),
                  ),
                ],
              ),
            )));
      },
    );
  }
}
