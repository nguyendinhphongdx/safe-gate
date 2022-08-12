import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/avatar/avatar_pick_comp.dart';
import 'package:base_pm2/common/core/widget/time/timeline_comp.dart';
import 'package:base_pm2/common/resource/app_resource.dart';
import 'package:base_pm2/screen/widget/time_table/comp/list_time_comp.dart';
import 'package:base_pm2/screen/widget/time_table/time_table_controller.dart';
import 'package:base_pm2/screen/widget/time_table_edit/comp/time_line_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediumLayout extends GetView<TimeTableController> {
  const MediumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          const PickAvatarComp(
            imageSize: Size(80, 80),
            iconSize: Size(20, 20),
            url: 'https://giupviechongdoan.com/wp-content/uploads/2021/01/em-be-gai-dang-yeu.jpg',
            name: 'Đặng Quỳnh Anh',
          ),
          const SizedBox(
            height: 8,
          ),
          const ListTimeComp(),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: appStyle.dividerColor,
            width: double.infinity,
            height: 1,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: TimelineComp(
              indicatorMarginTop: 28,
              hasEndIndicator: false,
              children: [
                TimeChild(
                    startChild: const LeftChild(
                      title: '8:00 AM - 10:00 AM',
                    ),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const RightChild(title: 'Học online', icon: ImageResource.ic_s_online),
                    )),
                TimeChild(
                    startChild: const LeftChild(title: '10:00 AM - 10:30 AM'),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const RightChild(title: 'Giải lao', icon: ImageResource.ic_play_cir),
                    )),
             TimeChild(
                    startChild: const LeftChild(title: '10:00 AM - 10:30 AM'),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const RightChild(title: 'Giải lao', icon: ImageResource.ic_play_cir),
                    )),
             TimeChild(
                    startChild: const LeftChild(title: '10:00 AM - 10:30 AM'),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const RightChild(title: 'Giải lao', icon: ImageResource.ic_play_cir),
                    )),
             TimeChild(
                    startChild: const LeftChild(title: '10:00 AM - 10:30 AM'),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const RightChild(title: 'Giải lao', icon: ImageResource.ic_play_cir),
                    )),
             TimeChild(
                    startChild: const LeftChild(title: '10:00 AM - 10:30 AM'),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const RightChild(title: 'Giải lao', icon: ImageResource.ic_play_cir),
                    )),
                TimeChild(
                    startChild: const LeftChild(title: '10:30 AM - 12:00 PM'),
                    endChild: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: const RightChild(title: 'Học online', icon: ImageResource.ic_s_online),
                    )),
                TimeChild(
                  startChild: const LeftChild(title: '12:00 PM - 02:00 PM'),
                  endChild: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: const RightChild(title: 'Học online', icon: ImageResource.ic_disconnect),
                  ),
                ),
                TimeChild(
                    indicator: InkWellComp(
                  isTransparent: true,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                  onTap: () => controller.editTimeTable(),
                  child: Container(
                      decoration: BoxDecoration(
                          color: ColorResource.primary, borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
