import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/models/request/auth/register_model.dart';
import 'package:findjobs/services/helpers/auth_helper.dart';
import 'package:findjobs/views/ui/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;

  set obscureText(bool newSate) {
    _obscureText = newSate;
    notifyListeners();
  }

  //hoa, thuong, so, ky tu dac biet, >8 ky tu
  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  final registerFormKey = GlobalKey<FormState>();
  bool validateAndSave() {
    final form = registerFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  upRegister(RegisterModel model) {
    AuthHelper.register(model).then((response) {
      if (response) {
        Get.off(() => {const LoginPage()},
            transition: Transition.fade, duration: const Duration(seconds: 2));
      } else {
        Get.snackbar("Register Failed", "Please check your infomation!",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }
}
