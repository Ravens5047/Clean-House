class AppConstant {
  AppConstant._();

  static const baseAPI = 'http://192.168.0.65:3131';
  static const endPointLogin = '$baseAPI/login';
  static const endPointRegister = '$baseAPI/users';
  static const endPointGetListServices = '$baseAPI/services';
  static const endPointGetDetailUser = '$baseAPI/users/:id';
  static const endPointSeachServices = '$baseAPI/services/search';
}
