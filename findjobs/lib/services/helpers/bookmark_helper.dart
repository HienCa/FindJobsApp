import 'dart:convert';

import 'package:findjobs/models/request/bookmarks/bookmarks_model.dart';
import 'package:findjobs/models/response/bookmark/all_bookmark.dart';
import 'package:findjobs/models/response/bookmark/bookmark_res.dart';
import 'package:findjobs/services/config.dart';
import 'package:findjobs/views/common/sharedpreferences.dart';
import 'package:http/http.dart' as https;

class BookmarkHelper {
  static var client = https.Client();

  static Future<List<dynamic>> addBookmarks(BookmarkReqResModel model) async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      String bookmarkId = bookmarkReqResFromJson(response.body).id;
      return [true, bookmarkId];
    } else {
      throw [false];
    }
  }

  static Future<bool> deleteBookmark(String jobId) async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "${Config.bookmarkUrl}/$jobId");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw false;
    }
  }

  static Future<List<AllBookmarkModel>> getBookmarks() async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.bookmarkUrl);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var bookmarks = allBookmarkModelFromJson(response.body);
      return bookmarks;
    } else {
      throw Exception("Failed to load bookmarks!");
    }
  }
}
