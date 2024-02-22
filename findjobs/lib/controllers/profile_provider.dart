import 'package:findjobs/models/response/user/profile_response_model.dart';
import 'package:findjobs/services/helpers/auth_helper.dart';
import 'package:flutter/material.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<ProfileResponseModel>? profile;
  getProfile() async {
    profile = AuthHelper.getProfile();
  }
}
