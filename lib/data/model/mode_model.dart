import 'package:base_pm2/common/resource/keylanguage_resource/vi_vn.dart';
// import 'package:base_pm2/data/model/profile_model.dart';
import 'package:get/get.dart';

class ModeModel {
  int? id;
  String? name;
  String? icon;
  String? type;
  String? description;
  // List<ProfileModel>? profiles;
  List<String>? policies;
  String? author;
  String? image;
  RxBool? isActive;

  Languages? languages;
  ModeModel(
      {this.id,
      this.name,
      this.description,
      this.icon,
      this.policies,
      this.type,
      // this.profiles,
      this.author,
      this.image,
      this.isActive});

  ModeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    icon = json['icon'];
    policies = json['policies'];
    // if (json['profiles'] != null) {
    //   profiles = <ProfileModel>[];
    //   json['profiles'].forEach((v) {
    //     profiles!.add(ProfileModel.fromJson(v));
    //   });
    // }
    languages = json['languages'] != null
        ? Languages.fromJson(json['languages'])
        : null;
    author = json['author'];
    isActive = false.obs;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['description'] = description;
    data['policies'] = policies;
    // if (profiles != null) {
    //   data['profiles'] = profiles!.map((v) => v.toJson()).toList();
    // }
    data['author'] = author;
    return data;
  }
}

class Languages {
  Vi? vi;
  Vi? en;

  Languages({this.vi, this.en});

  Languages.fromJson(Map<String, dynamic> json) {
    vi = json['vi'] != null ? Vi.fromJson(json['vi']) : null;
    en = json['en'] != null ? Vi.fromJson(json['en']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (vi != null) {
      data['vi'] = vi!.toJson();
    }
    if (en != null) {
      data['en'] = en!.toJson();
    }
    return data;
  }
}

class Vi {
  String? description;
  String? name;

  Vi({this.description, this.name});

  Vi.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['name'] = name;
    return data;
  }
}
