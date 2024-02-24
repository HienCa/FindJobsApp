

import 'dart:convert';

InitialChat initialChatFromJson(String str) => InitialChat.fromJson(json.decode(str));

String initialChatToJson(InitialChat data) => json.encode(data.toJson());

class InitialChat {
    final String userId;

    InitialChat({
        required this.userId,
    });

    factory InitialChat.fromJson(Map<String, dynamic> json) => InitialChat(
        userId: json["_userId"],
    );

    Map<String, dynamic> toJson() => {
        "_userId": userId,
    };
}