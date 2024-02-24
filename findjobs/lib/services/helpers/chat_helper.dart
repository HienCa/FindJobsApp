import 'dart:convert';

import 'package:findjobs/models/request/chat/create_chat_model.dart';
import 'package:findjobs/models/response/chat/initital_msg_res_model.dart';
import 'package:findjobs/services/config.dart';
import 'package:findjobs/views/common/sharedpreferences.dart';
import 'package:http/http.dart' as https;

class ChatHelper {
  static var client = https.Client();

  static Future<List<dynamic>> apply(CreateChat model) async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.chatUrl);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    var first = initialChatFromJson(response.body).id;
    if (response.statusCode == 200) {
      return [true, first];
    } else {
      return [false];
    }
  }

  static Future<List<GetChats>> getConversations() async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.chatUrl);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    var chats = getChatsFromJson(response.body);
    if (response.statusCode == 200) {
      return chats;
    } else {
      throw Exception("Couldn't load chats");
    }
  }
}
