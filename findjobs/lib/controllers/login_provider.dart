import 'package:flutter/material.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;
  bool get obscureText => _obscureText;

  set obscureText(bool newSate) {
    _obscureText = newSate;
    notifyListeners();
  }
}
