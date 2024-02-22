import 'dart:convert';

ProfileResponseModel profileResponseModelFromJson(String str) =>
    ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) =>
    json.encode(data.toJson());

class ProfileResponseModel {
  final String id;
  final String username;
  final String phone;
  final String location;
  final String email;
  final bool isAdmin;
  final bool isAgent;
  final List<String> skills;
  final String profile;

  ProfileResponseModel({
    required this.id,
    required this.username,
    required this.phone,
    required this.location,
    required this.email,
    required this.isAdmin,
    required this.isAgent,
    required this.skills,
    required this.profile,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
        id: json["_id"],
        username: json["username"],
        phone: json["phone"],
        location: json["location"],
        email: json["email"],
        isAdmin: json["isAdmin"],
        isAgent: json["isAgent"],
        skills: List<String>.from(json["skills"].map((x) => x)),
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "phone": phone,
        "location": location,
        "email": email,
        "isAdmin": isAdmin,
        "isAgent": isAgent,
        "skills": List<String>.from(skills.map((x) => x)),
        "profile": profile,
      };
}
