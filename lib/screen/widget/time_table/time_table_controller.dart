import 'package:base_pm2/common/core/sys/base_controller.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/page_manager/route_path.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/time_table_edit/edit_user_controller.dart';
import 'package:get/get.dart';

class TimeTableArgs {
  String id = '';

  String title = '';

  TimeTableArgs({this.id = '', this.title = ''});

  TimeTableArgs.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class TimeTableController extends BaseController {
  TimeTableArgs? args;

  @override
  Future initialData() async {
    args = TimeTableArgs.fromJson(Get.parameters);
    setStatus(Status.success);
  }

  void editTimeTable() {
    Get.toNamed(RoutePath.TIME_TABLE_EDIT,parameters: EditUserArgs(type: UserEditType.PICK_MODE_AND_DEVICE).toJson());
  }
}
