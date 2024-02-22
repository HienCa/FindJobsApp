import 'dart:convert';

import 'package:findjobs/models/request/auth/login_model.dart';
import 'package:findjobs/models/request/auth/register_model.dart';
import 'package:findjobs/models/request/user/profile_update_model.dart';
import 'package:findjobs/models/response/auth/login_response_model.dart';
import 'package:findjobs/models/response/user/profile_response_model.dart';
import 'package:findjobs/services/config.dart';
import 'package:findjobs/views/common/sharedpreferences.dart';
import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();
  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.https(Config.apiUrl, Config.loginUrl);

    var response = await client.post(url,
        body: jsonEncode(model), headers: requestHeaders);
    if (response.statusCode == 200) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = loginResponseModelFromJson(response.body).token;
      String userId = loginResponseModelFromJson(response.body).id;
      String profile = loginResponseModelFromJson(response.body).profile;

      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('profile', profile);
      await prefs.setBool('loggedIn', true);

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> register(RegisterModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.https(Config.apiUrl, Config.signupUrl);

    var response = await client.post(url,
        body: jsonEncode(model), headers: requestHeaders);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProfile(
      ProfileUpdateReq model, String userId) async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, "${Config.profileUrl}/$userId");

    var response = await client.post(url,
        body: jsonEncode(model), headers: requestHeaders);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<ProfileResponseModel> getProfile() async {
    String? token = await MyCacheManager.getFromCache('token');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);

    var response = await client.post(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var profile = profileResponseModelFromJson(response.body);
      return profile;
    } else {
      throw Exception("Failed to get the profile");
    }
  }
}
