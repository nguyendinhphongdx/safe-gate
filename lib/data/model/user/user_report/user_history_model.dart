class UserHistoryModel {
  UserHistoryModel({
      this.id, 
      this.type, 
      this.appName,
      this.url, 
      this.time, 
      this.brief, 
      this.description, 
      this.action,});

  UserHistoryModel.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    appName = json['appname'];
    url = json['url'];
    time = json['time'];
    brief = json['brief'];
    description = json['description'];
    action = json['action'];
  }
  int? id;
  int? type;
  String? appName;
  String? url;
  int? time;
  String? brief;
  String? description;
  String? action;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['appname'] = appName;
    map['url'] = url;
    map['time'] = time;
    map['brief'] = brief;
    map['description'] = description;
    map['action'] = action;
    return map;
  }

}