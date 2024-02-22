import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/models/request/auth/login_model.dart';
import 'package:findjobs/models/request/user/profile_update_model.dart';
import 'package:findjobs/services/helpers/auth_helper.dart';
import 'package:findjobs/views/common/sharedPreferences.dart';
import 'package:findjobs/views/ui/home/main_screen.dart';
import 'package:findjobs/views/ui/profile/update_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;

  set obscureText(bool newSate) {
    _obscureText = newSate;
    notifyListeners();
  }

  bool _firstTime = true;
  bool get firstTime => _firstTime;

  set firstTime(bool newSate) {
    _firstTime = newSate;
    notifyListeners();
  }

  bool? _entrypoint;
  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newSate) {
    _entrypoint = newSate;
    notifyListeners();
  }

  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newSate) {
    _loggedIn = newSate;
    notifyListeners();
  }

  getPrefs() async {
    entrypoint = await MyCacheManager.getFromCacheBool('entrypoint') ?? false;
    loggedIn = await MyCacheManager.getFromCacheBool('loggedIn') ?? false;
  }

  final loginFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  final profileFormKey = GlobalKey<FormState>();
  bool profileValidateAndSave() {
    final form = profileFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  userLogin(LoginModel model) {
    AuthHelper.login(model).then((response) {
      if (response && firstTime) {
        Get.off(() => const PersonalDetails());
      } else if (response && !firstTime) {
        Get.off(() => const MainScreen());
      } else if (!response) {
        Get.snackbar("Sign Failed", "Please Check your credential",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  logout() async {
    await MyCacheManager.removeCache('token');
    await MyCacheManager.addToCacheBool('loggedIn', false);
    _firstTime = false;
  }

  updateProfile(ProfileUpdateReq model) async {
    String? userId = await MyCacheManager.getFromCache('id');
    if (userId!.isNotEmpty) {
      AuthHelper.updateProfile(model, userId).then((response) {
        if (response && firstTime) {
          Get.snackbar("Update Successful!", "Enjoy your search for a job!",
              colorText: Color(kLight.value),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.add_alert));
          Future.delayed(const Duration(seconds: 3))
              .then((value) => {Get.offAll(() => const MainScreen())});
        } else {
          Get.snackbar("Update Failed", "Please try again!",
              colorText: Color(kLight.value),
              backgroundColor: Colors.red,
              icon: const Icon(Icons.add_alert));
        }
      });
    } else {
      Get.snackbar("Update Failed", "Please try again!",
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.add_alert));
    }
  }
}
