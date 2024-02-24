import 'dart:convert';

import 'package:findjobs/models/request/chat/send_message_model.dart';
import 'package:findjobs/models/response/messaging/messaging_res_model.dart';
import 'package:findjobs/services/config.dart';
import 'package:findjobs/views/common/sharedpreferences.dart';
import 'package:http/http.dart' as https;

class MessagingHelper {
  static var client = https.Client();

  static Future<List<dynamic>> sendMessage(SendMessageModel model) async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.messageUrl);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    ReceivedMessageModel message =
        ReceivedMessageModel.fromJson(jsonDecode(response.body));

    Map<String, dynamic> responseMap = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return [true, message, responseMap];
    } else {
      return [false];
    }
  }

  static Future<List<ReceivedMessageModel>> getMessages(
      String chatId, offset) async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "${Config.messageUrl}/$chatId",
        {"page": offset.toString()});

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    var messages = receivedMessageModelFromJson(response.body);
    if (response.statusCode == 200) {
      return messages;
    } else {
      throw Exception("Failed to load messages!");
    }
  }
}
