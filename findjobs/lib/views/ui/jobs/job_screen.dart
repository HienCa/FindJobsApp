import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/controllers/bookmark_provider.dart';
import 'package:findjobs/controllers/jobs_provider.dart';
import 'package:findjobs/models/request/bookmarks/bookmarks_model.dart';
import 'package:findjobs/models/request/chat/create_chat_model.dart';
import 'package:findjobs/models/request/chat/send_message_model.dart';
import 'package:findjobs/models/response/job/job_response_model.dart';
import 'package:findjobs/services/helpers/chat_helper.dart';
import 'package:findjobs/services/helpers/messaging_helper.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/height_spacer.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/common/my_button.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/ui/home/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key, required this.title, required this.id});
  final String title;
  final String id;
  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobNotifier, child) {
      jobNotifier.getJob(widget.id);
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: MyAppBar(
                text: widget.title,
                actions: [
                  Consumer<BookMarkNotifier>(
                    builder: (context, bookmarkNotifier, child) {
                      bookmarkNotifier.loadJobs();
                      return GestureDetector(
                        onTap: () {
                          if (bookmarkNotifier.jobs.contains(widget.id)) {
                            bookmarkNotifier.deleteBookmark(widget.id);
                          } else {
                            BookmarkReqResModel model =
                                BookmarkReqResModel(job: widget.id);
                            bookmarkNotifier.addBookmark(model, widget.id);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: !bookmarkNotifier.jobs.contains(widget.id)
                              ? const Icon(CupertinoIcons.bookmark)
                              : const Icon(
                                  CupertinoIcons.bookmark,
                                  color: Colors.yellowAccent,
                                ),
                        ),
                      );
                    },
                  )
                ],
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(CupertinoIcons.arrow_left),
                ),
              )),
          body: FutureBuilder<JobResponseModel>(
            future: jobNotifier.getJob(widget.id),
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
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Stack(
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            const HeightSpacer(size: 30),
                            Container(
                                width: width,
                                height: height * 0.27,
                                color: Color(kLightGrey.value),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(job!.imageUrl),
                                    ),
                                    const HeightSpacer(size: 10),
                                    MyText(
                                        text: job.title,
                                        style: appstyle(22, Color(kDark.value),
                                            FontWeight.w600)),
                                    const HeightSpacer(size: 5),
                                    MyText(
                                        text: job.location,
                                        style: appstyle(16, Color(kDark.value),
                                            FontWeight.w600)),
                                    const HeightSpacer(size: 15),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          MyButton(
                                              text: job.contract,
                                              backgroundColor:
                                                  Color(kOrange.value),
                                              textColor: Color(kLight.value)),
                                          Row(
                                            children: [
                                              MyText(
                                                  text: job.salary,
                                                  style: appstyle(
                                                      22,
                                                      Color(kDark.value),
                                                      FontWeight.w600)),
                                              SizedBox(
                                                width: width * 0.2,
                                                child: MyText(
                                                    text: "/${job.period}",
                                                    style: appstyle(
                                                        22,
                                                        Color(kDark.value),
                                                        FontWeight.w600)),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            const HeightSpacer(size: 20),
                            MyText(
                                text: job.description,
                                style: appstyle(
                                    22, Color(kDark.value), FontWeight.w600)),
                            const HeightSpacer(size: 10),
                            Text(desc,
                                textAlign: TextAlign.justify,
                                maxLines: 8,
                                style: appstyle(22, Color(kDarkGrey.value),
                                    FontWeight.normal)),
                            const HeightSpacer(size: 20),
                            MyText(
                                text: "Requirements",
                                style: appstyle(
                                    22, Color(kDark.value), FontWeight.w600)),
                            const HeightSpacer(size: 10),
                            SizedBox(
                              height: height * 0.6,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: job.requirements.length,
                                  itemBuilder: (context, index) {
                                    final req = job.requirements[index];
                                    String bullet = "\u2022";
                                    return Text("$bullet $req\n",
                                        maxLines: 4,
                                        textAlign: TextAlign.justify,
                                        style: appstyle(22, Color(kDark.value),
                                            FontWeight.w600));
                                  }),
                            ),
                            const HeightSpacer(size: 20),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: MyButton(
                                onTap: () {
                                  CreateChat model =
                                      CreateChat(userId: job.agentId);
                                  ChatHelper.apply(model).then((response) {
                                    if (response[0]) {
                                      SendMessageModel model = SendMessageModel(
                                          content:
                                              "Hello, I'm interested in ${job.title} job in ${job.location}",
                                          chatId: response[1],
                                          receiver: job.agentId);
                                      MessagingHelper.sendMessage(model)
                                          .whenComplete(() {
                                        Get.to(() => const MainScreen());
                                      });
                                    }
                                  });
                                },
                                widthBtn: width,
                                heightBtn: height * 0.06,
                                text: "Apply Now",
                                backgroundColor: Color(kOrange.value),
                                textColor: Color(kLight.value)),
                          ),
                        )
                      ],
                    ));
              }
            },
          ));
    });
  }
}
