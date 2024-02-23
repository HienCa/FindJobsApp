import 'package:findjobs/controllers/bookmark_provider.dart';
import 'package:findjobs/models/response/bookmark/all_bookmark.dart';
import 'package:findjobs/views/common/my_appbar.dart';
import 'package:findjobs/views/ui/bookmarks/widgets/bookmark_widget.dart';
import 'package:findjobs/views/ui/home/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
      body: Consumer<BookMarkNotifier>(
        builder: (context, bookmarkNotifier, child) {
          bookmarkNotifier.getBookmarks();
          return FutureBuilder<List<AllBookmarkModel>>(
            future: bookmarkNotifier.bookmarks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                final bookmarks = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookmarks!.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarks[index];

                    return BookmarkTileWidget(job: bookmark);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
