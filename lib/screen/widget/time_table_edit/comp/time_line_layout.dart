// ignore_for_file: prefer_const_constructors, unnecessary_const, avoid_unnecessary_containers

import 'package:base_pm2/common/core/app_core.dart';
import 'package:base_pm2/common/core/widget/time/timeline_comp.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:base_pm2/common/resource/image_resource.dart';
import 'package:flutter/material.dart';

class TimeLineLayout extends StatelessWidget {
  const TimeLineLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TimelineComp(
        hasEndIndicator: false,
        lineSize: 0.5,
        lineColor: Colors.black,
        children: [
          TimeChild(
              startChild: LeftChild(
                title: '8:00 AM - 10:00 AM',
                textColor: ColorResource.secondPrimary.withOpacity(0.5),
              ),
              endChild: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const RightChild(
                    title: 'Học online', icon: ImageResource.ic_s_online, textColor: ColorResource.primary),
              )),
          TimeChild(
              startChild: LeftChild(
                title: '10:00 AM - 10:30 AM',
                textColor: ColorResource.secondPrimary.withOpacity(0.5),
              ),
              endChild: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const RightChild(
                  title: 'Giải lao',
                  icon: ImageResource.ic_play_cir,
                  textColor: ColorResource.primary,
                ),
              )),
          TimeChild(
              startChild: LeftChild(
                title: '10:30 AM - 12:00 PM',
                textColor: ColorResource.secondPrimary.withOpacity(0.5),
              ),
              endChild: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const RightChild(
                    title: 'Học online', icon: ImageResource.ic_s_online, textColor: ColorResource.primary),
              )),
          TimeChild(
            startChild: LeftChild(
              title: '12:00 PM - 02:00 PM',
              textColor: ColorResource.secondPrimary.withOpacity(0.5),
            ),
            endChild: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: const RightChild(
                  title: 'Học online', icon: ImageResource.ic_disconnect, textColor: ColorResource.primary),
            ),
          ),
          TimeChild(
              indicator: InkWellComp(
            isTransparent: true,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
            onTap: () => null,
            child: Container(
                decoration:
                    BoxDecoration(color: ColorResource.primary, borderRadius: BorderRadius.circular(100)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          )),
        ],
      ),
    );
  }
}

class LeftChild extends StatelessWidget {
  const LeftChild({Key? key, this.title, this.textColor}) : super(key: key);
  final String? title;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: const SizedBox()),
        Text(
          title ?? '',
          style: appStyle.textTheme.subtitle1
              ?.apply(color: textColor ?? appStyle.textTheme.bodyText2?.color?.withOpacity(0.5)),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

class RightChild extends StatelessWidget {
  const RightChild(
      {Key? key, this.icon, this.title, this.textColor, this.image, this.width = 36, this.height = 36})
      : super(key: key);

  final String? icon;
  final String? image;
  final String? title;
  final Color? textColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Visibility(
            visible: icon != null,
            child: Expanded(
              child: SvgComp(
                url: icon ?? '',
                width: 22,
                height: 22,
              ),
            ),
          ),
          Visibility(
            visible: image != null,
            child: Expanded(
              child: ImageViewer(
                image ?? '',
                width: width,
                height: height,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title ?? '',
              style: appStyle.textTheme.bodyText2?.apply(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
