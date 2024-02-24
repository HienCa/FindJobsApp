// ignore_for_file: prefer_final_fields

import 'package:findjobs/services/helpers/chat_helper.dart';
import 'package:findjobs/views/common/sharedpreferences.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;

  bool _typing = false;
  bool get typing => _typing;
  set typingStatus(bool newStatus) {
    _typing = newStatus;
    notifyListeners();
  }

  List<String> _online = [];
  List<String> get online => _online;
  set onLineUsers(List<String> newList) {
    _online = newList;
    notifyListeners();
  }

  String? userId;
  getChats() {
    chats = ChatHelper.getConversations();
  }

  getPrefs() async {
    userId = await MyCacheManager.getFromCache('userId');
  }

  String msgTime(String timestamps) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(timestamps);

    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return DateFormat.Hm().format(messageTime);
    } else if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day - messageTime.day == 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(messageTime);
    }
  }
}
