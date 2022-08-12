import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/sys/api_response.dart';
import 'package:base_pm2/common/core/widget/layout/empty_view.dart';
import 'package:base_pm2/common/core/widget/time/timeline_comp.dart';
import 'package:base_pm2/common/extension/app_extension.dart';
import 'package:base_pm2/common/helper/constant.dart';
import 'package:base_pm2/common/helper/utils.dart';
import 'package:base_pm2/common/local_storage/app_config.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:base_pm2/data/repositories_impl/device/device_repository_impl.dart';
import 'package:base_pm2/domain/use_case/profile/get_violation_by_profile_id_use_case.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:base_pm2/screen/widget/user_list/user_manager.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class TimeLineViolationComp extends StatefulWidget {
  const TimeLineViolationComp({Key? key, this.violationData}) : super(key: key);
  final ViolationHeaderData? violationData;

  @override
  State<TimeLineViolationComp> createState() => _TimeLineViolationCompState();
}

class _TimeLineViolationCompState extends State<TimeLineViolationComp> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    if (widget.violationData?.reportProfileModel != null) return;
    ApiResponse<List<AppAccessParentModel?>?> response = await GetViolationByProfileIdUseCase(
        repository: DeviceRepositoryImpl(),
        profileId: ProfileManager().getProfile().profileId.toString(),
        deviceId: AppConfig().getDeviceId(),
        dateTime: [widget.violationData?.dateTime ?? '']).invoke();
    if (response.err?.code != CodeConstant.OK) return;
    widget.violationData?.accessParentModel =
        response.data?.singleWhereOrNull((element) => element?.date == widget.violationData?.dateTime);

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!Utils.isNotNullAndEmpty(widget.violationData?.accessParentModel?.appAccessParentRetail)) {
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
        children: widget.violationData?.accessParentModel?.appAccessParentRetail
                ?.mapIndexed<TimeChild>(_buildItem)
                .toList() ??
            []);
  }

  @override
  bool get wantKeepAlive => true;

  TimeChild _buildItem(int index, AppAccessParentModel element) {
    return TimeChild(
      startChild: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 24, left: 24),
        child: Text(
          element.date ?? '',
          style: appStyle.textTheme.subtitle1,
        ),
      ),
      endChild: Column(
        children: element.appAccess?.mapIndexed<Widget>(_buildEndItem).toList() ?? [],
      ),
    );
  }

  Widget _buildEndItem(int index, AppAccessModel element) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          const SizedBox(width: 24),
          const ImageViewer(
            ImageResource.img_snap_chat,
            width: 42,
            height: 42,
          ),
          const SizedBox(width: 12),
          Text(
            (element.appName ?? '').toUpperCaseFirst,
            style: appStyle.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
