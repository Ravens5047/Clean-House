class ChangePasswordOtpResponse {
  final String? message;
  final String? newPassword;

  ChangePasswordOtpResponse({
    required this.message,
    required this.newPassword,
  });

  factory ChangePasswordOtpResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordOtpResponse(
      message: json['message'] as String,
      newPassword: json['newPassword'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'newPassword': newPassword,
    };
  }
}
