import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/jobs_provider.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/horizontal_shimmer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/ui/home/widgets/drawer_widget.dart';
import 'package:findjobs/views/ui/home/widgets/heading_widget.dart';
import 'package:findjobs/views/ui/home/widgets/job_horizontal_tile.dart';
import 'package:findjobs/views/ui/home/widgets/search_widget.dart';
import 'package:findjobs/views/ui/home/widgets/vertical_tile.dart';
import 'package:findjobs/views/ui/jobs/job_screen.dart';
import 'package:findjobs/views/ui/jobs/widgets/jobs_list.dart';
import 'package:findjobs/views/ui/search/widgets/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: MyAppBar(
              text: "",
              actions: [
                Padding(
                  padding: EdgeInsets.all(12.h),
                  child: CircleAvatar(
                      child: Image.asset("assets/images/logo.jpg",
                          width: 30.w, height: 30.h)),
                )
              ],
              child: const DrawerWidget(),
            )),
        body: Consumer<JobsNotifier>(
          builder: (context, jobNotifier, child) {
            jobNotifier.getJobs();
            jobNotifier.getRecent();
            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const HeightSpacer(size: 10),
                    Text(
                      "Search \n Find & Apply",
                      style: appstyle(40, Color(kDark.value), FontWeight.bold),
                    ),
                    const HeightSpacer(size: 40),
                    SearchWidget(
                      ontap: () {
                        Get.to(() => const SearchPage());
                      },
                    ),
                    const HeightSpacer(size: 30),
                    HeadingWidget(
                      text: "Popular Jobs",
                      onTap: () {
                        Get.to(() => const JobListPage());
                      },
                    ),
                    const HeightSpacer(size: 15),
                    SizedBox(
                        height: height * 0.28,
                        child: FutureBuilder(
                          future: jobNotifier.jobs,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const HorizontalShrimmer();
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else {
                              final jobs = snapshot.data;
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: jobs!.length,
                                  itemBuilder: (context, index) {
                                    final job = jobs[index];

                                    return JobHorizontalTile(
                                      onTap: () {
                                        Get.to(() => JobPage(
                                            title: job.company, id: job.id));
                                      },
                                      job: job,
                                    );
                                  });
                            }
                          },
                        )),
                    const HeightSpacer(size: 20),
                    HeadingWidget(
                      text: "Recently Posted",
                      onTap: () {},
                    ),
                    const HeightSpacer(size: 20),
                    FutureBuilder(
                      future: jobNotifier.recent,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const HorizontalShrimmer();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else {
                          final jobs = snapshot.data;
                          return VerticalTile(
                              job: jobs!,
                              onTap: () {
                                Get.to(() =>
                                    JobPage(title: jobs.company, id: jobs.id));
                              });
                        }
                      },
                    )
                  ],
                ),
              ),
            ));
          },
        ));
  }
}
