class ChangePasswordRequest {
  final int? user_id;
  final String? oldPassword;
  final String? newPassword;

  ChangePasswordRequest({
    required this.user_id,
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}
