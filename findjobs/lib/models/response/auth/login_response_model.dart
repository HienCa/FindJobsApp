import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    final String token;
    final String id;
    final String profile;

    LoginResponseModel({
        required this.token,
        required this.id,
        required this.profile,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        token: json["token"],
        id: json["_id"],
        profile: json["profile"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "_id": id,
        "profile": profile,
    };
}
