import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:innerix/model/auth_model.dart';

class AuthService {
  Dio dio = Dio();

  final baseUrl = "https://app.ecominnerix.com/api/login";

  Future<AuthModel?> getLogin(email, password) async {
    try {
      final response = await dio.post(
        baseUrl,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        log(response.data.toString());
        return AuthModel.fromJson(data);
      } else {
        log("Login failed ${response.statusMessage}");
        log(response.statusMessage.toString());
        return null;
      }
    } catch (e) {
      log("login error $e");
      return null;
    }
  }
}
