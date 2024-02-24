
import 'dart:convert';

List<ReceivedMessageModel> receivedMessageModelFromJson(String str) => List<ReceivedMessageModel>.from(json.decode(str).map((x) => ReceivedMessageModel.fromJson(x)));

String receivedMessageModelToJson(List<ReceivedMessageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReceivedMessageModel {
    final String id;
    final Sender sender;
    final String content;
    final Chat chat;
    final List<dynamic> readBy;

    ReceivedMessageModel({
        required this.id,
        required this.sender,
        required this.content,
        required this.chat,
        required this.readBy,
    });

    factory ReceivedMessageModel.fromJson(Map<String, dynamic> json) => ReceivedMessageModel(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        chat: Chat.fromJson(json["chat"]),
        readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "chat": chat.toJson(),
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
    };
}

class Chat {
    final String id;
    final String chatName;
    final bool isGroupChat;
    final List<Sender> users;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String latestMessage;

    Chat({
        required this.id,
        required this.chatName,
        required this.isGroupChat,
        required this.users,
        required this.createdAt,
        required this.updatedAt,
        required this.latestMessage,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        chatName: json["chatName"],
        isGroupChat: json["isGroupChat"],
        users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestMessage: json["latestMessage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestMessage": latestMessage,
    };
}

class Sender {
    final String id;
    final String username;
    final String email;
    final String profile;

    Sender({
        required this.id,
        required this.username,
        required this.email,
        required this.profile,
    });

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profile": profile,
    };
}
