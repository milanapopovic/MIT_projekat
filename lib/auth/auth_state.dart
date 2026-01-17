import 'package:flutter/foundation.dart';

class AuthState extends ChangeNotifier {
  bool _isGuest = false;
  String? _email = 'popovicmilana123@gmail.com';

   static const Set<String> _adminEmails = {
    'admin@gmail.com',
  };

  bool get isGuest => _isGuest;
  String? get email => _email;

   bool get isAdmin {
    final e = _email?.trim().toLowerCase();
    if (e == null) return false;
    return _adminEmails.contains(e);
  }

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
