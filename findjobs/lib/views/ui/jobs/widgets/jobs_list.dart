import 'package:findjobs/controllers/jobs_provider.dart';

import 'package:findjobs/models/response/job/jobs_response_model.dart';

import 'package:findjobs/views/common/my_appbar.dart';

import 'package:findjobs/views/ui/home/widgets/vertical_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<JobsNotifier>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: MyAppBar(
            text: "Jobs",
            actions: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(CupertinoIcons.bookmark),
              )
            ],
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left),
            ),
          )),
      body: FutureBuilder<List<JobsResponseModel>>(
          future: jobList.jobs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              final job = snapshot.data;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.builder(
                  itemCount: job!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final jobs = job[index];
                    return VerticalTile(job: jobs);
                  },
                ),
              );
            }
          }),
    );
  }
}
