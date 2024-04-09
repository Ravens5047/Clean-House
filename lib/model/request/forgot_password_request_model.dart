class ForgotPasswordRequest {
  final String? email;
  final String? otp;

  ForgotPasswordRequest({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}
