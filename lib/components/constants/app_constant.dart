class AppConstant {
  AppConstant._();

  static const baseTodo = 'http://206.189.150.98:3000/api/v1';

  static const endPointAuthRegister = '$baseTodo/auth/register';
  static const endPointOtp = '$baseTodo/auth/send-otp';
  static const endPointLogin = '$baseTodo/auth/login';
  static const endPointForgotPassword = '$baseTodo/auth/forgot-password';
  static const endPointChangePassword = '$baseTodo/auth/change-password';
}
