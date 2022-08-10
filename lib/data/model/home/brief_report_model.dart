/// connections : 10
/// violatecount : 3
/// bandwidth : 350
/// spenttime : 2.5

class BriefReportModel {
  BriefReportModel({
    this.connections,
    this.violatecount,
    this.bandwidth,
    this.spenttime,
  });

  BriefReportModel.fromJson(dynamic json) {
    connections = json['connections'] ?? 0;
    violatecount = json['violatecount'] ?? 0;
    bandwidth = json['bandwidth'] ?? 0;
    spenttime = json['spenttime'] ?? 0;
  }

  int? connections;
  int? violatecount;
  int? bandwidth;
  double? spenttime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['connections'] = connections;
    map['violatecount'] = violatecount;
    map['bandwidth'] = bandwidth;
    map['spenttime'] = spenttime;
    return map;
  }
}
