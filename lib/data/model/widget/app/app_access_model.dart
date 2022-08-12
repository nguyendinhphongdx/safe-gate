class AppAccessParentModel {
  String? date;
  AppAccessModel? simpleModel;
  List<AppAccessModel>? appAccess;
  List<AppAccessParentModel>? appAccessParentRetail;
  int? countViolation;

  AppAccessParentModel({this.date,this.appAccess,this.simpleModel,this.appAccessParentRetail,this.countViolation});

  AppAccessParentModel.fromJson(dynamic json) {
    // appAccess = json?.map((element) => AppAccessModel.fromJson(element)).toList();
    // date = appAccess?.firstOrNull?.date;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    return data;
  }
}


class AppAccessModel {
  String? date;
  String? appName;
  int? count;
  List<int>? time;

  AppAccessModel({this.date, this.appName, this.count, this.time});

  AppAccessModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    appName = json['app_name'];
    count = json['count'];
    time = json['time'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['app_name'] = appName;
    data['count'] = count;
    data['time'] = time;
    return data;
  }
}
