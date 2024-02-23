// ignore_for_file: avoid_print

import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:findjobs/views/common/my_text.dart';
import 'package:findjobs/views/common/my_textfield.dart';
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
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Icon(
              CupertinoIcons.search,
              color: Color(kLight.value),
            ),
          ),
          // validator: (keysearch) {
          //   print(keysearch);
          // },
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/search-jobs.jpg"),
              MyText(
                  text: "Start search for jobs",
                  style: appstyle(24, Color(kDark.value), FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
