import 'package:flutter/material.dart';
import 'package:innerix/model/otp_model.dart';
import 'package:innerix/service/otpService.dart';

class OtpProvider extends ChangeNotifier {
  final OtpService otpService = OtpService();

  bool isLoading = false;
  String? error;
  OtpRequestModel? otpRequest;
  OtpVerifyModel? otpVerify;

  Future<void> requestOtp(String email, String password) async {
    isLoading =true;
    try {
      otpRequest = await otpService.requestOtp(email, password);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading =false;
    notifyListeners();
  }

  Future<void> verifyOtp(String email, String otp) async {
    isLoading =true;
    try {
      otpVerify = await otpService.verifyOtp(email, otp);
      error = null;
    } catch (e) {
      error = e.toString();
    }
    isLoading =false;
    notifyListeners();
  }

  
}
