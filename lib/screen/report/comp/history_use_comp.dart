import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/image/image_viewer.dart';
import 'package:base_pm2/common/helper/app_common.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:base_pm2/screen/profile/user_detail_history/violations/violations_controller.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HistoryUseComp extends StatefulWidget {
  const HistoryUseComp({Key? key, this.type, this.startTime, this.size, this.deviceId, this.profileId}) : super(key: key);
  final String? type;
  final DateTime? startTime;
  final int? size;
  final String? deviceId;
  final String? profileId;

  @override
  State<HistoryUseComp> createState() => _HistoryUseCompState();
}

class _HistoryUseCompState extends State<HistoryUseComp> {
  List<ViolationHeaderData> mHeaders = [];

  @override
  void initState() {
    super.initState();
    if (widget.type == ReportBy.TODAY || widget.type == ReportBy.YESTERDAY) return;
    initData();
  }

  void initData() {
    for (int i = 0; i < (widget.size ?? 0); i++) {
      mHeaders.add(ViolationHeaderData(
          id: i,
          dateTime: DateTimeUtils.format(widget.startTime?.add(Duration(days: i)), DateTimeUtils.YYYYMMDD),
          title: DateTimeUtils.format(widget.startTime?.add(Duration(days: i)), DateTimeUtils.DDMMYYYY)));
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Column(children: mHeaders.mapIndexed<Widget>(_buildItem).toList());
  }

  Widget _buildItem(int index, ViolationHeaderData element) {
    return ExpandablePanel(
        collapsed: ExpandableButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              children: [
                Text(element.title ?? '', style: appStyle.textTheme.bodyText1),
                const Expanded(child: SizedBox()),
                const ImageViewer(ImageResource.ic_arrow_down, width: 12, height: 12)
              ],
            ),
          ),
        ),
        expanded: Column(
          children: [
            ExpandableButton(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Row(
                  children: [
                    Text(element.title ?? '', style: appStyle.textTheme.bodyText1),
                    const Expanded(child: SizedBox()),
                    const ImageViewer(ImageResource.ic_arrow_down, width: 12, height: 12)
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
