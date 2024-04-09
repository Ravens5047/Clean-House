class ForgotPasswordReponse {
  final String? message;
  final String? otp;

  ForgotPasswordReponse({
    required this.message,
    required this.otp,
  });

  factory ForgotPasswordReponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordReponse(
      message: json['message'] as String,
      otp: json['otp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'otp': otp,
    };
  }
}
