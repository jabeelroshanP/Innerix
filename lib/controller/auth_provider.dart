import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:innerix/model/auth_model.dart';
import 'package:innerix/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool isLoading = false;
  final AuthService service = AuthService();
  AuthModel? user;
  String? error;

  Future<void> getLogin(String email, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await service.getLogin(email, password);
      if (result != null && result.status) {
        user = result;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", result.accessToken);
        log("Saved token: ${result.accessToken}");

        await prefs.setString("refresh_token", result.refreshToken);
      } else if (result != null && !result.status) {
        error = result.message;
      } else {
        error = "Login Failed Please try again.";
      }
    } catch (e) {
      error = "Something went wrong";
    }
    isLoading = false;
    notifyListeners();
  }
}
