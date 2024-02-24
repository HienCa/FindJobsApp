// ignore_for_file: avoid_print

import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/models/response/job/jobs_response_model.dart';
import 'package:findjobs/services/helpers/jobs_helper.dart';
import 'package:findjobs/views/common/data_empty.dart';
import 'package:findjobs/views/common/my_textfield.dart';
import 'package:findjobs/views/ui/home/widgets/vertical_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(kOrange.value),
          iconTheme: IconThemeData(color: Color(kLight.value)),
          title: MyTextField(
            hintText: "Search fof a job",
            controller: searchTextEditingController,
            keyboardType: TextInputType.text,
            onEditingComplete: () {
              setState(() {});
            },
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Icon(
                CupertinoIcons.search,
                color: Color(kLight.value),
              ),
            ),
          ),
          elevation: 0,
        ),
        body: searchTextEditingController.text.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: FutureBuilder<List<JobsResponseModel>>(
                  future: JobsHelper.searchJobs(
                      searchTextEditingController.text.trim()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.data!.isEmpty) {
                      return const DataEmpty(
                        text: "Job not found",
                      );
                    } else {
                      final jobs = snapshot.data;
                      return ListView.builder(
                        itemCount: jobs!.length,
                        itemBuilder: (context, index) {
                          final job = jobs[index];
                          return VerticalTile(job: job);
                        },
                      );
                    }
                  },
                ),
              )
            : const DataEmpty(text: "Start search for jobs"));
  }
}



