import 'dart:convert';

ProfileUpdateReq profileUpdateModelFromJson(String str) =>
    ProfileUpdateReq.fromJson(json.decode(str));

String profileUpdateModelToJson(ProfileUpdateReq data) =>
    json.encode(data.toJson());

class ProfileUpdateReq {
  String location;
  String phone;
  String profile;
  List<String> skills;

  ProfileUpdateReq({
    required this.location,
    required this.phone,
    required this.profile,
    required this.skills,
  });

  factory ProfileUpdateReq.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateReq(
        location: json["location"],
        phone: json["phone"],
        profile: json["profile"],
        skills: List<String>.from(json["skills"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "phone": phone,
        "profile": profile,
        "skills": skills,
      };
}
