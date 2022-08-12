class HandleHistoryModel {
  String? actionName;
  String? value;
  String? extend;

  HandleHistoryModel({this.actionName, this.value, this.extend});

  HandleHistoryModel.fromJson(Map<String, dynamic> json) {
    actionName = json['action-name'];
    value = json['value'];
    extend = json['extend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action-name'] = actionName;
    data['value'] = value;
    data['extend'] = extend;
    return data;
  }
}
