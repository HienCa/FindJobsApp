import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/ui/home/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookMarkPage extends StatefulWidget {
  const BookMarkPage({super.key});

  @override
  State<BookMarkPage> createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: MyAppBar(
            text: "Bookmark",
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
    );
  }
}
