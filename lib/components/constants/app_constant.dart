class AppConstant {
  AppConstant._();

  // static const baseAPI = 'http://172.25.228.101:3131'; // DT
  static const baseAPI = 'http://192.168.1.4:3131'; // Home
  // static const baseAPI = 'http://192.168.1.171:3131'; // Cty Hwgn
  // static const baseAPI = 'http://192.168.1.2:3131/'; //Nhà Đạt
  // static const baseAPI = 'http://192.168.3.41:3131/'; //Cty
  // static const baseAPI = 'http://localhost:3131';
  static const baseAPIimages = '$baseAPI/images/';
  static const endPointLogin = '$baseAPI/login';
  static const endPointLogin1 = '$baseAPI/loginEmployee';
  static const endPointChangePassword = '$baseAPI/changePassword/:id';
  static const endPointRegister = '$baseAPI/users';
  static const endPointGetListServices = '$baseAPI/services';
  static const endPointGetDetailUser = '$baseAPI/users/:id';
  static const endPointUpdateDetailUser = '$baseAPI/users/customer/:id';
  static const endPointSeachServices = '$baseAPI/services/search';
  static const endPointForgotPassword = '$baseAPI/forgotPasswordApp';
  static const endPointChangePasswordOTP = '$baseAPI/changePasswordForgotApp';
  static const endPointResendOTP = '$baseAPI/resendOTP';
  static const endPointBookingOrderDetails = '$baseAPI/order/addOrder';
  static const endPointGetListOrderDetails = '$baseAPI/order';
  static const endPointGetListOrderDetailsByUserID = '$baseAPI/order_id/:id';
  static const endPointSeachServicesBooking =
      '$baseAPI/services/searchOrderDetailServices';
  static const endPointUpdateStatusIDOrder =
      '$baseAPI/orders/:order_id/update-status';

  //API VNPAY PAYMENTS
  static const endPointVNPAY = 'http://192.168.1.4:8888/order';
  static const endPointCreatePaymentURL = '$endPointVNPAY/create_payment_url';
  static const endPointQueryDr = '$endPointVNPAY/querydr';
  static const endPointRefund = '$endPointVNPAY/refund';
  static const endPointReturn = '$endPointVNPAY/vnpay_return';
}
