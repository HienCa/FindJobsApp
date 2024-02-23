import 'dart:convert';

JobResponseModel jobResponseModelFromJson(String str) => json.decode(str);

String jobResponseModelToJson(JobResponseModel data) =>
    json.encode(data.toJson());

class JobResponseModel {
  final String id;
  final String title;
  final String location;
  final String company;
  final String hiring;
  final String description;
  final String period;
  final String contract;
  final String salary;
  final List<String> requirements;
  final String imageUrl;
  final String agentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  JobResponseModel({
    required this.id,
    required this.title,
    required this.location,
    required this.company,
    required this.hiring,
    required this.description,
    required this.period,
    required this.contract,
    required this.salary,
    required this.requirements,
    required this.imageUrl,
    required this.agentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobResponseModel.fromJson(Map<String, dynamic> json) =>
      JobResponseModel(
        id: json["_id"] ?? "",
        title: json["title"] ?? "",
        location: json["location"] ?? "",
        company: json["company"] ?? "",
        hiring: json["hiring"] ?? "",
        description: json["description"] ?? "",
        period: json["period"] ?? "",
        contract: json["contract"] ?? "",
        salary: json["salary"] ?? "",
        requirements: List<String>.from(json["requirements"].map((x) => x)),
        imageUrl: json["imageUrl"] ?? "",
        agentId: json["agentId"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "location": location,
        "company": company,
        "hiring": hiring,
        "description": description,
        "period": period,
        "contract": contract,
        "salary": salary,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
        "imageUrl": imageUrl,
        "agentId": agentId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
