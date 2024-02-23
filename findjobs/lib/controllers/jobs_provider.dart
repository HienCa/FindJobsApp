import 'package:findjobs/models/response/job/job_response_model.dart';
import 'package:findjobs/models/response/job/jobs_response_model.dart';
import 'package:findjobs/services/helpers/jobs_helper.dart';
import 'package:flutter/material.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponseModel>> jobs;
  late Future<JobsResponseModel> recent;
  late Future<JobResponseModel> job;

  getJobs() {
    jobs = JobsHelper.getJobs();
  }

  getRecent() {
    recent = JobsHelper.getRecent();
  }

  getJob(String jobId) {
    job = JobsHelper.getJob(jobId);
  }
}
