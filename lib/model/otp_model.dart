class OtpRequestModel {
  final String message;
  final int otp;
  final bool status;

  OtpRequestModel({
    required this.message,
    required this.otp,
    required this.status,
  });

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) {
    return OtpRequestModel(
      message: json['message'] ?? '',
      otp: json['otp'] ?? 0,
      status: json['status'] ?? false,
    );
  }
}



class OtpVerifyModel {
  final String message;
  final bool status;

  OtpVerifyModel({
    required this.message,
    required this.status,
  });

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    return OtpVerifyModel(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }
}
