class AppConstant {
  AppConstant._();

  static const baseAPI = 'http://172.21.3.229:3131';
  // static const baseAPI = 'http://192.168.1.2:3131/'; //Nhà Đạt
  // static const baseAPI = 'http://192.168.3.41:3131/'; //Cty
  static const baseAPIimages = '$baseAPI/images/';
  static const endPointLogin = '$baseAPI/login';
  static const endPointLogin1 = '$baseAPI/loginEmployee';
  static const endPointChangePassword = '$baseAPI/changePassword/:id';
  static const endPointRegister = '$baseAPI/users';
  static const endPointGetListServices = '$baseAPI/services';
  static const endPointGetDetailUser = '$baseAPI/users/:id';
  static const endPointUpdateDetailUser = '$baseAPI/users/customer/:id';
  static const endPointSeachServices = '$baseAPI/services/search';

  static const endPointVNPAY = 'http://localhost:3000/payment-url';
  static const endPointVNPAY1 =
      'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_Amount=1000000&vnp_Command=pay&vnp_CreateDate=20240403221915&vnp_CurrCode=VND&vnp_IpAddr=1.1.1.1&vnp_Locale=vn&vnp_OrderInfo=123456&vnp_OrderType=other&vnp_ReturnUrl=http%3A%2F%2Flocalhost%3A3000%2Fvnpay-return&vnp_TmnCode=2QXUI4B4&vnp_TxnRef=123456&vnp_Version=2.1.0&vnp_SecureHash=a52bfa6e3a81179c1ecec202483999d35930c0443585da36ae39fc18a3f2d600e2041c8e63f1bf097ef6dec53f22fd68277a3f940dd52bab257b67b30259a5d9';
}
