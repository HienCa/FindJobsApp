
import 'dart:convert';

List<AllBookmarkModel> allBookmarkModelFromJson(String str) => List<AllBookmarkModel>.from(json.decode(str).map((x) => AllBookmarkModel.fromJson(x)));

String allBookmarkModelToJson(List<AllBookmarkModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBookmarkModel {
    final String id;
    final Job job;
    final String userId;

    AllBookmarkModel({
        required this.id,
        required this.job,
        required this.userId,
    });

    factory AllBookmarkModel.fromJson(Map<String, dynamic> json) => AllBookmarkModel(
        id: json["_id"],
        job: Job.fromJson(json["job"]),
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "job": job.toJson(),
        "userId": userId,
    };
}

class Job {
    final String id;
    final String userId;
    final String title;
    final String company;
    final String location;
    final String imageUrl;
    final String agentId;
    final String period;
    final String contract;
    final String salary;

    Job({
        required this.id,
        required this.userId,
        required this.title,
        required this.company,
        required this.location,
        required this.imageUrl,
        required this.agentId,
        required this.period,
        required this.contract,
        required this.salary,
    });

    factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        company: json["company"],
        location: json["location"],
        imageUrl: json["imageUrl"],
        agentId: json["agentId"],
        period: json["period"],
        contract: json["contract"],
        salary: json["salary"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "company": company,
        "location": location,
        "imageUrl": imageUrl,
        "agentId": agentId,
        "period": period,
        "contract": contract,
        "salary": salary,
    };
}
