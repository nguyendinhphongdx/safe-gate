import 'package:base_pm2/common/core/interface/i_report_listener.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/profile/profile_model.dart';
import 'package:base_pm2/data/repositories_impl/profile/profile_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/get_all_profile_use_case.dart';
import 'package:base_pm2/screen/report/controllers/today_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ReportController extends IReportListener with GetTickerProviderStateMixin {
  TabController? tabController;

  @override
  Future initialData() async {
    tabController = TabController(length: 5, vsync: this);
    await fetchProfiles();
    setStatus(Status.success);
  }

  @override
  Future<void> fetchProfiles() async {
    ApiResponse<List<ProfileModel?>?> response =
    await GetAllProfileUseCase(repository: ProfileRepositoryImpl(), deviceId: AppConfig().getDeviceId())
        .invoke();
    if (checkCode(response)) return;
    mProfiles.value = response.data ?? [];
    mProfiles.firstOrNull?.isSelected.value = true;
  }
}
