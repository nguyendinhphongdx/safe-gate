import 'package:get/get.dart';

class UserModel {
  String? uid;
  String? name;
  String? birthday;
  String? sex;
  String? avatar;
  RxBool? isSelected;

  UserModel({this.uid, this.name, this.birthday, this.sex, this.avatar,this.isSelected});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    birthday = json['birday'];
    sex = json['sex'];
    avatar = json['avatar'];
    isSelected = true.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['birday'] = birthday;
    data['sex'] = sex;
    data['avatar'] = avatar;
    return data;
  }
}
