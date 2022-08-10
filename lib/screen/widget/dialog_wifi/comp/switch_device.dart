import 'package:base_pm2/common/core/theme/theme_manager.dart';
import 'package:base_pm2/common/core/widget/button/cupertino_swtich_comp.dart';
import 'package:base_pm2/common/resource/color_resource.dart';
import 'package:flutter/material.dart';

class SwitchDevice extends StatelessWidget {
  const SwitchDevice({Key? key, this.onChangeStatus, this.isActive = false, this.title, this.titleStyle}) : super(key: key);
  final Function()? onChangeStatus;
  final bool isActive;
  final String? title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title ?? '',
            style: titleStyle?? appStyle.textTheme.bodyText2?.apply(color: ColorResource.tabIndicator),
          ),
        ),
        CupertinoSwitchComp(
          value: isActive,
          onChanged: (v) => onChangeStatus?.call(),
        ),
      ],
    );
  }
}
