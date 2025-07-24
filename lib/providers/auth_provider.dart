// providers/auth_provider.dart
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Ici, tu pourrais charger les utilisateurs depuis SQLite ou Firebase
  Future<void> login(String username, String password) async {
    // Exemple simple : identifiants fixes
    if (username == 'admin' && password == 'password') {
      _isLoggedIn = true;
      notifyListeners();
    } else {
      throw Exception('Nom d’utilisateur ou mot de passe incorrect');
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
