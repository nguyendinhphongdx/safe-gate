import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/core/widget/time/timeline_comp.dart';
import 'package:base_pm2/common/extension/app_extension.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/data/model/report/report_model.dart';
import 'package:base_pm2/data/model/profile/report_profile_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/device/get_history_by_device_id_use_case.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:flutter/material.dart';

class TimeLineAppComp extends StatefulWidget {
  final ViolationHeaderData? violationData;
  final String? profileId;

  const TimeLineAppComp({this.violationData, Key? key, this.profileId}) : super(key: key);

  @override
  State<TimeLineAppComp> createState() => _TimeLineAppCompState();
}

class _TimeLineAppCompState extends State<TimeLineAppComp> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    if (widget.violationData?.reportProfileModel != null) return;
    ApiResponse<ReportProfileModel?> response = await GetHistoryByDeviceIdUseCase(
            repository: DeviceRepositoryImpl(),
            profileId: widget.profileId ?? ProfileManager().getProfile().profileId.toString(),
            deviceId: AppConfig().getDeviceId(),
            dateTime: widget.violationData?.dateTime ?? '20220727')
        .invoke();
    if (response.err?.code != CodeConstant.OK) return;
    widget.violationData?.reportProfileModel = response.data ?? ReportProfileModel();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!Utils.isNotNullAndEmpty(widget.violationData?.reportProfileModel?.reportModels)) {
      return const Padding(padding: EdgeInsets.all(8.0), child: EmptyView());
    }
    return TimelineComp(
        endFlex: 3,
        indicatorMarginTop: 12,
        lineSize: 0.5,
        indicatorBackgroundColor: Colors.transparent,
        endIndicatorStart: SizedBox(
          height: 0,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 24, left: 24),
            child: Text('10:00', style: appStyle.textTheme.subtitle1),
          ),
        ),
        children: widget.violationData?.reportProfileModel?.reportModels
                ?.mapIndexed<TimeChild>(_buildItem)
                .toList() ??
            []);
  }

  TimeChild _buildItem(int index, AppReportDataModel? element) {
    return TimeChild(
      startChild: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 24, left: 24),
        child: Text(
          element?.day ?? '',
          style: appStyle.textTheme.subtitle1,
        ),
      ),
      endChild: Column(
        children: element?.dayReports?.mapIndexed<Widget>(_buildEndItem).toList() ?? [],
      ),
    );
  }

  // TODO ghép api ảnh => thay appname vào favicon
  Widget _buildEndItem(int index, AppReportDayModel element) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const SizedBox(width: 24),
          ImageViewer(
            Utils.concatImageLink(element.appFavicon) ?? '',
            width: 42,
            height: 42,
            fit: BoxFit.cover,
            borderRadius: BorderRadius.circular(100),
          ),
          const SizedBox(width: 12),
          Text(
            (element.appAlias ?? '').toUpperCaseFirst,
            style: appStyle.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
