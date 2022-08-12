
import 'package:base_pm2/data/model/widget/app/application_model.dart';

class ContextModel {
  List<String>? endUserDeviceMacs;
  String? dnsMode;
  int? createdTime;
  int? updatedTime;
  int? profileId;
  String? contextName;

  String? version;
  int? endDeviceId;
  List<String>? appIds;
  List<String>? categoryIds;
  Map<String, dynamic>? contexts;
  List<RuleAppParentModel>? appRules;
  List<RuleAppParentModel>? categoryRules;

  ContextModel(
      {this.endUserDeviceMacs,
      this.dnsMode,
      this.createdTime,
      this.updatedTime,
      this.profileId,
      this.contextName,
      this.version,
      this.endDeviceId});

  ContextModel.fromJson(Map<String, dynamic> json) {
    if (json['end_user_device_macs'] != null) {
      endUserDeviceMacs = json['end_user_device_macs'].cast<String>();
    }
    dnsMode = json['dnsMode'];
    createdTime = json['created_time'];
    updatedTime = json['updated_time'];
    profileId = json['profile_id'];
    contextName = json['context_name'];
    contexts = json['contexts'];
    if (json['contexts'] != null) {
      Map<String, dynamic> contexts = json['contexts'];
      appIds = contexts['app_keys']?.cast<String>();
      categoryIds = contexts['cate_keys']?.cast<String>();
      appRules = appIds?.map((e) {

        List<RuleAppModel> ruleApps = contexts[e].map<RuleAppModel>((r0) {

          RuleAppModel ruleAppModel = RuleAppModel.fromJson(r0);

          ruleAppModel.id = int.tryParse(e);

          return ruleAppModel;

        }).toList();

        return RuleAppParentModel(id: int.tryParse(e), rules: ruleApps);

      }).toList();

      categoryRules = categoryIds?.map((e) {

        List<RuleAppModel> ruleApps = contexts[e].map<RuleAppModel>((r0) {

          RuleAppModel ruleAppModel = RuleAppModel.fromJson(r0);

          ruleAppModel.id = int.tryParse(e);

          return ruleAppModel;

        }).toList();

        return RuleAppParentModel(id: int.tryParse(e), rules: ruleApps);
      }).toList();
    }

    version = json['version'];
    endDeviceId = json['end_device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (endUserDeviceMacs != null) {
      data['end_user_device_macs'] = endUserDeviceMacs;
    }
    data['dnsMode'] = dnsMode;
    data['created_time'] = createdTime;
    data['updated_time'] = updatedTime;
    data['profile_id'] = profileId;
    data['context_name'] = contextName;

    data['version'] = version;
    data['end_device_id'] = endDeviceId;
    return data;
  }
}
