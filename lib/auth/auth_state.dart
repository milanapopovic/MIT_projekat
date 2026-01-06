import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  bool _isGuest = false;
  String? _email = "popovicmilana123@gmail.com";

  bool get isGuest => _isGuest;
  String? get email => _email;

  void login(String email) {
    _isGuest = false;
    _email = email;
    notifyListeners();
  }

  void register(String email) {
    _isGuest = false;
    _email = email;
    notifyListeners();
  }

  void logout() {
    _isGuest = true;
    _email = null;
    notifyListeners();
  }
}
