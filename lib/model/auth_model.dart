class AuthModel {
  final bool status;
  final String message;
  final int userId;
  final String? shopId;
  final String email;
  final String phoneNumber;
  final String name;
  final String profileImage;
  final int userRole;
  final String gender;
  final int age;
  final String accessToken;
  final String refreshToken;

  AuthModel({
    required this.status,
    required this.message,
    required this.userId,
    this.shopId,
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.profileImage,
    required this.userRole,
    required this.gender,
    required this.age,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return AuthModel(
      status: json['status'] ?? false,
      message: json['message'] ?? "",
      userId: user['user_id'] ?? 0,
      shopId: user['shop_id']?.toString(),
      email: user['email'] ?? "",
      phoneNumber: user['phone_number'] ?? " ",
      name: user['name'],
      profileImage: user['profile_image'] ?? "",
      userRole: user['user_role'] ?? 0,
      gender: user['gender'] ?? "",
      age: user['age'] ?? 0,
      accessToken: json['access_token'] ?? "",
      refreshToken: json['refresh_token'] ?? "",
    );
  }
}
