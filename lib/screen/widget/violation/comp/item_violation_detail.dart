import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/data/model/widget/app/app_access_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ItemViolationDetail extends StatelessWidget {
  const ItemViolationDetail({Key? key, this.violationType}) : super(key: key);
  final AppAccessParentModel? violationType;

  @override
  Widget build(BuildContext context) {
    showLog(violationType?.appAccess?.length);
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: appStyle.dividerColor))),
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 12),
          const Padding(
              padding: EdgeInsets.only(top: 8),
              child: ImageViewer(
                ImageResource.ic_alert_red,
                width: 22,
                height: 22,
              )),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vi phạm quy định sử dụng Internet',
                  style: appStyle.textTheme.bodyText1,
                ),
                // const SizedBox(height: 8),
                Column(children: violationType?.appAccess?.mapIndexed<Widget>(_buildItem).toList() ?? [])
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index, AppAccessModel element) {
    return Container();
    // return ItemViolationDesc(detail: element,time: violationType?.date,);
  }
}

class ItemViolationDesc extends StatelessWidget {
  const ItemViolationDesc({Key? key, this.detail, this.time}) : super(key: key);
  final AppAccessParentModel? detail;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: detail?.appAccess
              ?.map(
                (e) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Truy cập ${e.appName ?? ''}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: appStyle.textTheme.bodyText2?.apply(color: Colors.white.withOpacity(.5)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const ImageViewer(ImageResource.ic_clock_2),
                      const SizedBox(width: 12),
                      Text(
                        time ?? '',
                        style: appStyle.textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              )
              .toList() ??
          [],
    );
  }
}
