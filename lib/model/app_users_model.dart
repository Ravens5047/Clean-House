class AppUsersModel {
  String? userid;
  String? username;
  String? email;
  String? password;
  String? roleid;
  String? avatar;
  String? addressuser;
  String? createdAt;
  String? createdbyid;
  String? updatedAt;
  String? updatebyid;
  String? phonenumber;
  int? v;

  bool? status;

  AppUsersModel({
    this.userid,
    this.username,
    this.email,
    this.password,
    this.roleid,
    this.status,
    this.avatar,
    this.addressuser,
    this.createdAt,
    this.createdbyid,
    this.updatedAt,
    this.updatebyid,
    this.phonenumber,
    this.v,
  });

  factory AppUsersModel.fromJson(Map<String, dynamic> json) {
    return AppUsersModel(
      userid: json['_userid'] as String?,
      username: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      roleid: json['role_id'] as String?,
      avatar: json['avatar'] as String?,
      addressuser: json['addressuser'] as String?,
      createdAt: json['createdAt'] as String?,
      createdbyid: json['createbyid'] as String?,
      updatedAt: json['updatedAt'] as String?,
      updatebyid: json['updatebyid'] as String?,
      v: json['__v'] as int?,
    );
  }
}
