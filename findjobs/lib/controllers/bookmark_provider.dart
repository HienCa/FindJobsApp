// ignore_for_file: prefer_final_fields

import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/models/request/bookmarks/bookmarks_model.dart';
import 'package:findjobs/models/response/bookmark/all_bookmark.dart';
import 'package:findjobs/services/helpers/bookmark_helper.dart';
import 'package:findjobs/views/common/sharedpreferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkNotifier extends ChangeNotifier {
  List<String> _jobs = [];
  List<String> get jobs => _jobs;
  Future<List<AllBookmarkModel>>? bookmarks;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addJob(String jobId) async {
    if (_jobs.isNotEmpty) {
      _jobs.insert(0, jobId);
      MyCacheManager.addToCache('jobId', _jobs);
      notifyListeners();
    }
  }

  removeJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs.isNotEmpty) {
      _jobs.remove(jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');
    if (jobs != null) {
      _jobs = jobs;
    }
  }

  addBookmark(BookmarkReqResModel model, String jobId) {
    BookmarkHelper.addBookmarks(model).then((response) {
      if (response[0]) {
        addJob(jobId);
        Get.snackbar(
            "Bookmark successfully added!", "Please check your credentials",
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: const Icon(Icons.bookmark_add));
      } else if (!response[0]) {
        Get.snackbar("Failed to add Bookmark!", "Please try again!",
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: const Icon(Icons.bookmark_add));
      }
    });
  }

  deleteBookmark(String jobId) {
    BookmarkHelper.deleteBookmark(jobId).then((response) {
      if (response) {
        removeJob(jobId);
        Get.snackbar(
            "Bookmark successfully deleted!", "Please check your credentials",
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: const Icon(Icons.bookmark_remove));
      } else if (!response) {
        Get.snackbar("Failed to delete Bookmark!", "Please try again!",
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: const Icon(Icons.bookmark_remove));
      }
    });
  }

  getBookmarks() {
    bookmarks = BookmarkHelper.getBookmarks();
    

  }
}
