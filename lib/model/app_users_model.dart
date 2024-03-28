class AppUsersModel {
  int? user_id;
  String? username;
  String? email;
  String? first_name;
  String? last_name;
  String? password;
  int? role;
  int? status;
  String? avatar;
  String? address_user;
  String? created_at;
  int? created_by_id;
  String? updated_at;
  int? updated_by_id;
  String? phone_number;
  String? api_key;
  int? v;

  AppUsersModel({
    this.user_id,
    this.username,
    this.email,
    this.first_name,
    this.last_name,
    this.password,
    this.role,
    this.status,
    this.avatar,
    this.address_user,
    this.created_at,
    this.created_by_id,
    this.updated_at,
    this.updated_by_id,
    this.phone_number,
    this.api_key,
    this.v,
  });

  factory AppUsersModel.fromJson(Map<String, dynamic> json) {
    return AppUsersModel(
      user_id: json['user_id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      phone_number: json['phone_number'] as String?,
      password: json['password'] as String?,
      role: json['role'] as int?,
      status: json['status'] as int?,
      avatar: json['avatar'] as String?,
      address_user: json['address_user'] as String?,
      created_at: json['created_at'] as String?,
      created_by_id: json['created_by_id'] as int?,
      updated_at: json['updated_at'] as String?,
      updated_by_id: json['updated_by_id'] as int?,
      api_key: json['api_key'] as String?,
      v: json['__v'] as int?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'username': username,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'password': password,
      'role': role,
      'status': status,
      'avatar': avatar,
      'address_user': address_user,
      'created_at': created_at,
      'created_by_id': created_by_id,
      'updated_at': updated_at,
      'updated_by_id': updated_by_id,
      'api_key': api_key,
      '__v': v,
    };
  }
}
