class RegisterModel {
  Data? data;
  String? message;

  RegisterModel({this.data, this.message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? lastName;
  String? mobile;
  String? rePassword;
  String? role;
  String? username;
  String? dob;
  String? firstName;
  String? password;
  String? email;
  String? gender;
  String? verifiedAt;
  String? avatar;
  String? phoneVerifiedAt;
  int? id;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  User({
    this.lastName,
    this.mobile,
    this.rePassword,
    this.role,
    this.username,
    this.dob,
    this.firstName,
    this.password,
    this.email,
    this.gender,
    this.verifiedAt,
    this.avatar,
    this.phoneVerifiedAt,
    this.id,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    lastName = json['lastName'];
    mobile = json['mobile'];
    rePassword = json['re_password'];
    role = json['role'];
    username = json['username'];
    dob = json['dob'];
    firstName = json['firstName'];
    password = json['password'];
    email = json['email'];
    gender = json['gender'];
    verifiedAt = json['verifiedAt'];
    avatar = json['avatar'];
    phoneVerifiedAt = json['phoneVerifiedAt'];
    id = json['id'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['re_password'] = rePassword;
    data['role'] = role;
    data['username'] = username;
    data['dob'] = dob;
    data['firstName'] = firstName;
    data['password'] = password;
    data['email'] = email;
    data['gender'] = gender;
    data['verifiedAt'] = verifiedAt;
    data['avatar'] = avatar;
    data['phoneVerifiedAt'] = phoneVerifiedAt;
    data['id'] = id;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
