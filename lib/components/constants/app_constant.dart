class AppConstant {
  AppConstant._();
  // Hung
  static const baseAPI = 'http://192.168.1.8:3131';
  //Nhà Đạt
  // static const baseAPI = 'http://192.168.1.2:3131/';
  //Cty
  // static const baseAPI = 'http://192.168.3.41:3131/';
  static const endPointLogin = '$baseAPI/login';
  static const endPointRegister = '$baseAPI/users';
  static const endPointGetListServices = '$baseAPI/services';
  static const endPointGetDetailUser = '$baseAPI/users/:id';
  static const endPointSeachServices = '$baseAPI/services/search';
  static const endPointUpdateDetailUser = '$baseAPI/users/customer/:id';
}
