import 'package:findjobs/models/response/job/job_response_model.dart';
import 'package:findjobs/models/response/job/jobs_response_model.dart';
import 'package:findjobs/services/config.dart';
import 'package:findjobs/views/common/sharedpreferences.dart';
import 'package:http/http.dart' as https;

class JobsHelper {
  static var client = https.Client();
  static Future<List<JobsResponseModel>> getJobs() async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.jobsUrl);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var jobs = jobsResponseModelFromJson(response.body);
      return jobs;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }

  static Future<JobsResponseModel> getRecent() async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.jobUrl);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var jobs = jobsResponseModelFromJson(response.body);
      var recent = jobs.first;
      return recent;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }

  static Future<JobResponseModel> getJob(String jobId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobUrl}/$jobId");

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var job = jobResponseModelFromJson(response.body);
      return job;
    } else {
      throw Exception("Failed to get a job");
    }
  }

  static Future<List<JobsResponseModel>> searchJobs(String searchQuery) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiUrl, "${Config.searchUrl}/$searchQuery");

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var jobs = jobsResponseModelFromJson(response.body);
      return jobs;
    } else {
      throw Exception("Failed to get the jobs");
    }
  }
}
