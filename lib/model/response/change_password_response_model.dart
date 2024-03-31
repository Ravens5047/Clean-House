class ChangePasswordResponse {
  final String? message;
  final String? newPassword;

  ChangePasswordResponse({
    required this.message,
    required this.newPassword,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      message: json['message'] as String,
      newPassword: json['newPassword'] as String,
    );
  }
}
