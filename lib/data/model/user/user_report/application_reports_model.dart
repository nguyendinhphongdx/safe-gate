class ApplicationReportsModel {
  ApplicationReportsModel({
      this.id, 
      this.applicationId,
      this.spentTime,
      this.time,});

  ApplicationReportsModel.fromJson(dynamic json) {
    id = json['id'];
    applicationId = json['applicationid'];
    spentTime = json['spenttime'];
    time = json['time'];
  }
  int? id;
  int? applicationId;
  int? spentTime;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['applicationid'] = applicationId;
    map['spenttime'] = spentTime;
    map['time'] = time;
    return map;
  }

}