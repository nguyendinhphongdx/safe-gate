class AccountModel {
  String? uid;
  String? name;
  String? phone;
  String? mobile;
  String? email;
  String? birthday;
  String? avatar;
  String? password;
  String? token;

  AccountModel(
      {this.uid,
      this.name,
      this.phone,
      this.email,
      this.birthday,
      this.mobile,
      this.avatar});

  AccountModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    birthday = json['birday'];
    avatar = json['avatar'];
    password = json['password'];
    mobile = json['mobile'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['birday'] = birthday;
    data['avatar'] = avatar;
    data['password'] = password;
    data['mobile'] = mobile;
    data['token'] = token;
    return data;
  }
}
