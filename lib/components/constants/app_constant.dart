class AppConstant {
  AppConstant._();

  static const baseAPI = 'http://192.168.1.4:3131';

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
}
