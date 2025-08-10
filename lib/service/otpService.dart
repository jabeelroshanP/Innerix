import 'package:dio/dio.dart';
import 'package:innerix/model/otp_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpService {
  final Dio _dio = Dio();
  final String baseUrl = "https://app.ecominnerix.com/api";

  Future<OtpRequestModel> requestOtp(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      final formData = FormData.fromMap({"email": email, "password": password});

      final response = await _dio.post(
        "$baseUrl/request-otp",
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      return OtpRequestModel.fromJson(response.data);
    } catch (e) {
      throw Exception("OTP Request failed: $e");
    }
  }

  Future<OtpVerifyModel> verifyOtp(String email, String otp) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      final formData = FormData.fromMap({"email": email, "otp": otp});

      final response = await _dio.post(
        "$baseUrl/verify-email-otp",
        data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      return OtpVerifyModel.fromJson(response.data);
    } catch (e) {
      throw Exception("OTP Verification failed: $e");
    }
  }
}
