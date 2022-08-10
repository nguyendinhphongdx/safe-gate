import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/data/model/mode_model.dart';

class ConfigModel {
  String? cdnDomain;
  String? apiDomain;
  String? favicon;
  List<ModeModel>? modes;

  ConfigModel({this.cdnDomain, this.modes});

  List<ModeModel> getModes() {
    modes?.forEach((element) => element.isActive?.value = false);
    return modes ?? [];
  }

  String getImageUrl() {
    return cdnDomain!;
  }

  String getApiUrl() {
    return apiDomain ?? HttpConstant.BASE_URL;
  }

  ConfigModel.fromJson(Map<String, dynamic> json) {
    cdnDomain = json['cdn_domain'];
    apiDomain = json['api_domain'];
    favicon = json['favicon'];
    if (json['modes'] != null) {
      modes = <ModeModel>[];
      json['modes'].forEach((v) {
        modes!.add(ModeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cdn_domain'] = cdnDomain;
    data['api_domain'] = apiDomain;
    data['favicon'] = favicon;
    if (modes != null) {
      data['modes'] = modes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
